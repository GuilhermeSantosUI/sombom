# Análise do Estudo de Caso: SomBom

**Disciplina:** Programação para Dispositivos Móveis (GP0015NOT07A)
**Projeto:** SomBom, aplicativo para mapeamento de ruído urbano e saúde

---

## 1. Problema

O problema central que o SomBom pretende ajudar a resolver é a **invisibilidade da poluição sonora urbana**: ela afeta diretamente o sono, a saúde auditiva e o equilíbrio emocional das pessoas, mas quase nunca é medida ou registrada de forma objetiva pelo próprio morador. Hoje, quem se sente incomodado por um ruído (trânsito, obra, vizinho) não tem como comprovar que aquele som ultrapassa um limite aceitável, nem um canal simples para relatar isso sem precisar confrontar diretamente quem está causando o incômodo.

Isso é relevante porque o ruído excessivo é reconhecido (inclusive pela OMS) como fator de risco para insônia, estresse crônico e perda auditiva, mas por ser um incômodo "subjetivo" aos olhos de terceiros, tende a ser desconsiderado enquanto não houver dado concreto por trás da reclamação.

A necessidade principal que a solução deve atender, portanto, não é apenas "medir decibéis", mas transformar uma percepção incômoda e difícil de provar em um dado objetivo e acionável, tanto para o morador individual (que quer entender e registrar o que está sentindo) quanto para quem decide políticas públicas (que precisa de dados agregados para agir).

## 2. Público e usuários

O estudo de caso lista cinco públicos, mas eles se comportam de formas bem diferentes em relação ao app, o que já orientou a escolha de duas personas prioritárias:

- **Moradores urbanos sensíveis ao ruído:** público de uso mais frequente e mais emocional. A relação com o app é de alívio e validação, querem uma prova de que o incômodo que sentem é real. A necessidade principal é medir rápido, de forma confiável, e relatar sem se expor. Usam a solução tipicamente à noite, num momento de vulnerabilidade (tentando dormir).
- **Pais de recém-nascidos:** subgrupo do público sensível ao ruído, com um gatilho de uso ainda mais específico (proteger o sono do bebê), reforçando a importância do modo noturno e da resposta imediata do medidor.
- **Profissionais de saúde:** usam o app de forma indireta, como referência para orientar pacientes. Não são usuários operacionais do dia a dia, mas validam a credibilidade do produto perante o usuário final.
- **Urbanistas:** usuários analíticos. Não usam o medidor propriamente, e sim o mapa agregado. A relação com o app é de consumo de dados para embasar decisões de zoneamento e fiscalização. A necessidade principal é enxergar padrões de ruído por região, e o uso costuma acontecer em horário comercial, num momento de trabalho deliberado, não de urgência.
- **Órgãos de fiscalização ambiental:** semelhante aos urbanistas, mas com uso institucional. Usam os registros como subsídio técnico, não como prova jurídica individual contra alguém. A necessidade é ter uma base histórica de dados para embasar ações de fiscalização, consultada de forma recorrente e planejada, também fora do momento em que o incômodo ocorre.

Essa análise deixa claro que o SomBom precisa servir dois modos de uso muito diferentes na mesma base de dados: um uso rápido, emocional e noturno (moradores) e um uso analítico, recorrente e profissional (urbanistas/fiscalização). É por isso que o estudo de caso já separa isso em duas personas e, no produto, em duas telas com propósitos distintos (medidor vs. mapa).

## 3. Contexto de uso

O estudo de caso deixa vários sinais de contexto que têm implicação direta no design da solução:

- **Ambiente:** uso em janelas, varandas e ruas, ou seja, ambientes externos ou semiabertos, muitas vezes à noite. Isso implica interface com alto contraste e elementos fáceis de tocar sem precisar de precisão visual.
- **Momento de utilização:** predominantemente noturno para o público sensível ao ruído (tentando dormir), e em horário comercial para urbanistas (uso analítico). Isso justifica a existência de um modo noturno dedicado, e não apenas um "dark mode" estético.
- **Condições do usuário:** o morador que abre o app geralmente está incomodado, no escuro, possivelmente já impaciente ou com sono. Não é um usuário disposto a navegar por menus, o que reforça o requisito de resolver a função principal em até 3 interações.
- **Dispositivo:** o app precisa rodar em smartphones básicos com microfone, sem exigir hardware avançado, o que restringe a complexidade dos cálculos de dB e o peso do app.
- **Conectividade:** o uso do medidor deve funcionar totalmente offline, já que o usuário pode estar em uma varanda sem boa conexão ou simplesmente não deve depender de internet para uma função tão básica quanto medir som. O registro de incômodo, por outro lado, pode ser sincronizado depois.
- **Iluminação:** ambientes escuros são o cenário típico de uso, o que exige um FAB de fácil localização no escuro.
- **Nível de atenção:** baixo. O usuário não quer "aprender a usar o app", quer resultado imediato. Isso reforça o fluxo de 3 toques (abrir, medir, ver valor).
- **Situação de urgência:** não é uma emergência no sentido de risco à vida, mas é um incômodo agudo e no momento em que ocorre (o barulho está acontecendo agora), o que também justifica a resposta em tempo real do medidor.
- **Outras condições específicas:** o app precisa funcionar bem tanto para um uso doméstico impulsivo (morador incomodado) quanto para um uso profissional planejado (urbanista, fiscalização), dois perfis de contexto muito diferentes convivendo na mesma base de dados. Isso reforça a necessidade de separar claramente as telas por propósito, em vez de tentar atender os dois perfis numa única experiência genérica.

