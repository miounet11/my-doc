# Knowledge Work Plugins Implementation Plan

## Goal

Adopt the strongest product patterns from Anthropic's `knowledge-work-plugins` without turning AibrowserAtlas into a generic plugin shell.

The target is:

- keep the current chat-first UX
- keep the current real artifact pipeline
- add domain packs as first-class product units
- add retrieval orchestration, tiered memory, and structured workflows behind the existing chat surface
- avoid exposing fake capability surfaces before the backend path is real

## Current State

`chat-mirror` already has a stronger substrate than a typical chat app:

- persisted sessions, archive, pinning, and import/export
- session, workspace, and agent memory scopes
- knowledge library plus session-level knowledge linking
- background knowledge import jobs
- automatic agent routing with trace metadata
- unified search across sessions, knowledge, and memories
- real artifact generation for `presentation`, `document`, `website`, `story`, `spreadsheet`, `contract`, `research`, `finance`, `playbook`, `design`, `schedule`, and `visualization`
- contextual ledger data already exposed in replies and the right rail

Relevant code:

- server routing and context assembly: [server/src/index.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/index.ts)
- agent and skill records: [server/src/agents.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/agents.ts)
- knowledge ingestion and ranking: [server/src/knowledge.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/knowledge.ts)
- current workbench surface: [web/src/App.tsx](/Users/lu/.openclaw/workspace/projects/chat-mirror/web/src/App.tsx)

## What Anthropic Gets Right

The reference repo is useful for product structure, not for literal cloning.

Core patterns worth porting:

- domain-first packaging instead of one giant agent surface
- tiny manifest layer per domain
- optional connector declarations separated from workflow logic
- many narrow skills with explicit job-to-be-done boundaries
- structured output contracts and review checklists
- search strategy as orchestration, not just lookup
- synthesis with source attribution, conflict handling, and confidence
- tiered memory: hot working memory plus deep reference memory
- bootstrap and update flows kept separate
- graceful degradation when connectors are missing

## Gap Analysis

### 1. We have agents and skills, but not packs

Current system:

- agents and skills are editable records
- routing can select an agent
- capabilities are exposed mostly as mode buttons and endpoints

Missing:

- pack manifest grouping workflows, outputs, safety, and connector compatibility
- curated default packs with clear opinions

### 2. Search is unified, but not orchestrated

Current system:

- `/api/search` fans out into sessions, knowledge, and memories
- result ranking is mostly lexical and local

Missing:

- query classification
- source-specific search plans
- weighted ranking by freshness, authority, and completeness
- dedupe and synthesis
- confidence scoring and conflict surfacing

### 3. Memory exists, but not as a product primitive

Current system:

- memory rows support `workspace`, `session`, and `agent`
- context ledger already tracks memory hits

Missing:

- hot memory vs deep memory split
- promotion, demotion, compaction, and rollover policies
- explicit memory summaries per project/session
- visible memory value without exposing internal mechanics

### 4. Artifact modes exist, but many still behave as generation endpoints

Current system:

- backend can emit real files
- frontend exposes many live capabilities

Missing:

- per-domain workflow contract
- required inputs and clarifying questions
- quality checklist before generation
- explicit output schema and revision loop

### 5. No connector contract layer

Current system:

- no first-class connector registry in product config

Missing:

- optional connector declarations by pack
- pack behavior that improves when connectors are present
- honest degraded mode when connectors are absent

## Target Architecture

### Layer 1: Pack Manifest

Add a first-class pack layer above agents and skills.

Each pack should define:

- `id`
- `name`
- `description`
- `category`
- `icon`
- `defaultAgentId`
- `supportedWorkflows`
- `supportedArtifacts`
- `optionalConnectors`
- `requiredContextFields`
- `safetyNotes`
- `degradedBehavior`

Recommended storage:

- initial bootstrap as checked-in JSON under `server/src/packs/`
- later mirrored into database if end-user customization is needed

### Layer 2: Workflow Contracts

Each visible capability should map to a workflow contract, not just a prompt path.

Each workflow should define:

- trigger intents
- clarification fields
- context assembly rules
- accepted sources
- output schema
- acceptance checklist
- follow-up actions

