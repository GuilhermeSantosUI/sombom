import 'package:flutter_test/flutter_test.dart';
import 'package:sombom/prototype/demo_state.dart';

void main() {
  final now = DateTime(2026, 11, 13, 18);
  test('map filters select actual records and compute energy average', () {
    final state = DemoState(clock: () => now);
    final recent = state.filtered(period: 0);
    expect(recent.every((r) => now.difference(r.when).inMinutes <= 60), isTrue);
    expect(state.filtered(period: 0, type: 'Obra').map((r) => r.id), [
      'seed-obras',
    ]);
    expect(state.filtered(period: 0, type: 'Música'), isEmpty);
    expect(state.filtered(period: 4).length, greaterThan(recent.length));
    expect(DemoState.energyAverage([60, 80]), closeTo(77.0329, .001));
  });
  test(
    'a report is shared by map, profile and details, deletion is reversible',
    () {
      final state = DemoState(clock: () => now);
      final report = state.addReport(
        DemoReport(
          type: 'Música',
          intensity: 'Intensa',
          when: now,
          note: 'Teste',
          regionId: 'ipanema',
          level: 82,
          anonymous: false,
        ),
      );
      expect(state.report(report.id), same(report));
      expect(state.filtered(period: 0, type: 'Música', regionId: 'ipanema'), [
        report,
      ]);
      expect(report.author, 'Rodrigo Mello');
      expect(state.points, 10);
      state.addComment('Comentário A', reportId: report.id);
      state.addComment('Comentário B', reportId: 'seed-obras');
      expect(state.commentsFor(report.id).map((c) => c.text), ['Comentário A']);
      state.toggleLike(report.id);
      expect(state.likesFor(report.id), 1);
      expect(state.likesFor('seed-obras'), 14);
      state.deleteReport(report.id);
      expect(state.filtered(period: 0, type: 'Música'), isEmpty);
      state.restoreReport(report);
      state.restoreReport(report);
      expect(state.reports.length, 1);
      expect(state.commentsFor(report.id).single.text, 'Comentário A');
    },
  );
  test('pause, resume and finish produce one immutable measurement', () {
    final state = DemoState(clock: () => now)..scenario = 2;
    state.startMeasurement();
    state.tickMeasurement();
    state.tickMeasurement();
    state.pauseMeasurement();
    final count = state.samples.length;
    state.tickMeasurement();
    expect(state.samples.length, count);
    state.startMeasurement(resume: true);
    state.tickMeasurement();
    final result = state.finishMeasurement()!;
    expect(result.samples.length, count + 1);
    expect(result.maximum, greaterThanOrEqualTo(result.minimum));
    state.finishMeasurement();
    expect(state.measurements.length, 1);
    state.startMeasurement();
    state.tickMeasurement();
    expect(result.samples.length, count + 1);
    expect(state.measurements.length, 1);
  });
  test('local snapshot restores linked data without storing passwords', () {
    final state = DemoState(clock: () => now);
    final report = state.addReport(
      DemoReport(
        type: 'Obra',
        intensity: 'Intensa',
        when: now,
        note: 'Teste de restauração',
        regionId: 'centro',
        level: 85,
      ),
    );
    state.addComment('Comentário persistente', reportId: report.id);
    state.toggleLike(report.id);
    state.toggleWatch('grajau');
    state.setTheme(1);
    state.startMeasurement();
    state.finishMeasurement();
    final snapshot = state.snapshot();
    expect(
      snapshot.keys.any((k) => k.toLowerCase().contains('password')),
      isFalse,
    );
    final restored = DemoState(clock: () => now)..restoreSnapshot(snapshot);
    expect(restored.reports.single.id, report.id);
    expect(
      restored.commentsFor(report.id).single.text,
      'Comentário persistente',
    );
    expect(restored.likesFor(report.id), 1);
    expect(restored.watchedRegions, contains('grajau'));
    expect(restored.measurements.length, 1);
    expect(restored.theme, 1);
    expect(
      restored.filtered(period: 0, regionId: 'centro').single.id,
      report.id,
    );
  });
}
