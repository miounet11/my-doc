# CONTEXT_HUB_ADOPTION_NOTES.md

## Why it matters

`context-hub` is not just another external tool. Its useful idea is that external docs can be treated as versioned knowledge objects instead of noisy search results.

For OpenClaw, the highest-value ideas are:
- doc objects with stable ids
- version/lang-aware fetch
- local annotations on specific docs
- incremental fetch instead of full-page drag
- feedback loops separated from local memory

## Recommended current classification

- intake class: `install-candidate`
- confidence: medium
- adoption stance: **open but evidence-first**
- current human preference: **lean more open, not over-defensive**

This is stronger than ordinary `reference-only` and stronger than pure `absorb-patterns`, because it appears to offer a real missing layer for API / SDK / framework documentation work.

## What to borrow immediately

### 1. Knowledge-object framing
Treat certain external docs as objects with fields like:
- `doc_id`
- `source`
- `version`
- `lang`
- `known_pitfalls`
- `local_notes`
- `last_verified_at`

### 2. Doc-side memory
Not every lesson belongs in `MEMORY.md`. Some belong next to the exact external doc they came from.

### 3. Incremental fetch discipline
When a source has structured references, fetch only the needed subsection/file first instead of dragging full docs into context.

## What not to overclaim yet

- do not claim Context Hub is installed
- do not claim it is already integrated into OpenClaw workflows
- do not claim annotations/feedback loops are active locally

## Suggested OpenClaw mapping

If adopted later, Context Hub should map to:
- external documentation input layer
- doc-side annotation layer
- API/SDK research helper for coding-agent tasks

It should **not** be treated as a replacement for:
- `web_search`
- `web_fetch`
- browser automation
- workspace long-term memory

## First-party control trial

Before any third-party trial, run the same narrow use case through the first-party path:
- `web_fetch`
- `memory`
- local docs protocol / notes

Purpose:
- confirm the actual pain is real
- define a baseline for drift/noise
- make later comparison against Context Hub evidence-based

## Narrow trial candidate

If we move to bounded trial adoption, the cleanest first use case is:
- **API/SDK reference retrieval for coding-agent tasks**

Why this use case:
- high documentation drift risk
- clear success/failure boundary
- overlaps with current pain around noisy web fetches
- can be compared against current `web_fetch + memory` flow

### Initial success signal
- one real coding/research task where objectized docs reduce drift or ambiguity versus ordinary web fetch

### Initial rollback condition
- if the CLI/storage model is opaque, fetched content is not inspectable, or the gain over `web_fetch + memory` is not material, stop at notes-only and do not expand integration

## More open next step

Being more open here means moving past passive admiration and preparing a bounded trial path.

The next practical phase should be:
1. run the narrow use case through the first-party path and record baseline friction
2. inspect CLI/storage behavior
3. define how doc annotations would coexist with workspace memory
4. keep installation claims blocked until local evidence exists

## Next evidence step

Before real installation, verify:
1. CLI stability and local footprint
2. where annotations are stored
3. whether fetched content is inspectable and bounded
4. whether it adds real capability beyond current `web_fetch + memory` flow
5. whether it can be wrapped by a first-party OpenClaw protocol or skill without creating prompt noise
