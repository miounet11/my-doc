# OpenClaw First-Party Stack

## Status

This file defines the local-first product surface, not the whole operating doctrine.

Current baseline doctrine now lives in:

- `docs/OPENCLAW_BEST_PRACTICES.md`
- `docs/OPENCLAW_OPERATING_CHECKLIST.md`

Use this file for:

- local-first default surfaces
- first-party stack boundaries
- what should stay out of the core for now

## Why this exists

Heavy users often pile on:

- self-improving loops
- proactive tasking
- form automation
- GitHub deploy helpers
- email workflows
- workspace sync

The mistake is turning all of that into a pile of external SaaS dependencies.

OpenClaw should stay local-first and evidence-first.

## First-party defaults

### Proactive queue

- script: `scripts/openclaw-proactive-ops.sh`
- purpose: maintain a local task queue that OpenClaw can keep pushing without waiting for the human each time
- output:
  - `data/system/proactive-queue.jsonl`
  - `data/system/reports/`

### Form automation

- script: `scripts/openclaw-form-automation.sh`
- purpose: store browser form jobs as local specs and operator plans
- output:
  - `data/forms/*.json`
  - `data/forms/*.md`

### GitHub deploy planning

- script: `scripts/openclaw-github-deploy.sh`
- purpose: generate deploy plans and release bundles without assuming a third-party deploy service
- output:
  - `projects/<name>/data/deploy/*.json`
  - `projects/<name>/data/deploy/*.tar.gz`

### Email outbox

- script: `scripts/openclaw-mail-outbox.sh`
- purpose: draft outbound messages locally first, instead of sending directly
- output:
  - `data/outbox/outbox.jsonl`
  - `data/outbox/message-*.md`

### Obsidian sync

- script: `scripts/openclaw-obsidian-sync.sh`
- purpose: sync project state into a local Markdown vault
- output:
  - `projects/<name>/data/knowledge/obsidian-export/*.md`
  - optional vault copy when `OPENCLAW_OBSIDIAN_VAULT` is set

## Principles

- local-first beats clever
- evidence beats claims
- drafts before sends
- exportable Markdown beats lock-in
- OpenClaw should own the control loop, not third-party glue

## Not building yet

- deep Google Workspace mutations
- deep Notion API automation
- direct email sending by default

Those may be useful later, but they are not first-party core.
They add external fragility and credential surface before the local workflow is mature.
