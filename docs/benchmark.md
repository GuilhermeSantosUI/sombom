# Benchmark — Soluções Existentes

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)
**Projeto:** SomBom

---

## 1. Decibel X (Sonic Studio)

**Principais funcionalidades**
- Medidor de ruído em tempo real usando o microfone do celular, com gráfico de histórico e nível instantâneo em dB.
- Modo profissional com calibração manual do microfone.
- Exportação de relatórios de medição e alertas de exposição sonora perigosa.

**Pontos positivos**
- Alta precisão percebida e boa reputação entre usuários técnicos.
- Interface com gráficos detalhados, útil para quem já entende de acústica.
- Alertas de exposição prolongada a ruído, reforçando o cuidado com a saúde auditiva.

**Pontos negativos**
- Voltado a um público técnico; a curva de aprendizado é alta para um usuário comum incomodado com barulho à noite.
- Não possui componente colaborativo/social: cada medição fica isolada no aparelho do usuário, sem gerar um mapa coletivo.
- Sem foco em anonimato ou registro de incômodo — é uma ferramenta de medição, não de denúncia ou relato.

**Aspectos de interface/experiência**
- Visual denso, com múltiplos gráficos e números na tela principal, o que aumenta a fricção para um uso rápido e impulsivo.
- Não há diferenciação clara entre modo diurno/noturno pensada para o contexto de uso.

**O que pode ser aproveitado/melhorado**
- Aproveitar a ideia do histórico de medições, mas simplificando a exibição (curva simples, não um dashboard técnico).
- Melhorar drasticamente o tempo até o primeiro resultado (o SomBom deve resolver em até 3 toques, sem calibração manual).

---

## 2. Aplicativos de reclamação urbana tipo "Colab" / canais 156 (prefeituras)

**Principais funcionalidades**
- Canal para o cidadão registrar reclamações e solicitações à prefeitura, incluindo (em algumas cidades) denúncias de perturbação do sossego.
- Acompanhamento do status do chamado (aberto, em análise, resolvido).
- Geolocalização da ocorrência.

**Pontos positivos**
- Já resolvido o problema de levar a reclamação a um canal oficial, capaz de gerar ação institucional.
- Georreferenciamento das ocorrências, permitindo visualizar problemas por bairro/região.

**Pontos negativos**
- Processo burocrático e lento: normalmente exige cadastro, preenchimento de formulário extenso e não é anônimo, o que desestimula o morador que teme confronto com vizinhos.
- Não oferece nenhuma medição objetiva do ruído — a reclamação é apenas textual/subjetiva, sem dado técnico (dB) que a sustente.
- Foco institucional, sem cuidado com a experiência emocional de quem está incomodado no momento do ruído.

**Aspectos de interface/experiência**
- Fluxos genéricos de "abertura de chamado", não pensados especificamente para o contexto de ruído urbano nem para uso noturno/no escuro.
- Pouca ou nenhuma resposta imediata ao usuário; o retorno é institucional e pode levar dias.

**O que pode ser aproveitado/melhorado**
- Aproveitar a lógica de geolocalização das ocorrências para alimentar o mapa colaborativo do SomBom.
- Melhorar a experiência oferecendo anonimato real e um dado objetivo (dB) que hoje esses canais não fornecem, tornando o relato mais rápido e mais confiável tecnicamente.

---

## 3. NoiseTube / plataformas de "ruído colaborativo" (mapeamento cidadão de ruído)

**Principais funcionalidades**
- Medição de ruído pelo celular com envio dos dados para um mapa colaborativo global/regional.
- Visualização de mapas de calor de ruído construídos a partir de contribuições de diversos usuários.
- Em algumas versões, uso voltado a pesquisa acadêmica sobre poluição sonora urbana.

**Pontos positivos**
- Já valida a ideia central do SomBom: um mapa colaborativo de ruído construído a partir de medições dos próprios cidadãos é tecnicamente viável e tem valor para pesquisa/gestão urbana.
- Abordagem de ciência cidadã, o que gera senso de propósito coletivo no uso do app.

**Pontos negativos**
- Projetos muitas vezes acadêmicos, com pouca manutenção, design datado e baixa usabilidade para o público leigo.
- Não possuem, em geral, um fluxo dedicado para registrar o *incômodo* (contexto, horário, tipo de ruído) separado da medição pura — ficam apenas no dado numérico.
- Sem um modo de uso pensado para o momento de vulnerabilidade do morador (ex.: modo noturno de alto contraste, fluxo mínimo de toques).

**Aspectos de interface/experiência**
- Interfaces voltadas a "coleta de dados" e não a acolhimento do usuário; parecem mais uma ferramenta de pesquisa do que um app de uso cotidiano.
- Pouca diferenciação entre o público que mede (morador) e o público que consome os dados agregados (pesquisador/gestor).

**O que pode ser aproveitado/melhorado**
- Aproveitar totalmente a lógica de mapa colaborativo com gradiente de cor por região, já validada por essas soluções.
- Melhorar oferecendo duas experiências claramente distintas dentro do mesmo app: uma tela de medição rápida e emocional (morador) e uma tela de mapa analítico (urbanista/fiscalização), em vez de uma única tela genérica de dados.

---

## O que nosso aplicativo poderá fazer de diferente ou melhor?

O SomBom pode se diferenciar por **unir, em um único app simples, três coisas que hoje estão espalhadas em soluções distintas**: a precisão técnica de um medidor de dB (como o Decibel X), o canal de relato de incômodo com geolocalização (como os apps de reclamação urbana) e o mapa colaborativo de ruído (como o NoiseTube). Nenhuma das soluções analisadas entrega as três coisas juntas, com anonimato garantido e um fluxo de uso pensado para o momento exato em que o incômodo acontece — normalmente à noite, no escuro, com o usuário pouco paciente. Ao restringir a função principal a até 3 toques, manter o registro sempre anônimo e diferenciar claramente o uso noturno do morador do uso analítico diurno do urbanista/fiscalização, o SomBom pode ser mais rápido de usar que um medidor técnico, mais confiável tecnicamente que um canal de reclamação comum, e mais acolhedor que uma ferramenta de ciência cidadã genérica.
