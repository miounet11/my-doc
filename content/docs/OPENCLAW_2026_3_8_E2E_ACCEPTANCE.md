# OpenClaw 2026.3.8 E2E Acceptance

Date: 2026-03-09

## Version Alignment

- CLI/runtime: `OpenClaw 2026.3.8 (3caab92)`
- Homebrew package: `2026.3.8`
- GUI app: `/Applications/OpenClaw.app` = `2026.3.8-beta.1`

## Passed

- Gateway runtime is healthy: `openclaw gateway status` reports `RPC probe: ok`.
- Tailscale + serve remain healthy.
- Browser direct-control path is healthy.
  - `scripts/openclaw-browser-smoke.sh` returns `overall: ok`.
- Session/autonomy evidence is healthy.
  - `scripts/projectctl.sh autonomy-evidence` returns `overall: ok`.
- Docker host is healthy.
  - `docker version` returned `29.2.1|29.2.1`.
- Docker project path is healthy.
  - `docker compose config` succeeds for `projects/原始`.
  - `docker compose build` succeeds for `projects/原始`.
  - `docker compose up -d` succeeds for `projects/原始`.
  - `./scripts/smoke.sh` succeeds after compose operations.
- Codex supervision path is healthy.
  - `scripts/projectctl.sh supervise-codex 原始` completed and wrote a summary.
- Complex-cycle evidence is partially healthy.
  - iteration 18 `architect.status.json` reached `run_status=succeeded`.
- ACP smoke is now healthy.
  - `scripts/projectctl.sh acp-smoke` returns `overall: ok`.
  - a first-party artifact is written under `data/system/acp-smoke-last.json`.

## Degraded

- Claude provider remains the main runtime weakness.
  - `readiness-last.json` still marks `claude_probe: degraded`.
  - probe isolation is improved, but the current probe still degrades on `claude-sonnet-4.6`.
  - recent failures now resolve into real upstream categories (`timeout`, `transport_error`) instead of local runner corruption.
- Complex OpenClaw project orchestration is not yet "perfect".
  - `scripts/projectctl.sh complex-cycle 原始 18 '2026.3.8 e2e validation'` advanced through gates and reached real Claude execution.
  - iteration 18 `architect.status.json` succeeded, but `coder.status.json` failed on long-worker timeout.
  - The earlier `process_error after timeout` pattern was traced to runner cleanup weakness and has now been corrected in `scripts/run-claude-brief.sh`.
  - Post-fix replays now degrade as clean repeated `timeout` attempts, and newer upstream connection failures are surfaced as `transport_error`.
  - The worker now enforces a transport threshold: after two `transport_error` failures on the same model, it skips remaining retries for that model and switches to the next fallback.
  - This proves the orchestration chain is real, but not yet deterministically fast/stable.

## Verdict

OpenClaw 2026.3.8 is now aligned and strong enough for real development:

- gateway: ready
- browser: ready
- sessions/autonomy: ready
- codex supervision: ready
- docker development/deployment: ready

But it is not yet "perfect" because:

- Claude long-worker stability is still degraded.
- ACP now has a passing first-party smoke harness.
- Full complex-cycle orchestration still depends on long Claude worker completion quality.

## Next Fix Targets

1. Harden Claude long-worker timeout/retry behavior until `claude_probe` stops degrading readiness.
2. Drive one full `coder` worker to `succeeded` under the new timeout-cleanup path, so complex-cycle is no longer blocked by provider latency alone.
3. Mark complex-cycle as fully accepted only after one iteration completes with `architect` and `coder` both `succeeded`.
