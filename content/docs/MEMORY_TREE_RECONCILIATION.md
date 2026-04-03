# Memory Tree Reconciliation And Repair Plan

## Purpose

This document reconciles the original memory-tree logic with the current OpenClaw workspace memory system and defines a repair plan.

The current state is not broken in the simple sense. It is partially repaired but incomplete.

Current reality:
- memory layers exist
- durable memory is compacted
- daily memory is active
- docs and refs are being used properly more often
- handoff protocol now exists

But the system still lacks:
- active confidence/lifecycle flow
- a strong necessary-vs-nonessential knowledge filter
- a runtime-to-handoff-to-daily-to-durable promotion loop
- a disciplined extraction path from raw historical project material into curated doctrine

This document defines the target repair shape.

---

## 1. Original Memory Tree Logic To Preserve

From the original memory-tree design, the most important ideas to preserve are:

1. Memory is layered, not flat.
2. Memory has lifecycle, not just storage.
3. Not all memories deserve equal persistence weight.
4. Frequently used and frequently validated knowledge should rise.
5. Low-value, unused, or stale material should decay or archive.
6. Agent workspaces should stay locally useful without polluting global memory.
7. A memory system should improve judgment, not just retain history.

The exact old tooling does not need to be copied mechanically.
The operating logic does.

---

## 2. Current OpenClaw Memory Layers

### 2.1 Runtime Memory
Current status:
- partially implicit
- spread across current session context, current task state, and now handoff files

Problem:
- runtime continuity is not yet first-class enough
- active worksite state is still fragile between long tasks and session boundaries

### 2.2 Handoff Memory
Current status:
- newly introduced as execution continuity layer
- stored in `handoffs/*.md`
- backed by `scripts/openclaw-handoff.sh`
- supported by `skills/execution-handoff/SKILL.md`

Value:
- this now plugs a real gap between runtime context and longer-lived records

### 2.3 Daily Memory
Location:
- `memory/YYYY-MM-DD.md`

Current status:
- active and useful
- increasingly evidence-backed
- often the best source of recent operational truth

### 2.4 Durable Memory
Location:
- `MEMORY.md`

Current status:
- substantially healthier than before
- compacted into bootstrap-size durable truths
- no longer pretending to be a full diary

### 2.5 Project / Doctrine Memory
Locations:
- `docs/*`
- `refs/*`
- `projects/*/docs/*`

Current status:
- increasingly being used correctly to hold bulky material and project-specific knowledge

---

## 3. What Is Already Fixed

### 3.1 Bootstrap memory compaction
`MEMORY.md` is now compact enough to inject and use as bootstrap memory.
This is a major repair.

### 3.2 Layer separation is partially in place
The workspace now roughly distinguishes:
- durable memory
- daily memory
- project/doctrine memory
- archival material

### 3.3 Handoff layer now exists
The handoff protocol, script, and skill create a missing execution continuity layer.
This was absent before.

### 3.4 Archive pressure is recognized
Bulky history is no longer being treated as proper bootstrap input by default.
This is also a major repair.

---

## 4. What Is Still Broken

### 4.1 No active confidence/lifecycle engine
The original memory tree had a real idea of confidence and lifecycle.
The current system does not yet operationalize that.

Consequence:
- all stored items still rely too much on manual judgment
- repeated use does not automatically increase status
- long-neglected material does not automatically decay

### 4.2 Necessary vs nonessential knowledge filtering is weak
The workspace now stores layered information, but still lacks a rigorous extraction discipline from raw historical material.

Consequence:
- too much manual curation burden
- raw history can still leak into active thinking indirectly
- important doctrine is not extracted fast enough

### 4.3 Runtime memory is still too implicit
The system has handoff now, but runtime state is still spread across:
- active context
- current task awareness
- ad hoc notes
- daily logs

Consequence:
- fragile continuity under long tasks
- risk of repeating orientation work

### 4.4 Promotion loops are not formal enough
The current flow is conceptually present, but not disciplined enough:
- runtime -> handoff
- runtime -> daily
- handoff -> daily
- daily -> durable
- daily -> docs/refs/project memory

Consequence:
- useful material can stall in the wrong layer
- durable memory quality depends too much on incidental discipline

---

## 5. Repair Direction

The correct repair is not “store more.”
The correct repair is to improve:

1. filtering
2. promotion
3. decay/archive discipline
4. execution continuity
5. doctrine extraction

