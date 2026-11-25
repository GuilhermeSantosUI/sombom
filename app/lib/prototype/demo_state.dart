import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DemoScreen {
  login,
  register,
  feed,
  search,
  detail,
  notifications,
  profile,
  editProfile,
  settings,
  meter,
  map,
  report,
  protection,
}

class DemoReport {
  const DemoReport({
    this.id = '',
    required this.type,
    required this.intensity,
    required this.when,
    required this.note,
    this.regionId = 'copacabana',
    this.level = 62,
    this.author = 'Anônimo',
    this.anonymous = true,
    this.owned = true,
    this.title = '',
    this.measurementId,
  });
  final String id, type, intensity, note, regionId, author, title;
  final String? measurementId;
  final DateTime when;
  final int level;
  final bool anonymous, owned;
  String get displayTitle =>
      title.isEmpty ? '$type em ${DemoState.region(regionId).name}' : title;
  Map<String, dynamic> toJson() => {
    'id': id,
    'measurementId': measurementId,
    'type': type,
    'intensity': intensity,
    'when': when.toIso8601String(),
    'note': note,
    'regionId': regionId,
    'level': level,
    'author': author,
    'anonymous': anonymous,
    'owned': owned,
    'title': title,
  };
  factory DemoReport.fromJson(Map<String, dynamic> j) => DemoReport(
    id: j['id'] as String,
    measurementId: j['measurementId'] as String?,
    type: j['type'] as String,
    intensity: j['intensity'] as String,
    when: DateTime.parse(j['when'] as String),
    note: j['note'] as String,
    regionId: j['regionId'] as String,
    level: j['level'] as int,
    author: j['author'] as String,
    anonymous: j['anonymous'] as bool,
    owned: j['owned'] as bool,
    title: j['title'] as String,
  );
}

class DemoRegion {
  const DemoRegion(this.id, this.name, this.x, this.y);
  final String id, name;
  final double x, y;
}

class DemoComment {
  const DemoComment(this.author, this.text);
  final String author, text;
  Map<String, dynamic> toJson() => {'author': author, 'text': text};
}

class DemoMeasurement {
  const DemoMeasurement({
    required this.id,
    required this.when,
    required this.regionId,
    required this.scenario,
    required this.samples,
  });
  final String id, regionId, scenario;
  final DateTime when;
  final List<int> samples;
  int get minimum => samples.reduce(math.min);
  int get maximum => samples.reduce(math.max);
  double get average => DemoState.energyAverage(samples);
  int get seconds => samples.length;
  Map<String, dynamic> toJson() => {
    'id': id,
    'when': when.toIso8601String(),
    'regionId': regionId,
    'scenario': scenario,
    'samples': samples,
  };
  factory DemoMeasurement.fromJson(Map<String, dynamic> j) => DemoMeasurement(
    id: j['id'] as String,
    when: DateTime.parse(j['when'] as String),
    regionId: j['regionId'] as String,
    scenario: j['scenario'] as String,
    samples: (j['samples'] as List).cast<int>(),
  );
}

