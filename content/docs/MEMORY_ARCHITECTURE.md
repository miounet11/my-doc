# Memory Architecture

## Purpose
Turn memory from a loose file collection into a layered operating system for judgment, continuity, and learning.

## Memory Layers
### 1. Runtime Memory
Scope:
- current active task
- current execution-surface state
- current unresolved risks
- current top priority

Rule:
- used to preserve near-term continuity during execution
- should be summarized and refreshed, not treated as durable truth

### 2. Daily Memory
Location:
- `memory/YYYY-MM-DD.md`

Use for:
- evidence from the current day
- defect findings
- concrete lessons from current work
- unresolved gaps that still matter today

Rule:
- write what happened, why it mattered, and what should happen next
- do not write vague slogans or unsupported success claims

### 3. Durable Memory
Location:
- `MEMORY.md`

Use for:
- stable collaboration principles
- durable user preferences
- recurring system guardrails
- high-confidence operating rules

Admission rule:
A fact or lesson enters durable memory only if it is stable beyond one run, useful across sessions, and evidence-backed enough to affect future behavior.

### 4. Project Memory
Locations:
- `projects/*/docs/*`
- `projects/*/data/retrospectives/*`
- `refs/*`

Use for:
- project-specific protocols
- evidence boards
- retrospectives
- task or domain-specific methods

Rule:
- project memory should strengthen project execution without polluting global memory with local noise

## Promotion Rules
- Runtime -> Daily: if it mattered to today's judgment or execution
- Daily -> Durable: if it has stable reuse value and should change future behavior
- Daily -> Project: if it is mainly relevant to one project or workflow

## Rejection Rules
Do NOT store as durable memory:
- one-off noise
- unverified guesses
- temporary environment glitches without stable lesson
- emotional overreaction without repeated pattern

## Core Guardrail
Durable memory is not a compressed diary. It is an operating manual for better future judgment.
