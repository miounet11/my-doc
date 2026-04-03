# Content Generation With LLM API

This project now includes a configurable content amplification layer for the finance content factory.

## What it adds

- a typed generation plan (`src/lib/content-generation-plan.ts`)
- a batch generator (`src/lib/content-generation.ts`)
- an API discovery route (`GET /api/content/generate`)
- a batch CLI (`scripts/run-content-generation.mjs`)

## Use cases

- rapidly expand entity overview pages
- generate FAQ packs for companies, sectors, indices, and glossary terms
- create consistent internal-link suggestions across page families
- scale from dozens of seeded records to hundreds or thousands of generated content assets

## Required environment

By default the generator expects an OpenAI-compatible API:

- `OPENAI_API_KEY`

Optional overrides in the plan:

- `baseUrl`
- `model`
- `temperature`
- `maxTokens`

## Example

```bash
OPENAI_API_KEY=sk-... node scripts/run-content-generation.mjs --limit 20 --type company --locale en
```

Generated files will be written under:

```bash
generated/content-factory/content-factory-rapid-scale-v1/
```

## Strategy

The right scaling path is:

1. keep canonical entity records human-validated
2. let the LLM generate reusable page packs around those records
3. store outputs as versionable files
4. re-ingest best outputs back into curated datasets or CMS flows

This keeps the graph honest while still letting content volume expand quickly.
