# Worker Status Schema

## Purpose
Standardize worker artifacts so execution results can be interpreted consistently by OpenClaw.

## Required Fields
- `iteration`
- `worker_name`
- `task_focus`
- `execution_surface`
- `run_status`
- `started_at`
- `updated_at`
- `artifact_paths`
- `summary`

## Environment Fields
- `execution_surface`: one of `sandbox-restricted`, `host-direct`, `worker-claude`, `browser-relay`, `remote-node`
- `network_mode`: when known
- `permission_mode`: when known
- `probe_status`: `not-run`, `passed`, `failed`, `mixed`

## Outcome Fields
- `outcome_class`: one of `success`, `env-failure`, `tool-failure`, `task-failure`, `flaky`, `unverified`
- `error_summary`: optional
- `is_error`: optional raw executor field
- `stop_reason`: optional raw executor field

## Evidence Fields
- `artifact_paths`: result/status/heartbeat/log/test paths
- `evidence_notes`: concise human-readable explanation of what is actually proven

## OpenClaw Review Fields
- `openclaw_review_status`: `pending`, `reviewed`, `closed`
- `openclaw_judgment`: short final interpretation
- `next_action`: what should happen next

## Guardrail
Worker artifacts are execution reports, not final truth. Final interpretation belongs to OpenClaw review.
