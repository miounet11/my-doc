# OpenClaw Agent Collaboration Architecture

Status: draft
Date: 2026-03-30

## Purpose

Define how OpenClaw, Claude Code, and Codex should collaborate on one task as a coherent system rather than as loosely chained tools or prompt relays.

This document strengthens the existing harness doctrine by specifying a multi-agent collaboration layer that is:
- stage-aware
- artifact-aware
- evidence-gated
- transport-agnostic
- memory-compounding

## Core Thesis

A good multi-agent system is not "agents can message each other".
A good multi-agent system is "the right agent receives the right bounded task at the right stage, produces the right artifact, and another surface verifies it honestly".

OpenClaw should be the orchestration brain.
Claude Code and Codex should be specialized execution surfaces.
ACP, ACPX, smux/tmux, PTY exec, and other transports should be treated as replaceable capability backends, not as the coordination model itself.

## Roles

### OpenClaw
Owns:
- intent understanding
- task framing and decomposition
- stage tracking
- routing and escalation
- artifact contracts
- review/verify separation
- evidence labeling
- memory and doctrine promotion

OpenClaw should own the WHAT / WHY / WHO / WHEN / DONE logic.

### Claude Code
Default strengths:
- broader repository understanding
- architecture-sensitive implementation
- larger or more exploratory refactors
- richer plan/build notes
- review commentary when needed

Claude Code should stay in tool position and should not silently become the whole brain.

### Codex
Default strengths:
- precise implementation
- smaller targeted fixes
- test-oriented iteration
- local verification steps
- compact patch generation
- critical second-pass review on concrete diffs

Codex should accelerate execution, not replace OpenClaw's control plane.

## Collaboration Principle

The unit of collaboration is not free-form chat.
The unit of collaboration is:

**stage contract -> artifact -> evidence -> next-stage routing**

## Default Stage Flow

For meaningful engineering tasks, default to:

**Frame -> Plan -> Build -> Review -> Verify -> Deliver -> Reflect**

Not every task needs every stage, but every collaboration should have:
- a current stage
- a current owner
- an expected artifact
- an evidence rule
- a next-stage decision

## Stage Contracts

### 1. Frame
Owner: OpenClaw

Produces:
- problem statement
- scope boundary
- constraints
- success criteria
- likely risks

### 2. Plan
Owner: OpenClaw or Claude Code

Produces:
- proposed implementation shape
- file/service touch points
- role split
- verification strategy
- escalation triggers

### 3. Build
Owner: Claude Code or Codex

Produces:
- code/config/doc changes
- implementation summary
- known risks
- self-reported uncertainties

### 4. Review
Owner: non-builder agent or OpenClaw review pass

Produces:
- defect findings
- missing tests
- overreach / unnecessary complexity notes
- approval or rework verdict

Rule: the build owner should not be the only reviewer.

### 5. Verify
Owner: separate verification surface when possible

Produces:
- test output
- runtime output
- browser/service checks
- artifact existence checks
- explicit evidence label

Rule: self-asserted completion is not verification.

### 6. Deliver
Owner: OpenClaw

Produces:
- user-facing completion summary
- exact artifact/diff/result reference
- blocked/degraded caveats when present

### 7. Reflect
Owner: OpenClaw

Produces one of:
- memory entry
- doctrine update
- reusable routing lesson
- evidence-rule correction
- failure pattern note

## Collaboration Contracts

### Task Contract
Every dispatched subtask should carry at least:
- objective
- stage
- scope
- constraints
- expected artifact
- evidence requirement
- escalation conditions

Example shape:

```yaml
id: T-001
objective: Fix auth refresh race
stage: build
owner: claude-code
constraints:
  - do not widen API surface without need
  - preserve current token schema
expected_artifact:
  - changed_files
  - test_results
  - risk_notes
verification:
  - unit_tests_pass
  - race_reproduced_then_absent
escalate_if:
  - auth flow assumptions unclear
  - tests cannot run reliably
```