/// A single local mock repository powers every screen. No network, microphone or GPS.
class DemoState extends ChangeNotifier {
  DemoState({DateTime Function()? clock}) : clock = clock ?? DateTime.now {
    _seed();
  }
  final DateTime Function() clock;
  String name = 'Rodrigo Mello',
      bio = 'Monitorando ruído no bairro.',
      email = 'rodrigo@sombom.com';
  bool anonymous = true, measuring = false, paused = false;
  int level = 47, theme = 2, avatar = 0, scenario = 0;
  String measurementRegionId = 'copacabana';
  DateTime? _measurementStart;
  final List<int> samples = [];
  final List<DemoMeasurement> measurements = [];
  final List<DemoReport> reports = [];
  final List<DemoReport> _seedReports = [];
  final Set<String> likes = {}, watchedRegions = {'copacabana'};
  final Map<String, List<DemoComment>> _comments = {};
  final Set<int> readNotifications = {};
  bool storageError = false;
  SharedPreferencesAsync? _preferences;
  Future<void> _writes = Future.value();
  int _counter = 0;
  bool _disposed = false;
  static const scenarios = ['Residencial', 'Trânsito', 'Obra'];
  static const types = [
    'Todos',
    'Trânsito',
    'Obra',
    'Vizinho',
    'Música',
    'Outro',
  ];
  static const regions = [
    DemoRegion('copacabana', 'Copacabana', .62, .57),
    DemoRegion('barra', 'Barra da Tijuca', .20, .73),
    DemoRegion('vargas', 'Av. Pres. Vargas', .70, .28),
    DemoRegion('grajau', 'Grajaú', .35, .34),
    DemoRegion('paulista', 'Paulista', .79, .43),
    DemoRegion('ipanema', 'Ipanema', .43, .79),
    DemoRegion('centro', 'Centro', .62, .16),
    DemoRegion('savassi', 'Savassi', .16, .18),
  ];
  static DemoRegion region(String id) =>
      regions.where((r) => r.id == id).firstOrNull ?? regions.first;
  static String classification(num level) => level < 50
      ? 'Silêncio'
      : level <= 70
      ? 'Moderado'
      : 'Alto';
  static double energyAverage(Iterable<int> values) {
    if (values.isEmpty) return 0;
    return 10 *
        math.log(
          values.map((v) => math.pow(10, v / 10)).reduce((a, b) => a + b) /
              values.length,
        ) /
        math.ln10;
  }

  List<DemoReport> get allReports =>
      [...reports, ..._seedReports]..sort((a, b) => b.when.compareTo(a.when));
  DemoReport? report(String id) =>
      allReports.where((r) => r.id == id).firstOrNull;
  String get initials => name
      .trim()
      .split(RegExp(r'\s+'))
      .where((p) => p.isNotEmpty)
      .take(2)
      .map((p) => p[0])
      .join()
      .toUpperCase();
  bool get liked => likes.contains('seed-obras');
  List<String> get comments =>
      (_comments['seed-obras'] ?? []).map((c) => c.text).toList();
  DemoMeasurement? get latestMeasurement => measurements.firstOrNull;
  int get points => reports.length * 10 + measurements.length * 5;
  List<DemoComment> commentsFor(String id) => [
    if (id == 'seed-obras') ...const [
      DemoComment('@CarlosM', 'Também estou ouvindo daqui do 5º andar.'),
      DemoComment('@Marina', 'O ruído começou no início da manhã.'),
    ],
    ...?_comments[id],
  ];
  int likesFor(String id) =>
      (id == 'seed-obras' ? 14 : 0) + (likes.contains(id) ? 1 : 0);
  void _seed() {
    final now = clock();
    final entries = [
      (
        'seed-obras',
        'Obra',
        85,
        'copacabana',
        5,
        'Obras na Via',
        'Barulho de britadeira contínuo na calçada da praia de Copacabana.',
      ),
      (
        'seed-vargas',
        'Trânsito',
        78,
        'vargas',
        90,
        'Trânsito intenso & buzinas',
        'Movimento intenso na avenida durante o fim da tarde.',
      ),
      (
        'seed-parque',
        'Outro',
        42,
        'ipanema',
        20,
        'Uma pausa no parque',
        'Uma área tranquila para descansar do barulho.',
      ),
      (
        'seed-grajau',
        'Vizinho',
        62,
        'grajau',
        1500,
        'Som na vizinhança',
        'Música na região durante a noite.',
      ),
      (
        'seed-barra',
        'Trânsito',
        55,
        'barra',
        45,
        'Trânsito na orla',
        'Fluxo moderado de veículos na região.',
      ),
      (
        'seed-centro',
        'Obra',
        82,
        'centro',
        4200,
        'Manutenção na rua',
        'Obra de manutenção próxima ao centro.',
      ),
      (
        'seed-paulista',
        'Trânsito',
        81,
        'paulista',
        300,
        'Horário de pico',
        'Buzinas e tráfego intenso na avenida.',
      ),
      (
        'seed-savassi',
        'Música',
        72,
        'savassi',
        14000,
        'Evento na praça',
        'Música de um evento demonstrativo.',
      ),
      (
        'seed-antigo',
        'Obra',
        92,
        'grajau',
        60000,
        'Obra anterior',
        'Registro antigo para explorar os filtros por período.',
      ),
    ];
    _seedReports.clear();
    for (final e in entries) {
      _seedReports.add(
        DemoReport(
          id: e.$1,
          type: e.$2,
          intensity: e.$3 > 70
              ? 'Intensa'
              : e.$3 >= 50
              ? 'Moderada'
              : 'Leve',
          when: now.subtract(Duration(minutes: e.$5)),
          note: e.$7,
          regionId: e.$4,
          level: e.$3,
          author: 'Comunidade SomBom',
          anonymous: true,
          owned: false,
          title: e.$6,
        ),
      );
    }
  }