Esses contextos, somados, indicam que o SomBom precisa ser projetado como uma ferramenta de reação rápida, não como um app de consulta pausada. A exceção é a tela de mapa, que serve a um uso mais deliberado (urbanistas, ou o morador que quer entender o padrão do próprio bairro).

## 4. Objetivo e proposta de valor

Em termos simples, o SomBom se propõe a dar às pessoas uma régua objetiva para um problema que hoje só existe como sensação. O benefício central para o usuário morador é passar de "acho que esse barulho é anormal" para "tenho o dado de que esse barulho ultrapassa o nível aceitável, e posso registrar isso sem precisar brigar com ninguém". Para o usuário profissional (urbanista/fiscalização), o benefício é ter uma base de dados colaborativa e contínua, em vez de depender de denúncias isoladas e sem padrão.

O valor do app, portanto, não está apenas na métrica em dB isoladamente, mas na combinação de medição individual, mapa coletivo e registro anônimo, que juntos dão ao ruído urbano um tratamento parecido ao de um dado de saúde pública, e não de uma queixa pessoal.

## 5. Personalidade, identidade e tom da experiência

As palavras conceituais do estudo de caso (poluição sonora, decibéis, insônia, estresse, zona de silêncio, ruído urbano, ABNT NBR 10151) situam o app entre dois campos: saúde/bem-estar e infraestrutura urbana técnica. Isso explica por que a personalidade definida é técnica, urbana e protetora: o app precisa parecer confiável o suficiente para ser levado a sério por um órgão de fiscalização, mas acolhedor o suficiente para não intimidar um morador comum às 23h tentando dormir.

O tom de interface técnico e cívico reforça essa dualidade: técnico porque os dados precisam ter peso (referência à norma ABNT, valores em dB, gradiente de cores objetivo), e cívico porque a comunicação precisa emancipar o usuário ("você pode agir sobre isso") sem soar acusatória em relação a vizinhos, algo que já está explícito no compromisso ético do projeto.

Já o tom da experiência do usuário é mais pessoal do que o tom de interface: enquanto a interface fala de forma técnica e neutra sobre dados, a experiência como um todo precisa transmitir cuidado com quem está incomodado, principalmente no uso noturno. É a diferença entre "informar um número" e "acolher alguém que não está conseguindo dormir".

A forma como o SomBom deseja ser lembrado é como um aliado silencioso e confiável, não como um fiscal. O usuário deve associar o app à sensação de "finalmente tenho uma prova do que sinto", e não à sensação de estar denunciando alguém.

A frase de posicionamento, *"o termômetro que mede o barulho da cidade e protege o seu silêncio"*, resume bem essa personalidade: um termômetro é neutro e técnico (não julga, apenas mede), mas "protege o seu silêncio" traz o lado protetor e pessoal. Isso deve influenciar toda a solução, evitando dois erros opostos: parecer um brinquedo pouco confiável (perderia o urbanista como usuário) ou parecer um app de fiscalização/denúncia agressivo (afastaria o morador comum e contradiria o compromisso de não punir vizinhos).

## 6. Funcionalidades e características já definidas

| Funcionalidade | Necessidade atendida |
|---|---|
| Medidor de ruído em tempo real com 1 toque | Resposta imediata para o usuário no momento em que o incômodo ocorre, sem fricção |
| Funcionamento offline-first do medidor | Garantir que a função principal não dependa de conectividade, já que o uso ocorre em ambientes domésticos/externos variados |
| Mapa colaborativo com gradiente de cores por região | Dar leitura imediata e visual do nível de ruído agregado, servindo tanto ao morador curioso quanto ao urbanista analítico |
| Registro de incômodo sonoro (horário, tipo, intensidade) | Estruturar o relato do usuário em dado utilizável para fiscalização, em vez de uma queixa informal |
| Anonimato total nos registros | Preservar a privacidade do usuário e evitar que o app vire ferramenta de conflito entre vizinhos |
| Dicas de proteção auditiva | Oferecer valor mesmo fora do momento de incômodo agudo, reforçando o papel educativo/protetor do app |
| FAB de acesso rápido ao "Medir" | Facilitar a localização do botão principal em ambientes escuros, cenário de uso predominante |
| Sincronização posterior dos dados offline | Permitir uso ininterrupto mesmo sem internet, sem perder o registro feito |
| Alternância entre modo diurno e noturno | Adequar a interface aos dois momentos de uso identificados (uso noturno doméstico x uso profissional diurno) |

