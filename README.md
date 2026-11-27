# ai-toolkit-minions

Repositório exclusivo de contexto de IA do Atende. Regras, skills e o gancho de modelo ficam aqui. A aplicação continua em [atende-ai-assistente](https://github.com/alissoncruz/atende-ai-assistente).

Abra esta pasta no Cursor. As regras em `.cursor/rules` passam a valer neste repositório.

Para publicar a mesma cópia num produto:

```bash
scripts/sync-into-project.sh /caminho/do/produto
```

## O que entra no prompt

Sempre, e por isso fica curto:

- `.cursor/rules/architecture.mdc`
- `.cursor/rules/token-economy.mdc`

Só ao editar o arquivo correspondente:

- `java-hexagonal.mdc` em `**/*.java`
- `maven.mdc` em `**/pom.xml`

Skills `add-module` e `add-use-case` carregam quando a tarefa é criar módulo ou caso de uso no produto. O mapa de leitura está em `knowledge/INDEX.md`. Abra um arquivo por tarefa.

## Modelos em tarefa simples

Tarefa simples não usa modelo caro e não abre subagente para isso.

O seletor do chat continua com quem está na conversa. O hook em `.cursor/hooks/model-cost-guard.py` cobre subagente:

- `preToolUse` no `Task` troca modelo caro por `composer-2.5` quando a tarefa não está marcada como complexa.
- `subagentStart` recusa o subagente se o modelo resolvido ainda for caro.

Marca, numa linha só do texto da tarefa, apenas nestes casos:

- `complexidade: alta` para fronteira entre módulos ou bug sem causa óbvia.
- `modelo-pedido` quando a pessoa pediu um modelo pelo nome.

Caro, para este gancho: slug com `opus`, `fable` ou `gpt-5`; slug com `xhigh`, `max` ou `fast`; Sonnet em `high`, `xhigh` ou `max`.

Para o dia a dia, escolha Composer ou Grok no seletor. Um chat já aberto em Opus continua nesse modelo; o gancho impede um segundo modelo caro numa tarefa simples.
