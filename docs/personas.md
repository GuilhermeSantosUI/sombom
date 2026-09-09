# Personas — SomBom

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)
**Projeto:** SomBom

---

## Persona 1 — Marina Alves (morador urbano sensível ao ruído) ⭐ Prioritária

**Perfil/contexto**
Marina, 29 anos, mora sozinha em um apartamento de dois quartos em uma região mista (residencial e comercial) de uma cidade de médio porte. Trabalha em home office e tem o sono leve. É mãe de primeira viagem de um bebê de 4 meses.

**Objetivos**
- Entender se o barulho que a incomoda (trânsito, obra vizinha, bar próximo) realmente ultrapassa um nível aceitável, ou se é "só impressão".
- Conseguir registrar o incômodo de forma rápida, sem precisar confrontar diretamente vizinhos ou comércios.
- Proteger o sono do bebê, especialmente à noite.

**Necessidades**
- Um jeito simples e imediato de medir o nível de ruído no momento em que ele acontece.
- Um canal para relatar o incômodo sem se identificar.
- Confiança de que o dado medido tem embasamento técnico (não é "achismo do app").

**Dores**
- Sente-se impotente diante do barulho porque não tem prova objetiva de que ele é excessivo.
- Tem medo de causar atrito com vizinhos ao reclamar diretamente.
- Fica exausta e ansiosa com noites maldormidas, tanto dela quanto do bebê.

**Comportamentos**
- Abre o celular no escuro, geralmente entre 22h e 1h, quando o barulho a incomoda ou impede o bebê de dormir.
- Não tem paciência para aprender a usar um app novo nesse momento; quer resultado imediato.
- Costuma desistir de soluções que exigem cadastro, login ou várias etapas antes de resolver o problema.

**Relação com o aplicativo**
Marina é a usuária típica do fluxo de **medição rápida** (medidor + registro de incômodo). Usa o app em momentos de vulnerabilidade emocional, então espera acolhimento e rapidez, não uma ferramenta técnica fria. O modo noturno de alto contraste e o fluxo de 3 toques são pensados diretamente para o cenário de uso dela.

---

## Persona 2 — Ricardo Nogueira (urbanista/técnico de fiscalização ambiental)

**Perfil/contexto**
Ricardo, 42 anos, é urbanista e trabalha na secretaria de planejamento urbano da prefeitura, com atuação também de apoio a órgãos de fiscalização ambiental. Lida diariamente com pedidos de licenciamento, zoneamento e denúncias de perturbação sonora.

**Objetivos**
- Identificar regiões da cidade com histórico recorrente de ruído acima do aceitável, para embasar decisões de zoneamento e fiscalização.
- Substituir denúncias isoladas e não padronizadas por uma base de dados contínua e georreferenciada.
- Justificar tecnicamente ações de fiscalização com base em dados objetivos, não apenas em reclamações pontuais.

**Necessidades**
- Visualizar um mapa agregado de ruído por região, com filtros por período e intensidade.
- Ter confiança de que os dados seguem uma referência técnica reconhecida (ABNT NBR 10151), para poderem embasar decisões oficiais.
- Consultar o histórico de forma recorrente e planejada, não apenas no momento de uma denúncia específica.

**Dores**
- Hoje depende de denúncias informais e não padronizadas, difíceis de cruzar ou comparar entre si.
- Falta de dado contínuo dificulta identificar se um problema é pontual ou recorrente em determinada região.
- Precisa equilibrar decisões técnicas com a ausência de instrumentos de medição cidadã confiáveis.

**Comportamentos**
- Usa o app em horário comercial, de forma deliberada e analítica, não em momentos de urgência.
- Consulta o mapa periodicamente, cruzando os dados com outras informações de zoneamento.
- Não usa o medidor de ruído pessoalmente; interessa-se apenas pelos dados agregados e pelo padrão coletivo.

**Relação com o aplicativo**
Ricardo é o usuário típico da **tela de mapa colaborativo**, consumindo dados que moradores como Marina geraram de forma anônima. Sua relação com o app é de consulta técnica e recorrente, exigindo uma interface clara, objetiva e com respaldo em normas reconhecidas.

---

## Persona prioritária e justificativa

A **persona prioritária é Marina Alves**. A escolha se justifica porque:

1. **Ela representa o uso mais frequente e mais crítico do app.** O fluxo de medição rápida e registro de incômodo é o núcleo do SomBom, definido no estudo de caso como a função que precisa ser resolvida em até 3 toques — se esse fluxo falhar, todo o produto perde valor, inclusive para o público analítico.
2. **O momento de uso dela é o mais restritivo em termos de design.** À noite, no escuro, com pouca paciência, o app precisa funcionar bem sob essas condições; projetar para Marina automaticamente cobre boa parte dos requisitos de acessibilidade e usabilidade do app.
3. **É o comportamento de Marina que gera os dados que Ricardo consome.** Sem moradores medindo e registrando incômodos de forma consistente, não existe mapa colaborativo relevante para o urbanista. Priorizar a experiência de Marina é, indiretamente, também o que viabiliza a proposta de valor para Ricardo.