## 7. Restrições e condições

- **Quantidade de telas:** até 4 telas principais (medidor, mapa, formulário de incômodo, proteção auditiva). Restrição que obriga a equipe a não fragmentar funcionalidades em telas extras, mantendo tudo dentro desse escopo.
- **Número de interações:** a função principal deve ser concluída em até 3 toques (abrir, medir, ver dB), o que restringe qualquer necessidade de login, configuração inicial ou onboarding antes do uso do medidor.
- **Dispositivos:** deve rodar em smartphones básicos com microfone, sem exigir hardware avançado. Restringe o uso de bibliotecas pesadas de processamento de áudio.
- **Versão do sistema operacional:** não especificada pelo estudo de caso nem pela documentação de produto. Fica como definição em aberto para a equipe nas próximas etapas do projeto.
- **Tamanho do aplicativo:** não especificado pelo estudo de caso nem pela documentação de produto. Não há limite formal, mas o requisito de rodar em dispositivos básicos e funcionar offline indica que o app deve ser leve.
- **Privacidade:** proibição explícita de gravar, transmitir ou identificar o usuário nos registros de incômodo, que devem ser sempre anônimos. Restrição ética central para a confiança no app.
- **Armazenamento:** apenas o valor numérico em dB pode ser processado e armazenado, nunca o áudio bruto. Restrição técnica que deve ser respeitada mesmo que facilitasse a precisão da medição.
- **Conectividade:** o medidor deve funcionar 100% offline; apenas a sincronização dos registros de incômodo pode depender de internet.
- **Navegação:** não detalhada pelo estudo de caso além do limite de 4 telas e do fluxo de 3 toques para a função principal. A navegação entre as demais telas (mapa, formulário de incômodo, proteção auditiva) fica em aberto para a equipe definir.
- **Acessibilidade:** necessidade de modo noturno de alto contraste e elementos fáceis de tocar sem precisão visual, já que o uso típico ocorre em ambientes escuros e com o usuário impaciente.
- **Ambiente de utilização:** o app precisa funcionar bem em ambientes externos e semiabertos (varandas, janelas, ruas), o que reforça a exigência de interface legível mesmo com pouca luz e possível reflexo de tela.
- **Documentação obrigatória:** a pasta `/docs` do repositório deve manter o documento de requisitos/personas/pesquisas (com base na ABNT NBR 10151), a justificativa das decisões visuais e um `CHANGELOG.md` atualizado a cada mudança relevante do protótipo.
- **Regras de participação no GitHub:** todos os integrantes devem estar como colaboradores do repositório, e cada um deve ter pelo menos um commit identificável com a conta institucional (@souunit.com.br) por atividade em que participou. Restrição de processo que impacta diretamente a nota individual, não apenas o produto.

## 8. Pontos de atenção

1. **O compromisso de não gravar áudio é o pilar que sustenta a confiança no app.** Se essa promessa não for clara na interface e respeitada tecnicamente, o SomBom perde a legitimidade tanto com o morador (que teme ser espionado) quanto com o órgão de fiscalização (que precisa de um processo eticamente defensável). É o tipo de decisão que, se falhar, compromete o produto inteiro, não um detalhe técnico secundário.

2. **O fluxo de 3 interações para medir o ruído é o teste real de usabilidade do projeto.** Como o uso típico acontece à noite, no escuro, com o usuário incomodado e pouco paciente, qualquer fricção extra (login, permissões mal pedidas, telas de carregamento) derruba a proposta de valor do app. É o requisito mais fácil de "quebrar sem perceber" durante o desenvolvimento, então merece atenção redobrada da equipe.

3. **O equilíbrio de tom entre "protetor do morador" e "ferramenta técnica para fiscalização" precisa ser mantido em todas as telas.** Se a comunicação pender para o lado acusatório, o app pode ser usado como arma contra vizinhos (o que contraria o compromisso ético do projeto); se pender demais para o lado técnico/frio, perde a conexão emocional com quem está sofrendo com o barulho à noite. Esse equilíbrio de tom, definido na seção anterior, precisa ser lembrado em decisões de copy e UI que vão além do que está formalmente especificado nos requisitos.
