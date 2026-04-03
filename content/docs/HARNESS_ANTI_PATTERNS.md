# Harness Anti-Patterns

Status: active guardrail doctrine
Date: 2026-03-31

## Purpose
Make recurrent harness failures easy to spot before they become false-success narratives or context drift.

## Anti-Patterns
### 1. Completion Inflation
Claiming a higher completion level than the evidence supports.
Examples:
- implemented -> "done"
- self-check -> "verified"
- task-verified -> "fully delivered"

### 2. Artifact Self-Worship
Treating internal consistency of the produced artifact as proof that the original ask was satisfied.
Examples:
- code looks clean, therefore task complete
- document exists, therefore published
- explanation sounds coherent, therefore verified

### 3. Historical Evidence Smuggling
Reusing old success signals as if they prove current success.
Examples:
- old deploy state used for a new document
- stale transcript snippet treated as the true first context
- previous routing success reused as proof of current completion

### 4. Failure Evaporation
A failed verification produces only explanation or optimism, not a repair step or honest blocked/degraded state.

### 5. Skill Non-Routing
Correct doctrine/skill exists but is not selected during live work.

### 6. Truncation Amnesia
Assuming the earliest visible transcript is the true beginning when history is clearly incomplete.

### 7. Mock Leakage
Simulated, illustrative, or placeholder evidence is narrated as if it were real execution evidence.

## Countermove
If any anti-pattern appears:
1. name it explicitly
2. lower the claim level
3. anchor to fresh evidence
4. choose the correct skill/protocol
5. record the correction if it matters beyond the turn

## Guardrail
If an answer feels stronger than its evidence, assume an anti-pattern may be active and downgrade before replying.
