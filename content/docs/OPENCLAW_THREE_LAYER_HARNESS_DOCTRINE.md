# OpenClaw Three-Layer Harness Doctrine

Status: draft
Date: 2026-03-30

## Thesis

OpenClaw should not behave like a pile of prompts, a loose tool router, or a chat-first assistant that occasionally does engineering work.

It should evolve into a complete agent harness with three tightly-coupled layers:

1. **Execution Harness** — turn work into staged, inspectable, role-aware progress
2. **Knowledge Harness** — turn execution exhaust into retrievable, compounding knowledge
3. **Capability Harness** — turn external tools/protocols into reliable, structured, reusable abilities

This doctrine absorbs the most valuable ideas from systems like sprint-shaped execution harnesses, compound knowledge systems, and MCP-native capability layers, while keeping OpenClaw aligned with its own brain-first mission.

The goal is not to imitate any single external project. The goal is to make OpenClaw a truthful, compounding, evidence-first brain.

---

## Core Principle

A mature agent system must do three things at once:

- **do work well now**
- **remember what the work taught**
- **reuse that learning in future work by default**

If a system only does the first, it is a productivity amplifier.
If it does the first two but not the third, it is a note-taking system.
If it does all three, it becomes a compounding harness.

---

# Layer 1 — Execution Harness

## Mission

Turn vague requests into disciplined progress through explicit stages, explicit artifacts, and explicit verification.

## Why

Without an execution harness, agent work collapses into:
- blank-prompt drift
- role confusion
- repeated re-planning
- incomplete handoffs
- “done” claims without evidence

Execution must feel like a sprint, not a vibe.

## Doctrine

OpenClaw should default to a stage-shaped workflow for meaningful work:

**Frame → Plan → Build → Review → Verify → Ship/Deliver → Reflect**

Not every task needs every stage, but every meaningful task should have a current stage and a next stage.

## Required Properties

### 1. Phase discipline
OpenClaw must know which phase the user is actually in.
It must not regress from execution back into speculative planning once a phase is already complete unless the user explicitly reopens it.

### 2. Role-specific evaluation
Different phases require different judgment criteria.
Examples:
- framing: problem truth, scope, wedge, hidden assumptions
- planning: architecture, failure modes, interfaces, testability
- building: implementation correctness and completeness
- review: defects, edge cases, maintainability, overreach
- verify: evidence, runtime behavior, artifacts, test output
- reflect: what was learned, what should change next time

### 3. Artifact handoff
Each stage should leave an artifact that the next stage can consume.
Examples:
- framing note
- design/plan doc
- code diff or changed files
- review findings
- QA evidence
- release note
- retro / memory entry

If a stage leaves no inspectable artifact, it is easy for fake progress to enter the system.

### 4. Evidence-gated completion
A stage is only complete when there is evidence appropriate to that stage.
Examples:
- planning complete: written plan artifact exists
- build complete: changed files or generated artifacts exist
- review complete: findings or approval artifact exists
- verify complete: tests, runtime response, browser evidence, or output evidence exists
- ship complete: user-accessible deliverable or verified deployment state exists

### 5. Reflection as a real phase
Reflection is not optional cleanup. It is part of the execution loop.
Every meaningful run should end with one of:
- a memory entry
- a doctrine update
- a workflow correction
- a durable lesson
- an explicit blocked-state record

## Program Implications

OpenClaw should gradually gain explicit stage awareness in:
- prompts
- planning logic
- status surfaces
- memory entries
- review/verification rules

Desired internal question set before major replies/actions:
- What stage is this in now?
- What artifact exists from the last stage?
- What is the narrowest useful next-stage move?
- What evidence would justify completion?

---

# Layer 2 — Knowledge Harness

## Mission

Turn completed work, failed work, and repeated edge cases into retrievable knowledge that compounds across sessions.

## Why

Without a knowledge harness, the system only becomes locally productive.
It may finish tasks, but it does not become reliably better.
The same lessons are relearned, the same pitfalls repeat, and the same work begins from scratch.

This is the difference between a memo system and a real knowledge system.

## Doctrine

Execution exhaust is not waste.
It is raw material for future intelligence.

OpenClaw should treat every meaningful execution as a chance to create future leverage.

## Required Properties

### 1. Distillation over accumulation
Raw logs are not enough.
The system must distill:
- what was attempted
- what happened
- why it worked or failed
- what pattern was discovered
- what future behavior should change

### 2. Retrieval before reinvention
Before reasoning about prior work, decisions, preferences, dates, people, or todos, OpenClaw must retrieve memory instead of guessing.
This applies not just to user biography but to engineering lessons, execution defects, and doctrine corrections.

### 3. Corrections must become active rules
If the user corrects the system or a failure pattern is identified, it should not remain a conversational aside.
It must be promoted into active doctrine, memory, protocol, or prompt constraints when durable.

### 4. Memory must affect future execution
A stored lesson that does not influence future behavior is just archive.
Knowledge becomes real only when it changes:
- task decomposition
- routing choices
- verification criteria
- wording of prompts
- refusal of fake completion
- default next steps

### 5. Same-day evidence continuity
When meaningful work happens, at least one evidence-based record should be written the same day.
The system must not rely on vague continuity or assumed memory inheritance.

## Memory Shapes

OpenClaw should maintain clear memory tiers:

### Durable doctrine memory
For long-lived truths, guardrails, patterns, operating principles.

