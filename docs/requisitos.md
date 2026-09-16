# Funcionalidades e Requisitos — SomBom

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)
**Projeto:** SomBom

---

## 1. Funcionalidades

### F01 — Medidor de ruído em tempo real
**Descrição:** Medição do nível de ruído ambiente (em dB) usando o microfone do celular, com 1 toque para iniciar.
**Necessidade atendida:** Marina precisa entender, no momento em que o barulho acontece, se ele ultrapassa um nível aceitável.
**Justificativa:** É a função central do app, base de toda a proposta de valor (transformar percepção em dado objetivo).

### F02 — Funcionamento offline do medidor
**Descrição:** O medidor funciona sem necessidade de conexão à internet.
**Necessidade atendida:** Uso em varandas/ambientes com conexão instável, sem depender de internet para a função mais básica do app.
**Justificativa:** Restrição definida no estudo de caso; garante que a função principal nunca falhe por falta de sinal.

### F03 — Registro de incômodo sonoro
**Descrição:** Formulário rápido para registrar horário, tipo e intensidade percebida do ruído.
**Necessidade atendida:** Marina quer relatar o incômodo de forma estruturada, sem precisar confrontar o vizinho.
**Justificativa:** Transforma uma queixa informal em dado utilizável para fiscalização, conforme identificado na pesquisa.

### F04 — Anonimato nos registros
**Descrição:** Nenhum dado que identifique o usuário é salvo ou exibido junto ao registro de incômodo.
**Necessidade atendida:** Medo de confronto direto com vizinhos, identificado como uma das principais dores da pesquisa.
**Justificativa:** Pilar de confiança do app; sem anonimato, o app pode virar ferramenta de conflito e perder legitimidade.

### F05 — Mapa colaborativo de ruído
**Descrição:** Visualização de um mapa com gradiente de cor por região, agregando as medições e registros de todos os usuários.
**Necessidade atendida:** Ricardo precisa enxergar padrões de ruído por região para embasar decisões de zoneamento e fiscalização.
**Justificativa:** Transforma dados individuais em informação coletiva, sendo o principal diferencial do SomBom em relação ao benchmark analisado.

### F06 — Sincronização posterior dos dados offline
**Descrição:** Registros feitos offline são enviados automaticamente ao servidor assim que houver conexão.
**Necessidade atendida:** Usuário que mede/registra em local sem internet não pode perder o dado coletado.
**Justificativa:** Mantém a integridade da base colaborativa sem exigir conectividade no momento do uso.

### F07 — Alternância entre modo diurno e noturno
**Descrição:** Interface de alto contraste, ativada manualmente ou por horário, pensada para uso no escuro.
**Necessidade atendida:** Marina usa o app predominantemente à noite, no escuro, tentando dormir.
**Justificativa:** Reflete o contexto de uso majoritário identificado no estudo de caso e na pesquisa.

### F08 — Dicas de proteção auditiva
**Descrição:** Conteúdo educativo curto sobre saúde auditiva e formas de se proteger do ruído excessivo.
**Necessidade atendida:** Usuários (moradores e pais de recém-nascidos) querem entender como se proteger, não só medir o problema.
**Justificativa:** Reforça o papel protetor do app mesmo fora do momento de incômodo agudo, alinhado à personalidade definida no estudo de caso.

### F09 — Acesso rápido ao medidor (FAB)
**Descrição:** Botão de ação flutuante sempre visível, levando direto à função de medição.
**Necessidade atendida:** Usuário no escuro, impaciente, precisa localizar a função principal sem esforço.
**Justificativa:** Sustenta o requisito de resolver a função principal em até 3 toques.

---

## 2. Requisitos funcionais

- **RF01 — Medir ruído em tempo real:** O sistema deve permitir que o usuário inicie a medição de ruído com 1 toque, exibindo o valor em dB em tempo real.
- **RF02 — Medir offline:** O sistema deve realizar a medição de ruído sem exigir conexão com a internet.
- **RF03 — Classificar nível de ruído:** O sistema deve indicar visualmente (cor/faixa) se o nível medido está dentro ou acima do limite de referência (OMS/ABNT NBR 10151).
- **RF04 — Registrar incômodo:** O sistema deve permitir que o usuário registre um incômodo sonoro informando horário, tipo de ruído e intensidade percebida.
- **RF05 — Anonimizar registros:** O sistema não deve armazenar nem exibir nenhum dado que identifique o autor de um registro de incômodo.
- **RF06 — Geolocalizar registro:** O sistema deve associar automaticamente a localização aproximada ao registro de incômodo, sem expor o endereço exato do usuário.
- **RF07 — Exibir mapa colaborativo:** O sistema deve exibir um mapa com gradiente de cor representando o nível agregado de ruído por região.
- **RF08 — Filtrar mapa por período:** O sistema deve permitir filtrar os dados do mapa por intervalo de data/horário.
- **RF09 — Sincronizar dados offline:** O sistema deve armazenar localmente os registros feitos sem internet e sincronizá-los automaticamente quando a conexão for restabelecida.
- **RF10 — Alternar modo diurno/noturno:** O sistema deve permitir a alternância entre interface diurna e noturna, manual ou automaticamente por horário.
- **RF11 — Exibir dicas de proteção auditiva:** O sistema deve disponibilizar uma tela com conteúdo educativo sobre saúde auditiva.
- **RF12 — Acessar medidor via FAB:** O sistema deve exibir um botão de acesso rápido (FAB) visível em todas as telas principais, levando diretamente ao medidor.
- **RF13 — Limitar fluxo principal a 3 toques:** O sistema deve permitir que o usuário abra o app, meça o ruído e visualize o resultado em no máximo 3 interações, sem exigir login prévio.
- **RF14 — Não armazenar áudio bruto:** O sistema deve processar o som apenas localmente para calcular o valor em dB, sem gravar ou transmitir o áudio captado.