# Agent Studio Roadmap

## Product Target

Upgrade `chat-mirror` from a single chat surface into a lightweight Agent Studio:

- agent identity and deployment profile
- persistent memory and session continuity
- reusable skills and domain packs
- agent-bound knowledge libraries
- chat-channel entry points such as Telegram
- browser / web-app analysis workflows

## Why This Direction

Public Manus materials emphasize:

- Agent Skills
- deploying agents into real workflows
- persistent context and memory
- chat entry points including Telegram

References:

- Manus overview: https://manus.im/
- Introducing Manus in Your Chat: https://academy.manus.im/
- Manus Agent Skills: https://manus.im/
- Build your own agent examples: https://academy.manus.im/

## Reuse Strategy

### Reuse From Existing OpenClaw System

`projects/原始` and the main OpenClaw environment already show the right primitives:

- multi-agent sessions and orchestration
- long-term memory search/get patterns
- gateway/session control surfaces
- role-local workspaces and skill concepts

This means `chat-mirror` should become the user-facing product layer, not a second isolated agent runtime.

### Keep In Chat Mirror

- customer-facing UI / workbench
- agent catalog
- skill library authoring and binding
- session-agent-knowledge relationships
- uploads, knowledge normalization, retrieval UX
- chat and channel adapters

## Capability Gaps

### Already Landed

- archived conversations
- session-bound knowledge
- batch file/folder import
- spreadsheet/text normalization
- streaming chat

### Still Missing

- agent creation and management UI
- skill authoring UI
- agent-to-session binding UX
- source citation and retrieval trace in replies
- background ingestion jobs with progress
- Telegram channel bridge
- browser operator / web-app analysis workflow
- cloud execution and long-running task board

## Phase Plan

### Phase 1: Agent Data Plane

Goal:

- define agents, skills, and session ownership

Delivered in this iteration:

- `agents` table
- `skills` table
- `agent_skill_links`
- `sessions.agent_id`
- agent / skill CRUD API skeleton

### Phase 2: Agent Workbench UI

Goal:

- let the user choose which agent is active
- expose identity, model, skills, memory scope, deployment target

UI modules:

- Agent switcher
- Skill library drawer
- Session metadata panel
- Deployment status card

### Phase 3: Retrieval Trace And Knowledge Jobs

Goal:

- make knowledge feel trustworthy and operable

Scope:

- show which files were used in each answer
- background ingestion queue
- per-file parse status
- re-index / remove / rebind actions

### Phase 4: Channel Adapters

Goal:

- use the same agent in Telegram and web

Scope:

- Telegram webhook adapter
- channel memory continuity
- agent-level response policy

### Phase 5: Cloud Agent Runtime

Goal:

- long-running work beyond chat request/response

Scope:

- browser automation job runs
- task board and event log
- resumable jobs with checkpoints

## Product Principles

1. Session first
Each conversation belongs to a concrete agent and a concrete knowledge scope.

2. Knowledge is attachable, not global sludge
Knowledge can be attached at library, agent, or session level.

3. Replies need provenance
Every serious answer should show what memory or document it used.

4. Long tasks need state
Anything browser-heavy or workflow-heavy must move into job execution, not hang a single HTTP request.

5. Chat is only one surface
Telegram, web, and future channels should reuse the same agent brain and memory.

## Immediate Build Queue

1. Add agent switcher and agent CRUD UI.
2. Add skill authoring and skill-to-agent binding UI.
3. Add session-to-agent binding in the chat workbench.
4. Add retrieval trace in assistant replies.
5. Move knowledge ingestion to background jobs with progress.
6. Add Telegram adapter skeleton.
7. Add browser-analysis agent workflow template.