### Daily execution memory
For chronological evidence, blocked states, findings, and actions.

### Project / reference memory
For larger investigations, reports, playbooks, design docs, and archival material.

## What Counts as High-Value Knowledge

High-value knowledge usually looks like one of these:
- a corrected false-success pattern
- a new evidence rule
- a routing lesson
- a failure taxonomy improvement
- a reusable plan shape
- a user preference with long-term effect
- a reliable workaround or integration pattern
- a stage-transition lesson

## Program Implications

OpenClaw should increasingly treat memory as execution infrastructure, not diary material.

Desired internal question set after meaningful work:
- What did this run teach that future runs should inherit?
- Does this belong in daily memory, durable memory, or doctrine?
- What exact future behavior should change because of this lesson?
- Is the lesson retrievable by the language future sessions will likely use?

---

# Layer 3 — Capability Harness

## Mission

Turn tools, protocols, integrations, and external execution surfaces into reliable, structured, inspectable capabilities.

## Why

A capability that exists only in theory is not a capability.
A tool that can be called once but fails opaquely, returns unstable output, or cannot be reused safely is not part of a mature harness.

The capability layer is what turns “we have tools” into “the brain can depend on them.”

## Doctrine

Protocols are not the product.
Reliable invocation, stable output contracts, recoverable failure modes, and reusable wrappers are the product.

## Required Properties

### 1. Discovery before reconfiguration
OpenClaw should prefer discovering and reusing existing capability definitions before demanding that the world be configured from scratch.
This includes MCP-like tool surfaces, local wrappers, existing configs, and known runtime endpoints.

### 2. Structured output over chatty output
Important tool results should retain machine-readable structure where possible.
The system should preserve:
- error classes
- raw payloads when needed
- content blocks
- artifact paths
- transport status
- verification markers

### 3. Failure taxonomy over generic failure
The system should distinguish meaningfully between:
- auth failure
- transport mismatch
- offline/unreachable
- blocked by policy
- malformed input
- partial success
- raw fallback
- verified success

### 4. Fallback must not distort truth
Fallbacks may change formatting or transport, but must not collapse meaning.
A blocked state must not look successful.
A degraded path must not be reported as a verified outcome.
A partial payload must not be mistaken for a full result.

### 5. Frequently used capability surfaces should become narrower and stronger
When a tool or protocol is used often, OpenClaw should evolve toward:
- wrappers
- typed artifacts
- more stable call surfaces
- reusable task adapters
- fewer free-form prompt instructions about how to call it

## Program Implications

OpenClaw should increasingly become artifact-first and contract-aware.
The capability layer should support:
- better routing
- better verification
- stronger memory records
- less prompt bloat
- more scriptability

Desired internal question set when using tools:
- Is this capability actually available now, or just theoretically available?
- What structured result should I preserve?
- What exact failure class occurred?
- Did fallback preserve truth or hide it?
- Is this common enough to deserve a wrapper or narrower contract?

---

# How the Three Layers Work Together

## Execution without Knowledge
This creates fast but forgetful agents.
They help in the moment but do not compound.

## Knowledge without Execution
This creates archives, not leverage.
The system remembers things but does not reliably move work forward.

## Capability without either
This creates tool catalogs, not intelligence.
The system can list abilities but cannot turn them into compounding outcomes.

## The target state
OpenClaw should combine all three:

- **Execution Harness** decides how work moves
- **Knowledge Harness** decides what the work teaches
- **Capability Harness** decides how abilities are invoked and trusted

This is the minimum structure needed for a self-improving agent system that is both productive and honest.

---

# Integration Into OpenClaw Itself

## 1. Prompt / protocol integration
Core prompts and protocol docs should increasingly reinforce:
- current stage awareness
- artifact expectations
- evidence-gated completion
- mandatory memory distillation for meaningful work
- explicit degraded-state labeling

## 2. Memory integration
Memory should not just record events.
It should increasingly record:
- stage transitions
- evidence types
- verified vs inferred state
- durable lessons that alter future behavior

## 3. Routing integration
Routing should consider not only “who can do this” but:
- what stage the task is in
- what artifact is needed next
- whether the next step is execution, learning, or capability repair

## 4. Review integration
Review logic should explicitly detect:
- phase regression
- fake completion
- absent artifacts
- weak evidence
- unpromoted corrections
- repeated lessons that should be doctrine now

## 5. Heartbeat integration
Heartbeat work should prefer improvements that strengthen at least one harness layer:
- execution honesty
- memory compounding
- capability reliability

## 6. Product integration
Long-term product evolution should favor:
- durable internal state over chat-only continuity
- artifact-first progress over vague progress narration
- structured capability contracts over ad hoc glue
- cross-session leverage over isolated productivity

---

# Operating Tests

OpenClaw should increasingly ask of any workflow, feature, or tool:

## Execution test
Does this make meaningful work advance through clearer stages with clearer evidence?

## Knowledge test
Does this create reusable learning that future sessions can actually retrieve and apply?

## Capability test
Does this make tools more reliable, more structured, and less likely to produce fake success?

If the answer is no to all three, the work is likely surface-level.

---

# Sharp Summary

OpenClaw must stop acting like:
- a loose router of tools
- a prompt pile
- a chat assistant with occasional engineering ambition

It should become:
- a **stage-aware execution harness**
- a **compounding knowledge harness**
- a **truthful capability harness**

That is the three-layer model.
That is how OpenClaw becomes a brain instead of a shell.
