# ai-toolkit-minions

Contexto de IA do Cursor para os projetos Atende. Este repositório não é a aplicação. A aplicação está em [atende-ai-assistente](https://github.com/alissoncruz/atende-ai-assistente).

Quem abre esta pasta no Cursor recebe as regras de arquitetura, o limite de modelo caro e as skills de módulo e caso de uso.

## Usar no Cursor

1. Clone o repositório e abra a pasta no Cursor: **File → Open Folder**.
2. Aceite o workspace como confiável. Sem isso, o gancho que barra modelo caro em tarefa simples não roda.
3. Abra um chat novo do Agent. Um chat antigo não carrega regras que acabaram de entrar.
4. Confira em **Cursor Settings → Rules** as regras do projeto:
   - `architecture` e `token-economy`, sempre ligadas
   - `java-hexagonal`, quando houver arquivo `.java`
   - `maven`, quando houver `pom.xml`
5. No dia a dia, escolha **Composer** ou **Grok** no seletor do chat. Tarefa simples (typo, um arquivo, formatação, texto curto) fica nesse chat, sem subagente.
6. Antes de uma feature, caso de uso ou módulo novo, o agente usa a skill `plan-feature`, grava o plano em `plans/` com `Status: proposto` e para. O código só começa num chat seguinte, depois que você trocar essa linha para `Status: aceito`. O agente não aceita o plano. Na entrega, uma linha entra no fim de [`features.log`](features.log). Typo, rename e ajuste de um arquivo não passam por plano.
7. Para criar um módulo ou um caso de uso no produto, peça em linguagem normal. As skills `add-module` e `add-use-case` entram sozinhas. Também dá para chamá-las com `/`.

O mapa do que ler em cada tarefa está em [`knowledge/INDEX.md`](knowledge/INDEX.md). O agente deve abrir um arquivo por vez.

## Usar junto com o produto

As regras daqui valem ao abrir este repositório. Para o agente seguir as mesmas regras dentro de `atende-ai-assistente`, publique a cópia na raiz do produto:

```bash
scripts/sync-into-project.sh /caminho/do/atende-ai-assistente
```

O script copia `.cursor/` (regras, skills e gancho). Não copie essa pasta de volta para cá: a fonte é este repositório. Para conferir se a cópia do produto ainda está igual:

```bash
scripts/check-sync.sh /caminho/do/atende-ai-assistente
```

No produto, cole [`templates/AGENTS.project.md`](templates/AGENTS.project.md) como `AGENTS.md` da raiz se quiser o resumo sempre visível no chat.

## O que cada arquivo faz

| Caminho | Para que serve |
| --- | --- |
| `.cursor/rules/architecture.mdc` | Fronteira do monólito modular. Entra em todo chat. |
| `.cursor/rules/token-economy.mdc` | Tarefa simples não usa modelo caro nem subagente. Entra em todo chat. |
| `.cursor/rules/plan-before-feature.mdc` | Feature nova começa pelo plano. Entra em todo chat. |
| `features.log` | Uma linha por feature entregue. Não entra na cópia do sync. |
| `.cursor/skills/plan-feature` | Escreve o plano em `plans/` e não implementa. |
| `.cursor/rules/java-hexagonal.mdc` | Pacotes e domínio sem framework. Entra ao editar Java. |
| `.cursor/rules/maven.mdc` | Parent e `relativePath` do Maven. Entra ao editar `pom.xml`. |
| `.cursor/skills/add-module` | Cria um módulo hexagonal novo. |
| `.cursor/skills/add-use-case` | Cria porta, caso de uso e teste de domínio. |
| `.cursor/hooks/model-cost-guard.py` | Troca ou recusa subagente em modelo caro quando a tarefa é simples. |
| `knowledge/INDEX.md` | Onde buscar cada documento do produto. |

Modelo caro, para o gancho: slug com `opus`, `fable` ou `gpt-5`; slug com `xhigh`, `max` ou `fast`; Sonnet em `high`. Uma tarefa difícil só usa esses modelos se o texto dela tiver, numa linha sozinha, `complexidade: alta` (fronteira entre módulos ou bug sem causa óbvia) ou `modelo-pedido` (a pessoa pediu o modelo pelo nome).

## Alterar o contexto

Edite os arquivos aqui e abra um chat novo para ver o efeito. Se o produto já recebeu uma cópia, rode de novo `scripts/sync-into-project.sh`.