### Handoff Contract
Every inter-agent handoff should try to include:
- what was done
- what artifact changed
- what remains uncertain
- what the next agent should check
- what counts as acceptance

### Verdict Contract
Every review/verify step should end with one of:
- approved
- approved_with_caveats
- rework_required
- blocked
- degraded
- unable_to_verify

Do not collapse these into generic success language.

## Evidence Rules

Important collaboration claims should be labeled as one of:
- verified
- partially-verified
- blocked
- degraded
- mock
- illustrative
- inferred
- unknown

Critical rules:
- routing logs are not accomplishment evidence
- a pane/session transcript is not by itself build completion evidence
- an agent saying "done" is not full-chain verification
- review evidence and verification evidence are distinct

## Transport-Agnostic Agent Bus

OpenClaw should standardize the collaboration surface above runtime specifics.

Desired logical interface:
- spawn_agent
- send_task
- read_state
- interrupt
- request_review
- collect_artifact
- collect_evidence
- close_or_continue

Possible backends:
- ACP runtime sessions
- ACPX flows
- smux / tmux-bridge
- local PTY exec
- future structured wrappers

### smux Positioning

smux/tmux-bridge is best treated as a shared terminal transport backend.
It is useful because it allows cross-pane read/type/keys interaction without API dependencies.

But smux is not the orchestration model.
Without stage contracts, artifact contracts, and evidence gates, smux only creates a shared interface, not a reliable collaboration system.

Therefore:
- use smux as a capability backend when terminal-level collaboration is helpful
- do not let pane-level messaging define the collaboration architecture
- keep orchestration logic in OpenClaw

## Default Routing Heuristics

### Prefer Claude Code when:
- the task is broad or architecture-sensitive
- repository understanding matters more than raw patch speed
- the build step needs explanation and careful reasoning

### Prefer Codex when:
- the task is narrow and concrete
- patch precision matters
- tests or small iterative fixes dominate
- a second-pass review on concrete changes is needed

### Prefer OpenClaw direct work when:
- the task is only a few local edits
- the main missing artifact is doctrine, memory, or routing logic
- the bottleneck is judgment or verification, not raw implementation

### Prefer a verification pass when:
- implementation already exists
- completion was claimed without sufficient evidence
- the next missing truth is runtime/test confirmation rather than more code

## Anti-Patterns

Avoid these collaboration failure modes:

1. Free-form agent chatter with no artifact contract
2. Builder self-approves and self-verifies
3. OpenClaw only forwards prompts and does not own stage logic
4. Transport-specific assumptions leaking into high-level doctrine
5. Memory never being updated after collaboration completes
6. Review findings not being translated into routing changes or doctrine
7. Agents interacting impressively while completion remains evidence-thin

## Minimal Healthy Loop

A healthy three-surface loop often looks like:

1. OpenClaw frames and dispatches bounded build task
2. Claude Code or Codex builds
3. the other surface reviews
4. OpenClaw or a separate surface verifies
5. OpenClaw reflects and promotes the lesson

This is usually healthier than letting all surfaces talk continuously without role boundaries.

## Progressive Implementation Path

### Phase 1
- define collaboration contracts in docs
- require stage + artifact + evidence fields in major multi-agent tasks
- separate build/review/verify in practice

### Phase 2
- create transport-agnostic agent-bus wrapper
- add ACP / ACPX / smux adapters
- normalize verdict and evidence schemas

### Phase 3
- record collaboration outcomes in memory with reusable routing lessons
- add supervision logic for over-centralization and fake completion
- tune role heuristics from observed results

## Success Condition

The system is improving when:
- OpenClaw increasingly owns orchestration instead of forwarding prompts
- Claude Code and Codex are used for their comparative strengths
- collaboration leaves inspectable artifacts at each meaningful stage
- review and verification are not conflated with implementation
- transport can change without collapsing the coordination model
- memory and doctrine improve from completed runs

## Sharp Rule

The goal is not to make agents talk more.
The goal is to make multi-agent work more truthful, more inspectable, more recoverable, and more compounding.
