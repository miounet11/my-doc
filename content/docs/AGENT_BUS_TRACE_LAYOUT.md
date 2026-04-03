# Agent Bus Trace Layout

Status: active draft
Date: 2026-03-30

## Purpose

Define the file-based trace layout for multi-agent collaboration so every meaningful stage leaves inspectable artifacts outside chat transcripts.

This strengthens:
- execution clarity
- observability
- recoverability
- evidence honesty

## Root Layout

Recommended root:

`traces/agent-bus/<task-id>/`

Example:

`traces/agent-bus/T-001/`

## Per-Task Files

### 00-task.yaml
Canonical task contract snapshot.

### 01-frame.md
OpenClaw framing note.

### 02-plan.md
Plan artifact, including routing decision and verification intent.

### 10-build/`
Builder outputs.
Suggested contents:
- `handoff.yaml`
- `summary.md`
- `artifacts.txt`
- `raw-output.txt` (optional, not treated as completion evidence by itself)

### 20-review/`
Reviewer outputs.
Suggested contents:
- `verdict.yaml`
- `findings.md`
- `evidence.yaml`

### 30-verify/`
Verification outputs.
Suggested contents:
- `verdict.yaml`
- `evidence.yaml`
- `commands.txt`
- `runtime-output.txt`

### 40-deliver.md
User-facing delivery summary draft.

### 50-reflect.md
Reflection note for memory/doctrine promotion.

## Minimal Rules

1. `00-task.yaml` should exist before build starts.
2. A build stage without an inspectable artifact should be considered weak completion.
3. `raw-output.txt` is allowed but does not replace `handoff.yaml`, `evidence.yaml`, or `verdict.yaml`.
4. Review and verify traces should be separate when the task matters.
5. If verification cannot be completed, write a blocked/degraded verdict instead of leaving the directory ambiguous.

## Evidence Discipline

The trace directory should preserve both:
- raw execution exhaust
- normalized evidence labels

This prevents the system from confusing activity with accomplishment.

## Recovery Use

A later session should be able to reopen the task by reading:
1. `00-task.yaml`
2. latest stage directory
3. `40-deliver.md` or `50-reflect.md` if present

## Future Automation

The bus can later auto-materialize this layout from the contracts in `docs/contracts/`.
