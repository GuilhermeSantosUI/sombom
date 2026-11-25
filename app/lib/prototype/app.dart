import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'demo_state.dart';
import 'design.dart';
export 'demo_state.dart' show DemoScreen, DemoState;
part 'shared/presentation.dart';
part 'modules/relatos/screens.dart';

class SomBomApp extends StatefulWidget {
  const SomBomApp({super.key, this.state});
  final DemoState? state;
  @override
  State<SomBomApp> createState() => _SomBomAppState();
}

class _SomBomAppState extends State<SomBomApp> {
  late final DemoState data = widget.state ?? DemoState();
  final _messenger = GlobalKey<ScaffoldMessengerState>();
  final List<DemoScreen> _history = [DemoScreen.report];
  final note = TextEditingController();
  late BuildContext _ui;
  bool _ready = false;
  String? _formError;
  String _reportRegionId = 'copacabana', _selectedReportId = '';
  int _reportType = 0, _intensity = 0;
  late DateTime _reportTime = data.clock();
  DemoMeasurement? _reportMeasurement;
  DemoScreen get screen => _history.last;

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      _ready = true;
    } else {
      unawaited(
        data.restore().then((_) {
          if (mounted) _update(() => _ready = true);
        }),
      );
    }
  }

  @override
  void dispose() {
    note.dispose();
    if (widget.state == null) data.dispose();
    super.dispose();
  }

  void _update(VoidCallback change) => setState(change);
  void _go(DemoScreen next) {
    FocusManager.instance.primaryFocus?.unfocus();
    _update(() => _history.add(next));
  }

  void _back() {
    FocusManager.instance.primaryFocus?.unfocus();
    _update(() {
      if (_history.length > 1) {
        _history.removeLast();
      } else {
        _history[0] = DemoScreen.report;
      }
    });
  }

  Text _text(
    String text, {
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
  }) => Text(
    text,
    style: Design.text(size, weight: weight, color: color, height: height),
  );
  Widget _gap(double value) => SizedBox(height: value);
  Widget _scroll(List<Widget> children, {double padding = 16}) =>
      SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: data,
    builder: (context, _) => MaterialApp(
      title: 'SomBom',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messenger,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Design.purple),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Design.purple,
          secondary: Design.magenta,
          surface: Design.surface,
        ),
        scaffoldBackgroundColor: Design.background,
      ),
      themeMode: data.theme == 0
          ? ThemeMode.system
          : data.theme == 1
          ? ThemeMode.light
          : ThemeMode.dark,
      home: Builder(
        builder: (context) {
          _ui = context;
          return PopScope(
            canPop: _history.length <= 1,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) _back();
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: _text(
                  screen == DemoScreen.detail
                      ? 'Detalhes do Relato'
                      : screen == DemoScreen.feed
                      ? 'Meus registros'
                      : 'Registrar Incômodo',
                  size: 18,
                  weight: FontWeight.w700,
                ),
                leading: screen == DemoScreen.detail
                    ? IconButton(
                        tooltip: 'Voltar',
                        onPressed: _back,
                        icon: const Icon(CupertinoIcons.chevron_left),
                      )
                    : null,
                actions: [
                  IconButton(
                    tooltip: 'Alternar tema',
                    onPressed: () => data.setTheme(data.theme == 1 ? 2 : 1),
                    icon: const Icon(CupertinoIcons.moon),
                  ),
                ],
              ),
              body: SafeArea(
                child: !_ready
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 680),
                          child: switch (screen) {
                            DemoScreen.detail => _recordDetail(),
                            DemoScreen.feed => _records(),
                            _ => _report(),
                          },
                        ),
                      ),
              ),
              bottomNavigationBar: NavigationBar(
                selectedIndex: screen == DemoScreen.report ? 0 : 1,
                onDestinationSelected: !_ready
                    ? null
                    : (index) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        _update(
                          () => _history
                            ..clear()
                            ..add(
                              index == 0 ? DemoScreen.report : DemoScreen.feed,
                            ),
                        );
                      },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(CupertinoIcons.square_pencil),
                    label: 'Relatar',
                  ),
                  NavigationDestination(
                    icon: Icon(CupertinoIcons.doc_text),
                    label: 'Meus registros',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  Widget _records() => _scroll([
    if (data.storageError) ...[
      _text(
        'Não foi possível acessar o armazenamento. Os registros desta sessão continuam disponíveis.',
        color: Design.red,
      ),
      _gap(16),
    ],
    if (data.reports.isEmpty) ...[
      _text('Nenhum relato salvo', size: 20, weight: FontWeight.w700),
      _gap(8),
      _text('Registre um incômodo fictício para testar o fluxo.'),
      _gap(16),
      DemoButton(
        'Criar relato',
        onPressed: () => _update(
          () => _history
            ..clear()
            ..add(DemoScreen.report),
        ),
      ),
    ],
    ...data.reports.map(
      (report) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TapTarget(
          label: 'Abrir relato ${report.id}',
          onTap: () {
            _selectedReportId = report.id;
            _go(DemoScreen.detail);
          },
          child: DemoCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _text(report.displayTitle, weight: FontWeight.w700),
                      _gap(6),
                      _text(
                        '${report.intensity} · ${DemoState.region(report.regionId).name}',
                        size: 12,
                        color: Design.muted,
                      ),
                    ],
                  ),
                ),
                DbBadge('${report.level} dB', color: noiseColor(report.level)),
              ],
            ),
          ),
        ),
      ),
    ),
  ]);
  Widget _recordDetail() {
    final report = data.report(_selectedReportId);
    if (report == null) {
      return _scroll([
        _text('Este relato não está mais disponível.'),
        TextButton(onPressed: _back, child: const Text('Voltar')),
      ]);
    }
    return _scroll([
      DemoCard(
        child: Row(
          children: [
            Expanded(
              child: _text(
                '${report.level} dB',
                size: 36,
                weight: FontWeight.w800,
                color: noiseColor(report.level),
              ),
            ),
            DbBadge(
              DemoState.classification(report.level),
              color: noiseColor(report.level),
            ),
          ],
        ),
      ),
      _gap(16),
      _text(report.displayTitle, size: 20, weight: FontWeight.w700),
      _gap(10),
      _text(
        '${report.when.day}/${report.when.month}/${report.when.year} · ${report.when.hour.toString().padLeft(2, '0')}:${report.when.minute.toString().padLeft(2, '0')}',
      ),
      _gap(8),
      _text(
        report.anonymous ? 'Relato anônimo' : report.author,
        size: 12,
        color: Design.muted,
      ),
      _gap(16),
      _text(report.note.isEmpty ? 'Sem observação adicional.' : report.note),
      _gap(24),
      DemoButton(
        'Excluir relato',
        destructive: true,
        onPressed: () => _deleteRecord(report),
      ),
    ]);
  }

  Future<void> _deleteRecord(DemoReport report) async {
    final confirmed = await showDialog<bool>(
      context: _ui,
      builder: (context) => AlertDialog(
        title: const Text('Excluir este relato?'),
        content: const Text(
          'Você poderá desfazer a exclusão pela mensagem de confirmação.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    data.deleteReport(report.id);
    _update(
      () => _history
        ..clear()
        ..add(DemoScreen.feed),
    );
    _messenger.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Relato excluído.'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () => data.restoreReport(report),
          ),
        ),
      );
  }
}
