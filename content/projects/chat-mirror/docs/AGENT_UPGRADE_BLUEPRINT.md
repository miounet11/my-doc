# Agent Upgrade Blueprint

## Goal

Upgrade `chat-mirror` from a chat app with visible agent configuration into an `agentic workspace` with:

- zero-learning-cost default interaction
- system-driven agent routing
- session-bound knowledge and memory
- background ingestion and stable long-running work
- channel reuse across web, Telegram, and future surfaces

The user should feel:

- "I state the goal, the system picks the right capability"
- not "I must learn how to configure agents before I can work"

## Product Judgment

### What We Keep

- chat-first interaction
- session archive
- session-bound knowledge
- drag/drop and paste ingestion
- streaming responses

### What We Remove From The Default Path

- forcing users to choose an agent before starting
- exposing raw prompts and deployment fields as the primary interaction
- making the knowledge system feel like a separate admin console

### What We Add

- hidden orchestration by default
- auto-matched agent roles
- clearer relation between conversation, knowledge, and execution
- gradual disclosure for advanced users

## External Reference Judgment

Public Manus materials consistently push the product in this direction:

- `Less Structure, More Intelligence`
- chat is the first surface, orchestration sits behind it
- agent skills and memory matter, but they should not impose setup cost on the user
- one agent identity should be reusable across chat and other entry points

References:

- https://manus.im/
- https://academy.manus.im/

This document uses those public themes as product direction, not as a literal clone target.

## Target Experience

### Default User Path

1. User opens the product.
2. User types a goal, drops files, or pastes content.
3. System auto-selects the best agent path for this session.
4. Session shows:
   - which capability took over
   - what knowledge is attached
   - what files or memory were used
   - what the system is currently doing
5. User continues naturally without learning internal structure.

### Advanced User Path

Advanced controls exist, but are secondary:

- manual agent override
- skill authoring
- deployment targets
- memory scope
- channel bindings

These should live behind an explicit `Advanced Studio` surface.

## Core Product Principles

### 1. Chat First, Routing Behind

The main input remains the chat composer. Agent routing should happen automatically based on:

- user goal
- active session context
- linked knowledge
- current files / attachments
- recent session history

### 2. Knowledge Is Context, Not Separate Admin Data

Knowledge must feel tied to work:

- library-level storage for reuse
- session-level attachment for focus
- later agent-level packs for specialization

### 3. Agent Choice Is Usually Automatic

Users should not need to understand:

- which agent exists
- which skill is attached
- which prompt is active

They should only see these when they want inspection or override.

### 4. Every Long Task Needs State

Streaming chat is enough for short tasks.
Anything involving heavy knowledge parsing, browser work, or multi-step execution must move into:

- background jobs
- progress state
- resumable checkpoints
- observable activity logs

### 5. Replies Need Trace

Serious answers should later expose:

- which files were used
- which memory was used
- which agent path handled the task
- what execution steps happened

## Architecture Upgrade

### Layer 1: Interaction Surface

- workbench chat
- session archive
- right-side contextual panel
- hidden advanced studio

### Layer 2: Routing Layer

- auto agent matcher
- session agent pinning after match
- manual override only when needed

### Layer 3: Knowledge Layer

- file ingestion
- normalization
- knowledge attachment graph
- future background parsing queue

### Layer 4: Execution Layer

- short chat request/response
- future long-running tasks and browser jobs
- future channel adapters

## Agent Strategy

### Current Direction

System-managed starter pack:

- `Atlas Auto Orchestrator`
- `Atlas Knowledge Curator`
- `Atlas Web App Analyst`
- `Atlas Delivery Operator`

These are not presented as required setup objects.
They are capability profiles the router can pick.

### Matching Inputs

Routing should consider:

- message keywords
- linked knowledge count
- attachment kinds
- active session continuity

### Routing Result

Once matched:

- bind the session to that agent
- use that agent's model
- inject its identity/workflow/skills as hidden system context
- surface the chosen capability to the user in simple language

## UI Upgrade Plan

### Stage A: Low-Friction Routing

- default state shows `Atlas Auto`
- current session panel explains that the system will match an agent automatically
- manual agent selector moves into advanced controls
- agent creation and skill authoring become secondary

### Stage B: Activity + Trace

- show route reason
- show retrieval trace
- show background ingestion progress
- show execution activity

### Stage C: Long-Running Agent Work

- web analysis jobs
- deployment tasks
- cloud execution board
- Telegram continuity

## Reliability Upgrade Plan

### Chat Path

- keep SSE streaming
- retain timeout + retry protections
- keep public health and acceptance scripts

### Knowledge Path

- move heavy parsing to jobs
- expose parse state per file
- support re-index and failure recovery

### Execution Path

- turn browser-heavy tasks into resumable jobs
- keep request/response chat only for fast paths

## Acceptance Standard

The upgraded product is only considered complete when all of these are true:

1. User can start a session without learning any agent concepts.
2. System auto-matches the session to a sensible capability path.
3. The chosen capability is visible but not noisy.
4. Knowledge can be added by drag/drop, paste, file, and folder with low friction.
5. Session-level knowledge association remains clear.
6. Streaming chat remains stable.
7. Manual advanced controls still exist without dominating the default UX.
8. Existing acceptance flows still pass.

## Delivery Phases

### Phase 1: Auto Routing Foundation

- seed default capability pack
- auto-match agent on first real turn
- inject agent identity/workflow into hidden system context
- demote manual configuration in UI

### Phase 2: Traceable Workbench

- retrieval citations
- route reason display
- activity rail
- better session summaries

### Phase 3: Background Knowledge Jobs

- job queue for parsing
- progress UI
- per-file parse status
- retry / re-index

### Phase 4: Executable Agents

- web analysis workflow
- browser-based jobs
- task board

### Phase 5: Multi-Channel Reuse

- Telegram adapter
- channel memory continuity
- agent/channel policies

## Current Iteration Commitment

This iteration should land:

- upgrade blueprint document
- backend auto agent routing
- hidden system prompt injection from matched agent + skills
- default starter capability pack
- UI shift from explicit setup to automatic orchestration first

