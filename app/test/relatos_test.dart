import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sombom/prototype/app.dart';

void main() {
  testWidgets('cria, consulta, exclui e restaura um relato', (tester) async {
    tester.view.physicalSize = const Size(402, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final state = DemoState();
    await tester.pumpWidget(SomBomApp(state: state));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'Observação de teste do fluxo de relatos.',
    );
    final send = find.text('Enviar Relato Anônimo');
    await tester.ensureVisible(send);
    await tester.tap(send);
    await tester.pumpAndSettle();
    expect(state.reports, hasLength(1));
    await tester.tap(find.text('Ver relato'));
    await tester.pumpAndSettle();
    expect(
      find.text('Observação de teste do fluxo de relatos.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Excluir relato'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Excluir'));
    await tester.pumpAndSettle();
    expect(state.reports, isEmpty);
    await tester.tap(find.text('Desfazer'));
    await tester.pumpAndSettle();
    expect(state.reports, hasLength(1));
    expect(tester.takeException(), isNull);
  });
  testWidgets('rascunho permanece ao alternar formulário e registros', (
    tester,
  ) async {
    await tester.pumpWidget(SomBomApp(state: DemoState()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Rascunho preservado');
    await tester.tap(find.text('Meus registros'));
    await tester.pumpAndSettle();
    expect(find.text('Nenhum relato salvo'), findsOneWidget);
    await tester.tap(find.text('Relatar'));
    await tester.pumpAndSettle();
    expect(find.text('Rascunho preservado'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
