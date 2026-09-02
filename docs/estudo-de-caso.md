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
- **Urbanistas:** usuários analíticos. Não usam o medidor propriamente, e sim o mapa agregado. A relação com o app é de consumo de dados para embasar decisões de zoneamento e fiscalização.
- **Órgãos de fiscalização ambiental:** semelhante aos urbanistas, mas com uso institucional. Usam os registros como subsídio técnico, não como prova jurídica individual contra alguém.

Essa análise deixa claro que o SomBom precisa servir dois modos de uso muito diferentes na mesma base de dados: um uso rápido, emocional e noturno (moradores) e um uso analítico, recorrente e profissional (urbanistas/fiscalização). É por isso que o produto separa isso em duas telas com propósitos distintos (medidor vs. mapa).

## 3. Contexto de uso

- **Ambiente:** uso em janelas, varandas e ruas, em ambientes externos ou semiabertos, muitas vezes à noite. Implica interface com alto contraste e elementos fáceis de tocar sem precisar de precisão visual.
- **Momento de utilização:** predominantemente noturno para o público sensível ao ruído (tentando dormir), e em horário comercial para urbanistas (uso analítico). Justifica um modo noturno dedicado, e não apenas um "dark mode" estético.
- **Condições do usuário:** o morador que abre o app geralmente está incomodado, no escuro, possivelmente impaciente ou com sono. Não é um usuário disposto a navegar por menus, o que reforça o requisito de resolver a função principal em até 3 interações (RNF01).
- **Dispositivo:** o app precisa rodar em smartphones básicos com microfone, sem exigir hardware avançado, o que restringe a complexidade dos cálculos de dB e o peso do app.
- **Conectividade:** o uso do medidor deve funcionar totalmente offline (RF03); o registro de incômodo pode ser sincronizado depois (RF09).
- **Iluminação:** ambientes escuros são o cenário típico de uso, exigindo um FAB de fácil localização no escuro (RF08).
- **Nível de atenção:** baixo. O usuário quer resultado imediato, não aprender a usar o app, o que reforça o fluxo de 3 toques (abrir, medir, ver valor).
- **Situação de urgência:** não é uma emergência de risco à vida, mas é um incômodo agudo e no momento em que ocorre, o que também justifica a resposta em tempo real do medidor.

Esses contextos, somados, indicam que o SomBom precisa ser projetado como uma ferramenta de reação rápida, não como um app de consulta pausada. A exceção é a tela de mapa, que serve a um uso mais deliberado (urbanistas, ou o morador que quer entender o padrão do próprio bairro).

## 4. Objetivo e proposta de valor

O SomBom se propõe a dar às pessoas uma régua objetiva para um problema que hoje só existe como sensação. O benefício central para o usuário morador é passar de "acho que esse barulho é anormal" para "tenho o dado de que esse barulho ultrapassa o nível aceitável, e posso registrar isso sem precisar brigar com ninguém". Para o usuário profissional (urbanista/fiscalização), o benefício é ter uma base de dados colaborativa e contínua, em vez de depender de denúncias isoladas e sem padrão.

O valor do app não está apenas na métrica em dB isoladamente, mas na combinação de medição individual, mapa coletivo e registro anônimo, que juntos dão ao ruído urbano um tratamento parecido ao de um dado de saúde pública, e não de uma queixa pessoal.

## 5. Personalidade, identidade e tom da experiência

As palavras conceituais do estudo de caso (poluição sonora, decibéis, insônia, estresse, zona de silêncio, ruído urbano, ABNT NBR 10151) situam o app entre dois campos: saúde/bem-estar e infraestrutura urbana técnica. Isso explica por que a personalidade definida é técnica, urbana e protetora: o app precisa parecer confiável o suficiente para ser levado a sério por um órgão de fiscalização, mas acolhedor o suficiente para não intimidar um morador comum às 23h tentando dormir.

O tom de interface técnico e cívico reforça essa dualidade: técnico porque os dados precisam ter peso (referência à norma ABNT, valores em dB, gradiente de cores objetivo), e cívico porque a comunicação precisa emancipar o usuário ("você pode agir sobre isso") sem soar acusatória em relação a vizinhos, algo já explícito no compromisso ético do projeto (RNF07).

A frase de posicionamento, *"o termômetro que mede o barulho da cidade e protege o seu silêncio"*, resume essa personalidade: um termômetro é neutro e técnico (não julga, apenas mede), mas "protege o seu silêncio" traz o lado protetor e pessoal. Isso deve influenciar toda a solução, evitando dois erros opostos: parecer um brinquedo pouco confiável (perderia o urbanista como usuário) ou parecer um app de fiscalização/denúncia agressivo (afastaria o morador comum e contradiria o compromisso de não punir vizinhos).