Example:

- `product-management.write-spec`
- `enterprise-search.answer-question`
- `legal.review-contract`
- `data.build-dashboard`
- `finance.variance-analysis`

### Layer 3: Retrieval Orchestrator

Build a search orchestration layer in front of current memory and knowledge search.

Pipeline:

1. classify query type
2. generate per-source search plan
3. execute sources in parallel
4. score by relevance, freshness, authority, completeness
5. dedupe overlapping evidence
6. synthesize answer with confidence and citations

This should sit behind both:

- reply context building
- explicit search UI in the right drawer

### Layer 4: Tiered Memory

Refactor current memory product semantics into:

- `working memory`: active session/project truths needed often
- `reference memory`: durable facts, glossary, preferences, operating rules
- `archived memory`: compressed long-tail history

Required controls:

- promote important session facts into working memory
- compact stale working memory into archived summaries
- export working + deep memory as a portable handoff bundle

### Layer 5: Connector Registry

Introduce an optional connector model without blocking standalone operation.

Per connector:

- `id`
- `label`
- `category`
- `status`
- `capabilities`
- `authMode`
- `packs`

The runtime rule:

- if connector exists, enrich search/workflow
- if connector does not exist, continue from chat, uploaded files, and local memory

## First Packs To Ship

Do not try to mirror all 122 Anthropic skills. Ship a narrow, high-value first wave.

### 1. Enterprise Search Pack

Why first:

- it upgrades the whole product, not one mode
- it improves both chat answer quality and right-rail search
- it aligns with current memory/knowledge substrate

Real workflows:

- `answer-question`
- `decision-recall`
- `status-reconstruction`
- `source-brief`

Outputs:

- cited answer
- evidence cluster summary
- conflict note
- confidence score

### 2. Product Management Pack

Why first:

- strong global demand
- maps well to existing doc, playbook, and research outputs

Real workflows:

- `write-spec`
- `synthesize-research`
- `define-success-metrics`

Outputs:

- PRD document
- research synthesis memo
- acceptance criteria bundle

### 3. Data Pack

Why first:

- current spreadsheet, visualization, and research pipeline already exists
- high leverage for users doing dashboards, operations, finance, and reporting

Real workflows:

- `data-context-bootstrap`
- `build-dashboard`
- `metric-definition`

Outputs:

- workbook artifact
- dashboard spec
- data glossary and metric reference

### 4. Legal Pack

Why fourth:

- contract review path already exists
- strong differentiation if the review is structured and risk-ranked

Real workflows:

- `review-contract`
- `flag-deviations`
- `redline-summary`

Outputs:

- clause risk matrix
- redline memo
- escalation summary

### 5. Finance Pack

Why fifth:

- high value, but should come after retrieval discipline and evidence discipline are stronger

Real workflows:

- `variance-analysis`
- `equity-research`
- `decision-brief`

Outputs:

- finance memo
- spreadsheet pack
- scenario matrix

## Multi-Thread Delivery Plan

### Track A: Pack Foundation

Goal:

- create the manifest and runtime registration layer

Backend work:

- add `server/src/packs/` with typed manifest schema
- add pack bootstrap loader
- add `/api/packs` and `/api/workflows`
- map existing live capabilities to pack/workflow ids

Frontend work:

- replace raw capability thinking with pack-aware cards
- keep UI simple: user sees task language, not plugin jargon

Definition of done:

- visible capabilities all resolve to a real pack + workflow definition
- no starter tile exists without a live backend handler

### Track B: Retrieval Orchestrator

Goal:

- turn current search and context assembly into a query-aware evidence engine

Backend work:

- extract current search logic from [server/src/index.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/index.ts) into a dedicated orchestrator module
- add query classifier and scoring model
- add dedupe, confidence, and source clustering
- enrich reply trace payloads

Frontend work:

- search UI shows answer-first synthesis, then evidence clusters
- right rail stops being a raw result bucket

Definition of done:

- chat answer trace includes confidence and source clusters
- search panel can answer "what did we decide/status/doc/person" with explicit attribution

### Track C: Memory Tiering

Goal:

