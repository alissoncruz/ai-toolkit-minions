# Plano: log de uma linha por feature

Data: 2026-11-27
Repositório: toolkit
Status: proposto

## Objetivo

Cada feature entregue deixa uma única linha resumida em `features.log`, para haver controle do que foi desenvolvido.

## Fora de escopo

Não substitui o plano em `plans/`. Não registra typo, rename, formatação, POM nem ajuste de um arquivo. Não grava autor, lista de arquivos, diff nem parágrafo. Não muda o plano de `proposto` para `aceito`.

## Módulos

O toolkit ganha `features.log` na raiz e uma obrigação na regra `plan-before-feature` e na skill `plan-feature`. O produto não recebe o arquivo pelo sync: cada repositório guarda o próprio log. A regra, sim, vai na cópia de `.cursor/` quando alguém rodar `scripts/sync-into-project.sh`.

## Passos

1. Criar `features.log` na raiz, sem título. Cada feature é uma linha no fim: `AAAA-MM-DD slug — uma frase do que a feature faz`.
2. Na regra `plan-before-feature`, exigir essa linha no mesmo trabalho que entrega a feature, e só se o plano dessa feature estiver `Status: aceito`. Não reescrever linhas antigas. Uma feature, uma linha, mesmo com vários commits.
3. O chat que só escreve o plano não mexe em `features.log`. Ele deixa no plano a frase exata que o chat seguinte vai copiar.
4. Plano ainda `proposto` não gera linha. Tarefa simples também não.
5. Registrar o arquivo em `knowledge/INDEX.md` e uma frase no `README.md`.

## Como provar

Um plano com `Status: proposto` deixa `features.log` intocado. Com `Status: aceito`, a entrega acrescenta exatamente uma linha no fim e não altera as anteriores. A linha cabe numa linha só e diz o que a feature faz. Typo no README não acrescenta linha.

## Riscos

Dois chats da mesma feature podem gravar a linha duas vezes. A regra vale uma vez, no trabalho que entrega. O sync não copia `features.log`; o log do produto só aparece quando uma feature do produto for entregue.