## 6. Funcionalidades já definidas

| Funcionalidade | Necessidade atendida |
|---|---|
| Medidor de ruído em tempo real com 1 toque (RF01, RF02) | Resposta imediata para o usuário no momento em que o incômodo ocorre, sem fricção |
| Funcionamento offline-first do medidor (RF03) | Garantir que a função principal não dependa de conectividade, já que o uso ocorre em ambientes domésticos/externos variados |
| Mapa colaborativo com gradiente de cores por região (RF04) | Dar leitura imediata e visual do nível de ruído agregado, servindo tanto ao morador curioso quanto ao urbanista analítico |
| Registro de incômodo sonoro (horário, tipo, intensidade) (RF05) | Estruturar o relato do usuário em dado utilizável para fiscalização, em vez de uma queixa informal |
| Anonimato total nos registros (RF06) | Preservar a privacidade do usuário e evitar que o app vire ferramenta de conflito entre vizinhos |
| Dicas de proteção auditiva (RF07) | Oferecer valor mesmo fora do momento de incômodo agudo, reforçando o papel educativo/protetor do app |
| FAB de acesso rápido ao "Medir" (RF08) | Facilitar a localização do botão principal em ambientes escuros, cenário de uso predominante |
| Sincronização posterior dos dados offline (RF09) | Permitir uso ininterrupto mesmo sem internet, sem perder o registro feito |
| Alternância entre modo diurno e noturno (RF10) | Adequar a interface aos dois momentos de uso identificados (uso noturno doméstico x uso profissional diurno) |

## 7. Restrições e condições do projeto

- **Quantidade de telas:** até 4 telas principais (medidor, mapa, formulário de incômodo, proteção auditiva). Obriga a equipe a não fragmentar funcionalidades em telas extras, mantendo tudo dentro desse escopo.
- **Número de interações:** a função principal deve ser concluída em até 3 toques (abrir, medir, ver dB), restringindo qualquer necessidade de login, configuração inicial ou onboarding antes do uso do medidor.
- **Dispositivos:** deve rodar em smartphones básicos com microfone, sem exigir hardware avançado, o que restringe o uso de bibliotecas pesadas de processamento de áudio.
- **Privacidade/armazenamento:** proibição explícita de gravar, armazenar ou transmitir áudio; apenas o valor numérico em dB pode ser processado (RNF04). Restrição técnica e ética a ser respeitada mesmo que facilitasse a precisão da medição.
- **Conectividade:** o medidor deve funcionar 100% offline; apenas a sincronização dos registros de incômodo pode depender de internet.
- **Acessibilidade/ambiente de uso:** necessidade de modo noturno de alto contraste, já que o uso típico ocorre em ambientes escuros.
- **Documentação obrigatória:** a pasta `/docs` do repositório deve manter o documento de requisitos/personas/pesquisas (com base na ABNT NBR 10151), a justificativa das decisões visuais e um `CHANGELOG.md` atualizado a cada mudança relevante do protótipo.
- **Regras de participação no GitHub:** todos os integrantes devem estar como colaboradores do repositório, e cada um deve ter pelo menos um commit identificável com a conta institucional (@souunit.com.br) por atividade em que participou. Restrição de processo que impacta diretamente a nota individual, não apenas o produto.

## 8. Pontos de atenção

1. **O compromisso de não gravar áudio (RNF04) é o pilar que sustenta a confiança no app.** Se essa promessa não for clara na interface e respeitada tecnicamente, o SomBom perde a legitimidade tanto com o morador (que teme ser espionado) quanto com o órgão de fiscalização (que precisa de um processo eticamente defensável). É o tipo de decisão que, se falhar, compromete o produto inteiro, não um detalhe técnico secundário.

2. **O fluxo de 3 interações para medir o ruído é o teste real de usabilidade do projeto.** Como o uso típico acontece à noite, no escuro, com o usuário incomodado e pouco paciente, qualquer fricção extra (login, permissões mal pedidas, telas de carregamento) derruba a proposta de valor do app. É o requisito mais fácil de "quebrar sem perceber" durante o desenvolvimento, então merece atenção redobrada da equipe.

3. **O equilíbrio de tom entre "protetor do morador" e "ferramenta técnica para fiscalização" precisa ser mantido em todas as telas.** Se a comunicação pender para o lado acusatório, o app pode ser usado como arma contra vizinhos (o que contraria o compromisso ético do projeto); se pender demais para o lado técnico/frio, perde a conexão emocional com quem está sofrendo com o barulho à noite. Esse equilíbrio de tom precisa ser lembrado em decisões de copy e UI que vão além do que está formalmente especificado nos requisitos.
