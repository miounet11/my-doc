# OpenClaw Execution Handoff Protocol

## Purpose

OpenClaw already has long-term memory, daily memory, docs, refs, and session history.

What it still needs is a dedicated layer for **continuing execution across session boundaries**.

This protocol defines that layer.

A handoff is **not** a summary.
A handoff is **not** a memory dump.
A handoff is **not** a transcript export.

A handoff is a **minimal executable continuation package**.

Its only job is:

> make the next session able to continue the work without re-collecting the whole story.

---

## 1. Problem This Protocol Solves

Without a proper handoff layer, long tasks decay in predictable ways:

- the next session asks the user to repeat background
- task state is mixed with narrative history
- important constraints are lost
- file pointers are missing
- the next action is ambiguous
- OpenClaw restarts from orientation instead of continuation

This protocol exists to prevent that.

---

## 2. Core Doctrine

### 2.1 Handoff is for execution continuity

The goal is not to preserve everything.
The goal is to preserve only what is needed to resume work.

### 2.2 Minimal state beats complete history

A good handoff is short, sharp, and actionable.
If a line does not help the next session continue the task, it should usually be removed.

### 2.3 Handoff is not memory

OpenClaw has multiple persistence layers. They must stay separate.

- **Handoff** = task continuation package
- **MEMORY.md** = durable truths and long-term learning
- **memory/YYYY-MM-DD.md** = chronological evidence and daily work log
- **docs/** and **refs/** = bulky doctrine, plans, and reference material
- **session history** = raw conversational record, not the default recovery surface

### 2.4 The best context is no extra context

A handoff should compress the active worksite, not duplicate the entire session.

### 2.5 A handoff must support immediate action

If the next session still does not know what to do first, the handoff failed.

---

## 3. When To Create A Handoff

Create a handoff only when it is actually useful.

### Required triggers

Create a handoff when one or more are true:

1. the task is clearly multi-stage and will continue later
2. the user says to pause, resume later, or continue in another session
3. context is getting long enough that clean continuation is at risk
4. work is being transferred between execution surfaces, such as:
   - main session -> Codex
   - Codex -> main session
   - one ACP run -> later ACP run
   - browser/desktop execution -> later recovery
5. there is already enough completed work that losing the current state would cause real rework

### Good examples

- a deployment investigation paused halfway through
- a Codex implementation pass that needs a later refinement run
- a long design/planning task that will resume in another session
- a multi-day content or product build
- a partially completed debugging or migration effort

### Do not create a handoff for

- simple one-shot questions
- small edits already completed
- trivial informational queries
- tasks with no real continuation value
- cases where MEMORY or daily memory is the right destination instead

---

## 4. Handoff Package Definition

A handoff package is a compact file that stores the minimum state required to continue execution.

Recommended location:

```text
workspace/handoffs/<handoff_id>.md
```

The exact storage path may evolve, but the structure should remain stable.

A handoff package must be self-sufficient enough that the next session can:

- understand the current task
- understand the current progress
- know what has already been decided
- know what must not be broken
- know which files matter
- know the exact next action

---

## 5. The Eight-Slot Structure

Every handoff should contain these 8 slots.

1. **Current Task**
2. **Current State**
3. **Completed**
4. **Key Decisions**
5. **Key Constraints**
6. **Key Files**
7. **Next Step**
8. **Blocking Confirmation**

If one is missing, recovery quality drops sharply.

### 5.1 Current Task

One sentence describing what is being worked on.

### 5.2 Current State

What stage the task is in now.
What is done, what is in progress, what is stuck.

### 5.3 Completed

Concrete work already landed.
Not vague claims. Not “made progress.”

### 5.4 Key Decisions

Only settled conclusions.
Do not dump the debate history.

### 5.5 Key Constraints

What cannot be broken.
These include product, technical, safety, policy, deployment, or user constraints.

### 5.6 Key Files

Use `path:line` plus one short reason.
Only include the files the next session should actually inspect first.

### 5.7 Next Step

This must be an executable action.
Good:
- patch `x` to support `y`
- run `z` verification and inspect output
- open `file` and replace `old` with `new`

Bad:
- continue working
- keep going
- review later

### 5.8 Blocking Confirmation

The single blocking question, if one exists.
If nothing blocks continuation, write `None`.

---

## 6. Handoff Writing Standard

### Required qualities

A good handoff is:

- short
- concrete
- factual
- action-oriented
- free of transcript bloat
- enough to restart work without re-asking for the whole story

### Compression rules

Prefer:
- facts over narration
- conclusions over discussion history
- file pointers over story retelling
- next actions over generic intent

Remove:
- long back-and-forth conversation summaries
- dead ends unless they prevent repeating a known mistake
- emotional filler
- politeness filler
- generic statements like “continue progress”

### Length target

- preferred target: under 100 lines
- soft ceiling: 120 lines
- exceptional ceiling for complex work: 150 lines

If a handoff exceeds 120 lines, compress it.
If it exceeds 150 lines, it is probably not a handoff anymore; it is drifting into a report.

---

## 7. Recovery Protocol

When restoring from a handoff, the next session should:

1. read the handoff package first
2. produce a short recovery preview in 3-5 bullets
3. state the immediate next step
4. decide whether that next step can proceed automatically or needs user confirmation
5. inspect only the key files required for that next step
6. continue execution

### Recovery preview must cover

- the current task
- the current state
- the key files
- the next step
- whether anything is blocked

### Automatic continuation vs confirmation

OpenClaw should not always ask for confirmation.

#### Ask for confirmation when

- the next step is high-risk
- the user may plausibly have changed direction
- the next step is external, destructive, or sensitive
- the handoff explicitly contains a real blocker requiring user input

#### Continue automatically when

- the next step is ordinary and low-risk
- the direction remains clear
- the continuation is operationally routine
- no blocking confirmation is needed

This keeps handoff aligned with OpenClaw’s autonomy protocol instead of turning every restoration into a permission checkpoint.

---

## 8. Relationship To Memory Layers

This separation is non-negotiable.

### Handoff belongs to the execution layer
It exists to continue the task.

### MEMORY.md belongs to the durable-truth layer
It stores lessons, decisions, architecture truths, and human-relevant continuity.

### Daily memory belongs to the evidence log layer
It records what happened and why it mattered.

### Docs/refs belong to the doctrine/reference layer
They hold plans, specifications, protocols, and bulky material.

### What not to do

Do not turn handoff files into:
- daily journals
- memory archives
- design docs
- full reports
- transcripts

---

## 9. Quality Standard For A Good Handoff

A handoff is good only if the next session can do all of these without re-asking for the whole background:

- identify the active task
- understand current progress
- avoid breaking key constraints
- inspect the right files first
- execute the next action
- know whether anything is blocked

If that cannot happen, the handoff is weak and should be rewritten.

---

## 10. Examples Of Good Use

### Example A: paused Codex implementation
- current feature is halfway implemented
- key files are known
- constraints are known
- next step is a specific patch + test

### Example B: deployment recovery
- service was updated but not fully verified
- key config files and commands are known
- next step is specific verification and rollback/fix work

### Example C: design -> build transfer
- product decisions are finalized
- implementation has not started
- next step is scaffold or first code pass

---

## 11. Examples Of Bad Use

### Bad handoff
- retells the entire chat
- says “continue from here” without file pointers
- mixes current task with durable memory doctrine
- has no explicit next action
- contains ten different “maybe” directions

### Also bad
- uses handoff to dump unresolved thinking
- stores every rejected option
- records a giant context blob “just in case”

---

## 12. Suggested File Template

```md
# Handoff: <topic>

- Time: <YYYY-MM-DD HH:MM>
- Handoff ID: <id>
- Session: <session or source>

## Current Task
- <one-sentence task>

## Current State
- <current progress / stuck point>

## Completed
- <landed result 1>
- <landed result 2>

## Key Decisions
- <settled conclusion 1>
- <settled conclusion 2>

## Key Constraints
- <constraint 1>
- <constraint 2>

## Key Files
- `path:line` — <why it matters>
- `path:line` — <why it matters>

## Next Step
- <immediate executable action>

## Blocking Confirmation
- None
```

---

## 13. OpenClaw-Specific Design Principle

This protocol should strengthen OpenClaw’s brain functions, not replace them.

The handoff layer exists so OpenClaw can:
- keep execution continuity across sessions
- stop losing active worksite state
- reduce repetitive user re-briefing
- keep the next step precise

It should not become another bloated context source.

---

## 14. Final Rule

If the next session still needs the user to retell the task before it can continue, the handoff failed.
