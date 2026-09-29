# Justificativas de UI/UX e arquitetura — SomBom

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)  
**Projeto:** SomBom

## 1. Direção visual

O SomBom foi desenhado para ser um aliado técnico e protetor: informa o nível de ruído sem transformar o usuário em fiscal ou expor sua identidade. A interface combina azul-petróleo, associado a confiança e calma, com verde, amarelo e vermelho para comunicar as faixas de intensidade sonora. As cores de alerta aparecem sempre acompanhadas de texto e valor em dB, evitando que a cor seja o único meio de compreensão.

A tipografia sem serifa foi escolhida pela leitura rápida em smartphones e pela boa diferenciação entre números. Títulos curtos, valores em dB destacados e textos de apoio objetivos ajudam Marina a interpretar o resultado no escuro, enquanto a organização mais analítica do mapa atende Ricardo.

## 2. Organização das informações e fluxo

A navegação foi limitada a quatro telas principais, conforme o estudo de caso:

1. **Medidor:** tela inicial, com o valor em dB, classificação do nível e ação principal de um toque.
2. **Mapa colaborativo:** mapa agregado por região, com legenda de intensidade e filtros por período.
3. **Registrar incômodo:** formulário curto com tipo, intensidade percebida e confirmação de anonimato.
4. **Proteção auditiva:** dicas curtas para reduzir a exposição e proteger o sono e a audição.

O fluxo prioritário é abrir o app, tocar em **Iniciar medição** e visualizar o resultado. O acesso ao medidor permanece disponível pelo FAB nas telas principais. Depois da medição, o usuário pode registrar o incômodo sem login; quando estiver offline, o registro fica pendente e é sincronizado posteriormente.

## 3. Componentes, estados e interações

- **Medidor:** estado pronto, medindo, resultado aceitável, atenção e acima do limite.
- **FAB:** ação persistente para retornar ao medidor rapidamente.
- **Mapa:** legenda por faixas, filtros de período e indicação de dados agregados.
- **Formulário:** seleção de tipo de ruído, intensidade percebida, localização aproximada e confirmação de envio anônimo.
- **Sincronização:** estado pendente quando não há conexão e estado sincronizado após o envio.
- **Tema:** alternância entre modo diurno e noturno, com contraste elevado no modo noturno.
- **Feedback:** mensagens de confirmação e erro usam texto claro, sem depender apenas de cor ou animação.

## 4. Acessibilidade e contexto de uso

A prioridade é Marina usando o celular à noite, possivelmente no escuro, cansada e com atenção reduzida. Por isso, os alvos de toque são amplos, o fluxo principal não exige cadastro e o botão de medição tem destaque visual. O modo noturno reduz o brilho de áreas extensas e mantém contraste suficiente para leitura. Textos não ficam sobre o mapa sem fundo de apoio, e os estados críticos combinam cor, rótulo e valor numérico.

A interface evita linguagem acusatória. O registro é apresentado como contribuição anônima para entender o ruído da cidade, não como denúncia nominal. A localização é aproximada e o áudio bruto nunca é armazenado ou transmitido, conforme RF05, RF06 e RF14.

## 5. Relação com pesquisa, benchmark e requisitos

A solução combina a medição rápida observada no benchmark do Decibel X, o registro geolocalizado de canais urbanos e o mapa colaborativo do NoiseTube. O diferencial do SomBom é unir esses recursos com anonimato, modo noturno e um fluxo de até três interações.

As telas representam diretamente as funcionalidades essenciais F01 a F05 e os requisitos RF01 a RF14: medição offline, classificação por faixas, registro anônimo, localização aproximada, mapa filtrável, sincronização posterior, temas, dicas de proteção e acesso rápido pelo FAB. A referência à OMS e à ABNT NBR 10151 aparece como apoio interpretativo, sem apresentar a medição do celular como prova jurídica individual.

## 6. Arquitetura proposta

A arquitetura prevista é mobile-first e offline-first, organizada em camadas:

- **Apresentação:** telas, componentes, navegação, temas e estados de acessibilidade.
- **Domínio:** cálculo/classificação do nível em dB, validação do registro e regras de anonimização.
- **Dados locais:** armazenamento do valor numérico, horário, tipo, intensidade e localização aproximada em uma fila offline.
- **Sincronização:** serviço responsável por enviar registros pendentes quando a conexão retornar.
- **Serviço remoto:** API para receber registros anonimizados e fornecer dados agregados ao mapa.
- **Mapa:** consumo apenas de dados agregados por região, sem exibir o endereço exato de quem contribuiu.

O áudio é processado localmente pelo dispositivo somente durante a medição. A aplicação persiste o resultado numérico e descarta o áudio bruto. Essa separação reduz o risco de privacidade e mantém a função central disponível mesmo sem internet.

## 7. Evolução da baixa para a alta fidelidade

Na baixa fidelidade, a equipe validou a hierarquia das quatro telas, o caminho do medidor até o registro e a presença do mapa como consulta separada. Na alta fidelidade, foram adicionados a identidade visual, a escala de cores, os estados do medidor, o modo noturno, a legenda do mapa, o aviso de anonimato e o feedback de sincronização. A evolução preserva o fluxo curto identificado nas personas e transforma os requisitos em componentes implementáveis.

## 8. Participação individual na Atividade 04

- **Guilherme Santos:** consolidou o fluxo de navegação, a relação com o estudo de caso e a arquitetura proposta; revisou o documento final.
- **Erick Vinícius Lima de Sá:** definiu a hierarquia do medidor e do registro de incômodo a partir da persona Marina; revisou textos e estados do fluxo principal.
- **Emily Rayane Almeida Nascimento:** participou da definição dos textos e conteúdos das telas, organizou a evolução entre baixa e alta fidelidade, conferiu o fluxo de apresentação e os estados das interações, validou o checklist de requisitos da Atividade 04 e consolidou a documentação da entrega no README e no CHANGELOG.
- **Luiz Felipe Katryell Amaral Oliveira Santos:** definiu a representação do mapa colaborativo, filtros e estados de sincronização; conferiu privacidade e requisitos não funcionais.
- **Kailaine Vieira Andrade:** definiu a paleta, tipografia, componentes, modo noturno e critérios de acessibilidade; revisou a coerência visual das telas.

As responsabilidades acima representam a simulação de participação da equipe na consolidação desta etapa. A comprovação formal de autoria deve ser feita pelos próprios integrantes no GitHub, com suas contas institucionais, quando aplicável.
