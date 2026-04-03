# CONTEXT_HUB_FOR_OPENCLAW

## Why it matters

`andrewyng/context-hub` is valuable to OpenClaw not as another memory store, but as a pattern for **curated, versioned, task-time retrieval** of external knowledge.

The important lesson is not “store more docs.”
The important lesson is:
- retrieve only what the current task needs
- prefer curated/versioned docs over vague remembered knowledge
- support local annotation overlays instead of repeatedly forgetting practical gotchas
- keep bootstrap memory small by moving API/library specifics into on-demand retrieval

## What to absorb

### 1. Task-time retrieval over preloaded context
OpenClaw should not bloat active context with large API/framework docs when those can be fetched only when needed.

### 2. Versioned external knowledge
For SDK/API/framework tasks, versioned docs with known provenance are better than stale model memory or generic web search.

### 3. Incremental fetch
Prefer fetching the relevant subsection or reference file rather than the entire corpus.

### 4. Local annotation overlay
The strongest idea is doc-scoped local notes:
- known workarounds
- gotchas
- local integration constraints
- differences between official docs and real project behavior

## What not to confuse it with

Context Hub is **not**:
- durable memory
- handoff continuity
- user preference storage
- project state
- business state

It is a retrieval adapter for external structured knowledge.

## OpenClaw positioning

OpenClaw should hold:
- intent
- routing
- verification
- cross-task judgment
- compact durable doctrine

A context-hub-like layer should hold:
- on-demand external docs
- versioned references
- doc-local annotations

## Recommended OpenClaw direction

1. treat API/framework/library docs as retrieval targets, not bootstrap payloads
2. add or emulate a `get-api-docs` / `context-hub-retrieval` skill
3. keep local annotations near the doc identity, not inside durable bootstrap memory
4. promote only stable cross-task lessons into durable doctrine
5. preserve a strict boundary between external docs, local annotations, and long-term memory

## Durable lessons

- Necessary knowledge beats preloaded knowledge volume.
- Externalization beats prompt inflation.
- Retrieval plus annotation is often better than memorization.
- Raw docs should remain external until a stable rule is proven useful across tasks.
