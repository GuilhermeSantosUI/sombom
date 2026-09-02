[← Voltar ao índice](./index.md)

# 7. Restrições e condições do projeto

- **Quantidade de telas:** até 4 telas principais (medidor, mapa, formulário de incômodo, proteção auditiva). Obriga a equipe a não fragmentar funcionalidades em telas extras, mantendo tudo dentro desse escopo.
- **Número de interações:** a função principal deve ser concluída em até 3 toques (abrir, medir, ver dB), restringindo qualquer necessidade de login, configuração inicial ou onboarding antes do uso do medidor.
- **Dispositivos:** deve rodar em smartphones básicos com microfone, sem exigir hardware avançado, o que restringe o uso de bibliotecas pesadas de processamento de áudio.
- **Privacidade/armazenamento:** proibição explícita de gravar, armazenar ou transmitir áudio; apenas o valor numérico em dB pode ser processado (RNF04). Restrição técnica e ética a ser respeitada mesmo que facilitasse a precisão da medição.
- **Conectividade:** o medidor deve funcionar 100% offline; apenas a sincronização dos registros de incômodo pode depender de internet.
- **Acessibilidade/ambiente de uso:** necessidade de modo noturno de alto contraste, já que o uso típico ocorre em ambientes escuros.
- **Documentação obrigatória:** a pasta `/docs` do repositório deve manter o documento de requisitos/personas/pesquisas (com base na ABNT NBR 10151), a justificativa das decisões visuais e um `CHANGELOG.md` atualizado a cada mudança relevante do protótipo.
- **Regras de participação no GitHub:** todos os integrantes devem estar como colaboradores do repositório, e cada um deve ter pelo menos um commit identificável com a conta institucional (@souunit.com.br) por atividade em que participou. Restrição de processo que impacta diretamente a nota individual, não apenas o produto.
