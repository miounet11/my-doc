# ACP Descriptor Hygiene — Enforcement Notes

Status: active draft
Date: 2026-03-30
Project: 原始

Purpose: connect the workspace-level harness doctrine to a real project surface where ACP descriptor drift and fake-escalation risks have already appeared.

## Why This Exists
The `原始` project already contains evidence around loop-19 readiness, browser smoke checks, retrospectives, and ACP descriptor hygiene. That makes it a good concrete surface for enforcing harness rules instead of keeping them abstract.

Relevant existing surfaces include:
- `projects/原始/data/loops/loop-19.md`
- `projects/原始/data/retrospectives/loop-19.md`
- `projects/原始/data/retrospectives/loop-19-reflection.md`
- `projects/原始/data/orchestration/iteration-19-20260310-032140/readiness.json`
- `projects/原始/data/orchestration/iteration-19-20260310-032140/browser-smoke-evidence.md`
- `projects/原始/docs/ACP_DESCRIPTOR_HYGIENE.md`
- `scripts/openclaw-acp-dispatch.sh`

## Harness Mapping

### Execution Harness
ACP escalation belongs to execution only when there is:
- a valid descriptor
- a real task
- a clear artifact target
- a way to verify the result after execution

### Knowledge Harness
If an ACP descriptor shape fails once, the correction should not stay inside one chat or one loop note.
It should be promoted into durable hygiene rules and project docs.

### Capability Harness
ACP dispatch is a capability surface.
Its maturity depends on:
- valid schema use
- stable parameter names
- honest failure classification
- no invented fields

### Guardrail Plane
ACP escalation must not be narrated as successful when:
- the descriptor is malformed
- the dispatch was not actually attempted
- the result is blocked or degraded
- the task surface is pseudo-execution instead of a real task

### Observability Plane
A good ACP escalation should leave inspectable evidence such as:
- validated descriptor text
- dispatch output
- session/runtime evidence
- artifact/result evidence
- explicit blocked/degraded labeling when needed

## Enforcement Notes

### 1. Descriptor validity comes first
If the descriptor cannot serialize cleanly into the expected shape, escalation is not ready.
This is a pre-execution failure, not a partial success.

### 2. Pseudo-tasks are not tasks
Values like `task="native_host_persist"` are failure signals, not acceptable substitutes for a real task request.

### 3. Forbidden drift patterns stay forbidden
The following remain red flags:
- `payload=...`
- invented delivery or transport params on `sessions_spawn`
- incomplete snippets that omit a real task surface
- descriptors that imply success without runtime evidence

### 4. Browser/readiness evidence is verification, not vibe
When readiness or smoke docs exist, they should be treated as verify-stage artifacts.
Do not let later narration outrank them.

### 5. Loop retrospectives should update project hygiene
If a loop retrospective identifies ACP descriptor confusion, the project should tighten its reusable instructions, not just record the incident.

## Suggested Project-Level Review Questions
Before claiming ACP escalation success in `原始`, ask:
1. Was the descriptor valid?
2. Was there a real task?
3. Was dispatch actually attempted?
4. What artifact/result was expected?
5. What evidence verified the run?
6. If blocked/degraded, was that labeled honestly?

## Sharp Rule
In ACP work, malformed escalation plus confident narration is worse than no escalation at all.
