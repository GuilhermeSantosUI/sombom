# SomBom — estrutura e fluxo de relatos

Projeto Flutter da entrega de estrutura, componentes compartilhados e integração dos relatos. Esta versão inicia diretamente no formulário e permite criar, consultar e excluir registros fictícios, desfazer a exclusão e manter os dados localmente.

## Executar

Requisitos: Flutter compatível com Dart `^3.13.7` e Chrome, emulador ou dispositivo configurado.

```sh
flutter pub get
flutter run -d chrome
```

## Validar

```sh
flutter analyze
flutter test
flutter build web
```

## Estrutura

- `lib/main.dart`: inicialização.
- `lib/prototype/app.dart`: navegação e integração da entrega.
- `lib/prototype/design.dart`: cores, tipografia e componentes.
- `lib/prototype/demo_state.dart`: modelos e repositório local compartilhado.
- `lib/prototype/shared/presentation.dart`: campos e apresentação reutilizável.
- `lib/prototype/modules/relatos/screens.dart`: formulário, validação e confirmação do relato.
- `test/`: testes do repositório e do fluxo de relatos.

Os contratos compartilhados incluem modelos de medição e região para a integração dos próximos módulos. As telas de medidor, mapa, conta e comunidade ainda não estão incluídas nesta entrega. Os registros e valores são simulados; não há captura de áudio, GPS ou envio a servidores.

Os rascunhos são mantidos durante a navegação da sessão. Relatos confirmados e preferências são salvos neste dispositivo. Não use dados pessoais reais nos testes.

## Fluxo de conferência

1. Escolha tipo de ruído, data, horário, região e intensidade.
2. Escreva uma observação fictícia e confirme o registro.
3. Abra o relato pela confirmação ou pela aba Meus registros.
4. Exclua um relato e teste a ação Desfazer.
5. Recarregue o app e consulte os registros preservados.
