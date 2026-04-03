# Claude Execution Protocol

## Goal

Make Claude Code execution deterministic instead of drifting between "generated a brief" and "actually ran a worker".

## State Machine

1. `brief_ready`
2. `provider_probe`
3. `worker_running`
4. `worker_succeeded` or `worker_failed`
5. `artifacts_persisted`
6. `loop_status_written`

## Fixed Rules

- Every project worker must run through `scripts/run-claude-brief.sh`.
- Every full loop must record `claude_execution` and `claude_run_status`.
- Provider health is checked with `scripts/claude-health.sh` before debugging provider incidents.
- Upstream timeout/error text is treated as failure even if Claude CLI exits `0`.
- Every failed worker writes structured attempt data to `projects/<project>/data/claude-runs/iteration-<n>/*.attempts.json`.
- Every worker writes a live status file `<role>.status.json` and a heartbeat stream `*.heartbeat.jsonl`.
- Timeouts and upstream faults are retried automatically according to policy instead of requiring manual restart.
- Worker prompts larger than the configured ceiling are rejected explicitly instead of being sent blindly.

## Policy Source

Runtime defaults live in:

- `scripts/claude-execution-policy.json`

Current defaults:

- probe timeout: 20s
- worker timeout: 240s
- heartbeat interval: 15s
- retries per model: 3
- retry backoff: 8s
- prompt ceiling: 12000 chars
- model order: `claude-opus-4.6` then `claude-sonnet-4.6`

## Commands

- Health check: `scripts/claude-health.sh`
- Health check JSON: `scripts/claude-health.sh --json`
- Run one worker: `scripts/projectctl.sh run-claude <project> <iteration> <role>`
- Check one worker status: `scripts/projectctl.sh claude-status <project> <iteration> <role>`
- Run one full cycle: `scripts/projectctl.sh cycle <project> <iteration>`

## Failure Classes

- `timeout`: provider or model did not complete in the policy window
- `process_error`: Claude CLI returned non-zero
- `invalid_json`: provider returned malformed output
- `model_error`: upstream/provider returned an application-level error payload

## Current Known Issue

As of 2026-03-08, the current Claude provider path can pass minimal probes but still time out on project-scale tool-using workers. That is now classified as a provider reliability issue, not a missing-execution issue.