This means the target system should become:
- lighter in bootstrap
- sharper in durable memory
- richer in project/doctrine memory
- stronger in handoff continuity
- stricter about what qualifies as globally important

---

## 6. Necessary Vs Nonessential Knowledge Rule

This must become a core operating rule.

### Necessary knowledge
Necessary knowledge is information that is one or more of:
- needed to continue active execution
- needed across sessions repeatedly
- needed to avoid repeating known mistakes
- needed to preserve stable user/system truths
- needed to route, verify, or judge correctly

### Nonessential knowledge
Nonessential knowledge is information that is one or more of:
- raw conversational repetition
- one-off narrative detail with no reuse value
- rejected options that no longer constrain future action
- long historical context that does not change next-step execution
- commentary that does not affect judgment or behavior

### Operational rule
Do not inject, promote, or preserve knowledge just because it exists.
Preserve it only if it changes future execution quality.

---

## 7. Recommended Promotion Pipeline

### Layer A: Runtime
What exists only to support the active worksite.

If it matters beyond the immediate turn:
- write to handoff or daily memory

### Layer B: Handoff
Use when a task will continue across a session boundary.

Promote from handoff to daily memory when:
- the handoff contains a real lesson
- the handoff records a meaningful completed action
- the handoff captures a repeated continuity pattern worth preserving

### Layer C: Daily Memory
Use for evidence, lessons, and meaningful chronology from the day.

Promote from daily memory to durable memory only when:
- the lesson is stable
- the lesson is reusable beyond one run
- the lesson changes future behavior
- it is evidence-backed enough to trust as doctrine

Promote from daily memory to docs/refs/project memory when:
- the material is too large for durable memory
- the material is project-specific
- the material is a protocol, checklist, or design doc rather than a stable global truth

### Layer D: Durable Memory
Only store small, stable, reusable truths.
No long stories.
No unresolved narrative.
No bulky reports.

---

## 8. Target Confidence/Lifecycle Model (Lightweight Version)

The old memory-tree confidence engine does not need to be copied exactly, but its logic should return in lightweight form.

### Proposed states
- **Active**: recently used and still shaping behavior
- **Stable**: reusable and reliable, but not currently hot
- **Cold**: not recently used and probably not bootstrap-worthy
- **Archived**: preserved for retrieval, not active in reasoning

### Lightweight signals
Without building a full confidence database yet, use these signals:

#### Raise priority when
- a lesson is referenced repeatedly across days
- a doctrine is cited in a new protocol or script
- a fact is used in real execution successfully
- a pattern prevents repeated failure

#### Lower priority when
- a note has not mattered for a long time
- it was highly local to one task and never reused
- it is historical detail with no execution value
- it duplicates stronger doctrine elsewhere

### Implementation principle
Start manual-but-explicit before building a heavier automated system.

---

## 9. What To Do With The Original Project History

The raw historical project should not be treated as active memory.
It should be treated as source ore.

### Correct use of the raw history
Use it to extract:
- durable doctrines
- repeated architecture truths
- stable routing rules
- known failure patterns
- valuable project protocols
- long-range product insights

### Incorrect use of the raw history
Do not:
- re-inject entire transcripts into working context
- treat every historical discussion as equal-value memory
- use history volume as a proxy for intelligence

### Principle
Raw history is a mine.
Curated doctrine is the metal.

---

## 10. Immediate Repair Actions

### Action 1: adopt the necessary vs nonessential knowledge rule as doctrine
This should become a written protocol.

### Action 2: keep handoff as the first-class execution continuity layer
This has already begun and should continue.

### Action 3: explicitly govern promotion between layers
Do not rely on ad hoc intuition alone.

### Action 4: continue keeping `MEMORY.md` bootstrap-small
No regression on this.

### Action 5: extract high-value doctrine from raw project history into docs and durable memory
This is the most important long-range repair.

---

## 11. Final Reconciliation Statement

The current OpenClaw memory system is not memory-less.
It is a partially repaired layered memory system.

What it currently has:
- layers
- compaction
- archive awareness
- daily evidence logs
- durable memory discipline
- handoff continuity layer

What it still lacks:
- active lifecycle logic
- stronger filtering of necessary vs nonessential knowledge
- a robust extraction path from raw history to curated doctrine
- more explicit promotion/demotion rules

Therefore the correct repair strategy is:

> preserve the layered architecture,
> strengthen the filtering discipline,
> restore lifecycle logic in lightweight form,
> and keep moving knowledge from raw history into compact doctrine.

This is how OpenClaw becomes a real memory system instead of a file pile.
