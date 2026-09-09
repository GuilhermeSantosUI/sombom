# Pesquisa: Ruído Urbano e Saúde Auditiva

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)
**Projeto:** SomBom

---

## 1. O problema em números

A poluição sonora urbana é um problema de saúde pública reconhecido, mas pouco mensurado pelo próprio cidadão. Alguns pontos relevantes:

- A **Organização Mundial da Saúde (OMS)** recomenda um limite de **53 dB** para ruído ambiental diurno em áreas residenciais, acima do qual aumentam os riscos de efeitos adversos à saúde, e destaca a exposição a ruído como a segunda maior causa ambiental de problemas de saúde na Europa, atrás apenas da poluição do ar.
- No Brasil, a **norma ABNT NBR 10151** estabelece os níveis de ruído aceitáveis para fins de conforto da comunidade, servindo de referência técnica para o que pode ser considerado "ruído excessivo" em áreas residenciais, mistas e industriais, em horário diurno e noturno.
- A exposição contínua a ruído acima dos limites recomendados está associada a **distúrbios do sono, estresse crônico, hipertensão e perda auditiva induzida por ruído (PAIR)**, segundo pesquisas da área de saúde ambiental e ocupacional.
- Pesquisas de percepção urbana indicam que o ruído é uma das queixas mais recorrentes de moradores de grandes cidades, mas uma das menos formalizadas, já que a maioria das pessoas não sabe a quem recorrer ou como comprovar o incômodo.

## 2. Necessidades e dificuldades dos usuários

A partir do problema identificado e do [estudo de caso do SomBom](estudo-de-caso.md), destacam-se as seguintes necessidades e dificuldades:

- **Falta de prova objetiva:** o morador incomodado com um som sente o problema, mas não tem como demonstrar, de forma numérica, que aquele ruído ultrapassa um limite aceitável.
- **Medo de confronto:** grande parte das pessoas evita denunciar vizinhos ou reclamar diretamente de obras/comércios por receio de retaliação ou desgaste de relação, o que reforça a necessidade de um canal anônimo.
- **Urgência no momento do incômodo:** o problema ocorre "agora" (geralmente à noite, tentando dormir), então qualquer solução que exija cadastro, configuração ou várias etapas perde relevância no momento em que é mais necessária.
- **Ausência de dado agregado para o poder público:** urbanistas e órgãos de fiscalização normalmente dependem de denúncias isoladas e não padronizadas, sem uma base histórica e georreferenciada que ajude a embasar decisões de zoneamento ou fiscalização.
- **Grupos mais sensíveis:** pais de recém-nascidos e pessoas com problemas de sono ou saúde mental são particularmente afetados pelo ruído noturno, reforçando a importância de um modo de uso rápido e de alto contraste para ambientes escuros.

## 3. Dados que podem influenciar o aplicativo

- O limite da OMS (53 dB diurno) e os parâmetros da ABNT NBR 10151 podem servir de referência para as faixas de cor do medidor (ex.: verde/aceitável, amarelo/atenção, vermelho/acima do limite), dando credibilidade técnica ao app.
- O fato de o ruído ser mais incômodo e mais associado a distúrbios de sono à noite reforça a decisão já tomada no estudo de caso de ter um **modo noturno de alto contraste** e um fluxo de medição em até 3 toques.
- O receio de confronto direto reforça a importância do **anonimato total** nos registros de incômodo, já definido como restrição ética do projeto.
- A necessidade de dados agregados por parte de urbanistas e fiscalização reforça o valor do **mapa colaborativo**, que transforma percepções individuais em um dado coletivo e georreferenciado.

## 4. Fontes utilizadas

1. Organização Mundial da Saúde (OMS): *Environmental Noise Guidelines for the European Region*, disponível em who.int.
2. Associação Brasileira de Normas Técnicas: **ABNT NBR 10151**, Acústica, Avaliação do ruído em áreas habitadas, visando o conforto da comunidade.
3. Ministério da Saúde / Fiocruz: publicações sobre poluição sonora e seus efeitos na saúde pública no Brasil.
4. [Estudo de caso do SomBom](estudo-de-caso.md): documento interno do projeto, base para o mapeamento de público, contexto de uso e restrições.

## 5. Três descobertas importantes

1. **Existe um padrão técnico objetivo (OMS + ABNT NBR 10151) que o app pode usar como referência.** Isso significa que o SomBom não precisa inventar seus próprios limites de "ruído aceitável": pode se apoiar em normas reconhecidas, o que aumenta a credibilidade do app tanto para o morador comum quanto para urbanistas e órgãos de fiscalização.
   - **Influência no projeto:** as faixas de cor do medidor e do mapa colaborativo devem refletir esses limites técnicos, e não uma escala arbitrária.

2. **O medo do confronto direto é tão relevante quanto o incômodo sonoro em si.** Boa parte das pessoas não age contra o ruído não porque não se importa, mas porque não quer se indispor com vizinhos.
   - **Influência no projeto:** reforça a decisão de manter o **anonimato total** como restrição inegociável, e não apenas como um detalhe de privacidade, é parte central da proposta de valor.

3. **O ruído tem dois momentos de uso completamente diferentes: reação noturna emocional (morador) e consulta analítica diurna (urbanista/fiscalização).** Não é apenas uma diferença de público, é uma diferença de contexto de uso, urgência e estado emocional.
   - **Influência no projeto:** justifica manter as funcionalidades de medição rápida e de consulta ao mapa como fluxos separados, com tons de comunicação distintos, em vez de uma experiência única genérica para todos os públicos.