  List<DemoReport> filtered({
    int period = 4,
    String type = 'Todos',
    String? regionId,
  }) {
    final now = clock();
    final from = switch (period) {
      0 => now.subtract(const Duration(hours: 1)),
      1 => DateTime(now.year, now.month, now.day),
      2 => now.subtract(const Duration(days: 7)),
      3 => now.subtract(const Duration(days: 30)),
      _ => DateTime(2000),
    };
    return allReports
        .where(
          (r) =>
              !r.when.isBefore(from) &&
              !r.when.isAfter(now) &&
              (type == 'Todos' || r.type == type) &&
              (regionId == null || r.regionId == regionId),
        )
        .toList();
  }

  void toggleLike([String id = 'seed-obras']) {
    if (!likes.add(id)) likes.remove(id);
    _changed();
  }

  void addComment(String text, {String reportId = 'seed-obras'}) {
    if (text.trim().isEmpty || report(reportId) == null) return;
    (_comments[reportId] ??= []).add(
      DemoComment('@${name.split(' ').first}', text.trim()),
    );
    _changed();
  }

  DemoReport addReport(DemoReport value) {
    final id = value.id.isEmpty
        ? 'local-${clock().microsecondsSinceEpoch}-${_counter++}'
        : value.id;
    final saved = DemoReport(
      id: id,
      type: value.type,
      intensity: value.intensity,
      when: value.when,
      note: value.note,
      regionId: value.regionId,
      level: value.level,
      author: value.anonymous ? 'Anônimo' : name,
      anonymous: value.anonymous,
      owned: true,
      title: value.title,
      measurementId: value.measurementId,
    );
    reports.insert(0, saved);
    _changed();
    return saved;
  }

  void deleteReport(String id) {
    reports.removeWhere((r) => r.id == id);
    _changed();
  }

  void restoreReport(DemoReport value) {
    if (report(value.id) == null) {
      reports.insert(0, value);
      _changed();
    }
  }

  void toggleWatch(String id) {
    if (!watchedRegions.add(id)) watchedRegions.remove(id);
    _changed();
  }

  void markRead(int index) {
    readNotifications.add(index);
    _changed();
  }

  void setTheme(int value) {
    theme = value;
    _changed();
  }

  void setAnonymous(bool value) {
    anonymous = value;
    _changed();
  }

  void updateProfile(String newName, String newBio, String newEmail) {
    name = newName.trim();
    bio = newBio.trim();
    email = newEmail.trim();
    _changed();
  }

  void setAvatar(int value) {
    avatar = value;
    _changed();
  }

  void cycleAvatar() => setAvatar((avatar + 1) % 3);
  void startMeasurement({bool resume = false}) {
    if (!resume) {
      samples.clear();
      _measurementStart = clock();
    }
    measuring = true;
    paused = false;
    if (samples.isEmpty) tickMeasurement();
    _changed(persist: false);
  }

  void tickMeasurement() {
    if (!measuring) return;
    const curves = [
      [43, 47, 45, 50, 46, 42, 49, 44, 52, 47],
      [68, 73, 78, 82, 76, 85, 79, 71, 80, 74],
      [78, 85, 88, 81, 93, 87, 90, 84, 95, 82],
    ];
    level = curves[scenario][samples.length % 10];
    samples.add(level);
    _changed(persist: false);
  }