- make memory trustworthy, compact, and valuable without exposing internal complexity

Backend work:

- extend memory schema with tier metadata
- add promotion/compaction jobs
- add project/session summary snapshots
- add memory export bundle

Frontend work:

- keep surface minimal
- expose value as "current context", "important carry-forward", and export

Definition of done:

- sessions can promote facts into durable project memory
- long sessions do not bloat live context indefinitely

### Track D: Workflow Contracts

Goal:

- convert current generator endpoints into opinionated workflows

Backend work:

- introduce workflow definitions next to current generators
- add per-workflow input requirements
- add preflight checklist and post-generation summary

Frontend work:

- ask only the missing questions
- show the deliverable contract before generation
- keep revision loop attached to the latest artifact

Definition of done:

- `docs`, `research`, `contract`, `dashboard` no longer feel like prompt starters
- each one has a real execution contract and inspectable summary

### Track E: Connector Registry

Goal:

- prepare future MCP-style enhancement without faking integrations now

Backend work:

- add connector registry schema and config surface
- tag packs with optional connectors
- no live connector integration is required in phase one

Frontend work:

- pack details can say "works now from chat + files" and "improves with connector X"

Definition of done:

- connector state is explicit
- pack behavior degrades honestly

## Sequencing

### Phase 0: Product Integrity

- freeze visible capabilities to only real workflows
- map every current mode to a pack/workflow id
- remove or hide any capability that is still only a prompt starter

### Phase 1: Enterprise Search Core

- ship query classification
- ship evidence synthesis
- update context trace and right-rail search

This is the best first engineering slice because it improves the whole workspace immediately.

### Phase 2: Product Management and Data Packs

- ship `write-spec`
- ship `build-dashboard`
- attach structured artifact summaries and revision hooks

### Phase 3: Legal and Finance Packs

- upgrade contract review from artifact generation into structured review
- upgrade finance from narrative generation into methodology-driven analysis

### Phase 4: Connector Registry and Bootstrap/Update Flows

- add `start` and `update` style workspace flows
- add connector-aware enrichment

## Files Likely To Change

Backend:

- [server/src/index.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/index.ts)
- [server/src/agents.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/agents.ts)
- [server/src/knowledge.ts](/Users/lu/.openclaw/workspace/projects/chat-mirror/server/src/knowledge.ts)
- new `server/src/packs/*`
- new `server/src/workflows/*`
- new `server/src/search/*`
- new `server/src/memory/*`

Frontend:

- [web/src/App.tsx](/Users/lu/.openclaw/workspace/projects/chat-mirror/web/src/App.tsx)
- [web/src/styles.css](/Users/lu/.openclaw/workspace/projects/chat-mirror/web/src/styles.css)
- likely new `web/src/components/packs/*`
- likely new `web/src/components/search/*`

Docs:

- [docs/GLOBAL_PRODUCT_DEVELOPMENT_PLAN.md](/Users/lu/.openclaw/workspace/projects/chat-mirror/docs/GLOBAL_PRODUCT_DEVELOPMENT_PLAN.md)
- [docs/AGENT_UPGRADE_BLUEPRINT.md](/Users/lu/.openclaw/workspace/projects/chat-mirror/docs/AGENT_UPGRADE_BLUEPRINT.md)
- this plan file

## Immediate Recommendation

Build these in order:

1. pack manifest foundation
2. enterprise-search style retrieval orchestrator
3. workflow contract for `write-spec`
4. workflow contract for `build-dashboard`

This order is correct because:

- it improves the existing chat core before expanding surface area
- it uses infrastructure that already exists
- it avoids fake product claims
- it creates a reusable pattern for the next packs

## Non-Goals

Do not do these in the first pass:

- copy Anthropic's full plugin count
- expose a public plugin marketplace
- add connector UI before there is a backend registry
- keep expanding mode tiles without workflow contracts
- replace the current chat-first interaction with setup-heavy agent configuration

## Acceptance Bar

This migration is only successful when:

- a user can stay in the same simple chat flow
- visible capabilities map to real backend workflows
- search answers are evidence-ranked and attributable
- memory becomes more useful while consuming less live context
- new packs improve output quality, not just labeling
