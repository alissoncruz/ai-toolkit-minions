# Plano: skill de API e artefato Swagger

Data: 2026-11-27
Repositório: toolkit
Status: proposto

## Objetivo

Uma skill organiza cada API nova entre backend e frontend, e um artefato gera o Swagger sempre que essa API nasce.

## Fora de escopo

Não cria regra de negócio, tela, cliente HTTP do frontend nem anotação OpenAPI no domínio. Não muda o plano de `proposto` para `aceito`.

## Módulos

O toolkit ganha a skill `add-api`, o script que exporta o contrato e uma linha em `knowledge/INDEX.md`. O produto só entra quando a skill rodar: o adapter HTTP de `apps/api` publica a operação e o arquivo gerado fica em `contracts/openapi.yaml`. Frontend e outros módulos apenas leem esse arquivo.

## Passos

1. Criar `.cursor/skills/add-api/SKILL.md`. A skill vale ao nascer ou mudar um endpoint HTTP.
2. A skill pede, em frases curtas, módulo dono, método, path, request, response, erro e autenticação. O controller fica no adapter. O caso de uso fica na application. O domínio não vê HTTP nem Swagger.
3. Criar `scripts/export-openapi.sh`. Ele lê o OpenAPI publicado por `apps/api` e grava `contracts/openapi.yaml` no produto. O arquivo é gerado. Ninguém edita o YAML à mão.
4. A skill só termina se o path novo estiver nesse YAML. Se o path não aparecer, a skill para e mostra o erro do script.
5. O frontend usa só esse contrato: path, campo e status saem do YAML, sem path inventado no cliente.
6. Registrar a skill em `knowledge/INDEX.md` e uma frase de uso no `README.md`.

## Como provar

Rodar `scripts/export-openapi.sh` apontando para o produto. O YAML contém o path da API nova e não ganha path que o backend não publicou. A skill recusa encerrar sem essa linha. Um teste do domínio segue sem Spring e sem anotação OpenAPI.

## Riscos

O DTO exposto no adapter pode vazar tipo interno se a operação devolver entidade de domínio. O script depende da API subir. A cópia em `.cursor/` do produto só acompanha a skill depois de `scripts/sync-into-project.sh`.