  void pauseMeasurement() {
    measuring = false;
    paused = samples.isNotEmpty;
    _changed(persist: false);
  }

  DemoMeasurement? finishMeasurement() {
    if (samples.isEmpty) {
      measuring = false;
      paused = false;
      return null;
    }
    if (!measuring && !paused) return latestMeasurement;
    final result = DemoMeasurement(
      id: 'measure-${clock().microsecondsSinceEpoch}-${_counter++}',
      when: _measurementStart ?? clock(),
      regionId: measurementRegionId,
      scenario: scenarios[scenario],
      samples: List.unmodifiable(samples),
    );
    measurements.insert(0, result);
    measuring = false;
    paused = false;
    _changed();
    return result;
  }

  // Backward compatible entry points for the prior milestone.
  void setMeasuring(bool value) {
    if (value) {
      startMeasurement();
    } else {
      finishMeasurement();
    }
  }

  void sample(int value) {
    level = value;
    _changed(persist: false);
  }

  void _changed({bool persist = true}) {
    if (_disposed) return;
    notifyListeners();
    if (persist) _save();
  }

  Map<String, dynamic> snapshot() => {
    'version': 2,
    'name': name,
    'bio': bio,
    'email': email,
    'anonymous': anonymous,
    'theme': theme,
    'avatar': avatar,
    'reports': reports.map((r) => r.toJson()).toList(),
    'measurements': measurements.map((m) => m.toJson()).toList(),
    'likes': likes.toList(),
    'watched': watchedRegions.toList(),
    'read': readNotifications.toList(),
    'comments': _comments.map(
      (k, v) => MapEntry(k, v.map((c) => c.toJson()).toList()),
    ),
  };
  Future<void> restore() async {
    try {
      final preferences = SharedPreferencesAsync();
      final raw = await preferences.getString('sombom.demo.v2');
      if (raw != null) restoreSnapshot(jsonDecode(raw) as Map<String, dynamic>);
      _preferences = preferences;
    } catch (_) {
      storageError = true;
    }
    if (!_disposed) notifyListeners();
  }

  void restoreSnapshot(Map<String, dynamic> j) {
    if (j['version'] != 2) {
      throw const FormatException('Unsupported demo state');
    }
    final loadedReports = (j['reports'] as List)
        .map((v) => DemoReport.fromJson(v as Map<String, dynamic>))
        .toList();
    final loadedMeasurements = (j['measurements'] as List)
        .map((v) => DemoMeasurement.fromJson(v as Map<String, dynamic>))
        .where((m) => m.samples.isNotEmpty)
        .toList();
    final loadedComments = (j['comments'] as Map<String, dynamic>).map(
      (k, v) => MapEntry(
        k,
        (v as List)
            .map((c) => DemoComment(c['author'] as String, c['text'] as String))
            .toList(),
      ),
    );
    name = j['name'] as String;
    bio = j['bio'] as String;
    email = j['email'] as String;
    anonymous = j['anonymous'] as bool;
    theme = (j['theme'] as int).clamp(0, 2);
    avatar = (j['avatar'] as int).clamp(0, 2);
    reports
      ..clear()
      ..addAll(loadedReports);
    measurements
      ..clear()
      ..addAll(loadedMeasurements);
    likes
      ..clear()
      ..addAll((j['likes'] as List).cast<String>());
    watchedRegions
      ..clear()
      ..addAll((j['watched'] as List).cast<String>());
    readNotifications
      ..clear()
      ..addAll((j['read'] as List).cast<int>());
    _comments
      ..clear()
      ..addAll(loadedComments);
  }

  void _save() {
    final prefs = _preferences;
    if (prefs == null) return;
    final raw = jsonEncode(snapshot());
    _writes = _writes
        .then((_) => prefs.setString('sombom.demo.v2', raw))
        .catchError((Object error) {
          storageError = true;
          if (!_disposed) notifyListeners();
        });
  }

  Future<void> get flushed => _writes;
  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
