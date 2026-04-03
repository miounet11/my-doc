# OpenClaw vs maoclaw Day 1 Results

Status: active
Date: 2026-03-30

Related:
- [`docs/OPENCLAW_VS_MAOCLAW_ACCEPTANCE_MATRIX_2026-03-30.md`](/Users/lu/.openclaw/workspace/docs/OPENCLAW_VS_MAOCLAW_ACCEPTANCE_MATRIX_2026-03-30.md)
- [`evals/runtime-replacement-scorecard-template.json`](/Users/lu/.openclaw/workspace/evals/runtime-replacement-scorecard-template.json)

## Scope

Day-1 checks focused on:
- installability
- session inspectability
- history surface visibility
- first runnable turn
- auth/setup friction

## OpenClaw: verified observations

### Runtime and session surface
- `openclaw --version` => `OpenClaw 2026.3.28 (f9b1079)`
- `openclaw sessions --json` returned a valid live session store at:
  - `/Users/lu/.openclaw/sessions/sessions.json`
- Session entries were inspectable and showed active `gpt-5.4` usage with `160000` context tokens.

### History surface visibility
- Verified readable:
  - `/Users/lu/.openclaw/memory`
  - `/Users/lu/.openclaw/workspace/memory`
  - `/Users/lu/.openclaw/workspace/refs`
  - `/Users/lu/.openclaw/workspace/handoffs`
  - `/Users/lu/.openclaw/sessions`
- Verified many dated memory files exist in `workspace/memory`.

### Continuity weakness found
- The only visible handoff artifact inspected:
  - `/Users/lu/.openclaw/workspace/handoffs/20260318-072522.md`
- Result: template only, effectively empty.
- Interpretation:
  - memory surfaces are real
  - handoff continuity is currently weak and should not be overstated

## maoclaw: verified observations

### Installability
- Install command succeeded:
  - release tag resolved to `v0.1.13`
  - checksum verification passed
  - binary installed to `/Users/lu/.local/bin/pi`
- Minor installer defect:
  - trailing script error: `BASH_SOURCE[0]: unbound variable`
- Interpretation:
  - install completed successfully
  - installer polish is not perfect

### Local operator surface
- `pi --version` => `pi 0.1.13`
- `pi doctor` worked and honestly reported:
  - missing directories before fix
  - no stored credentials
  - available shell/tool prerequisites
- `pi --help` clearly exposes:
  - provider
  - model
  - session dir
  - continue/resume
  - repair policy
  - extension policy

### First-turn execution failures

#### Attempt 1: default provider path
- Command:
  - `pi -p "Reply with exactly: OK"`
- Result:
  - explicit `401` on `openai-codex`
  - error was reported cleanly as provider auth failure

#### Attempt 2: anthropic provider
- Command:
  - `pi --provider anthropic -p "Reply with exactly: OK"`
- Result:
  - explicit `401` invalid bearer token
  - error was reported cleanly as provider auth failure

#### Attempt 3: custom OpenAI-compatible route
- Goal:
  - point `pi` at the same `https://ttqq.inping.com/v1` route used by OpenClaw
- Result:
  - runtime rejected `--base-url` with:
    - `Validation error: Extension flags were provided (--base-url), but no extensions are loaded.`

### Interpretation
- `maoclaw` is honest about failures.
- `maoclaw` is not yet low-friction on this machine for the same live provider route.
- There is an operator-surface inconsistency:
  - docs describe `--base-url`
  - current runtime path rejects it in this non-interactive setup

## maoclaw: mirrored-provider configuration landed

To make the comparison same-route and same-model, `maoclaw` was configured to mirror the active OpenClaw provider settings via:

- `/Users/lu/.pi/agent/settings.json`
- `/Users/lu/.pi/agent/models.json`

Mirrored values:
- provider: `openai`
- default model: `gpt-5.4`
- base URL: `https://ttqq.inping.com/v1`
- API adapter: `openai-completions`
- API key: same route key used by OpenClaw
- model catalog: mirrored from the current OpenClaw `openai` provider block

### Verified after mirror

#### Smoke turn
- Command:
  - `pi -p "Reply with exactly: OK"`
- Result:
  - returned `OK`

#### Same-workload memory read
- Command:
  - `pi -p "Read /Users/lu/.openclaw/workspace/memory/2026-03-29.md and reply with one short sentence naming the main unfinished job."`
- Result:
  - correctly returned:
    - `The main unfinished job is replacing the mock benchmark path with a real measurement harness.`

#### Simple continue path
- Command:
  - `pi -c -p "Reply with exactly: CONTINUED"`
- Result:
  - returned `CONTINUED`

### Interpretation after mirror
- `maoclaw` can now run against the same live provider route as OpenClaw.
- The prior auth/setup block is no longer the operative truth for the comparison.
- The remaining gap is not basic execution, but deeper workflow parity and session/continuity evidence under real tasks.

## Day-1 provisional scoring

These are provisional and should be revised only with new evidence.

### OpenClaw
- Long-session continuity: `1`
  - session store is healthy and inspectable
  - handoff layer is weak
- Context/history recovery: `1`
  - history surfaces are real and readable
  - retrieval authority is still fragmented
- Operational truthfulness: `1`
  - recent repairs improved this, but the system still has known stale-evidence failure history
- Tool/runtime stability: `1`
  - live runtime is usable
  - known degradation still exists in parts of the control plane
- Provider/session control: `2`
  - current runtime is on `gpt-5.4`
  - active sessions report `160000` context
- Integration burden: `2`
  - this is the incumbent system
- Repair velocity: `1`
  - targeted fixes have been landing
  - but repeated control-plane drift still exists

### maoclaw
- Long-session continuity: `1`
- Context/history recovery: `1`
- Operational truthfulness: `1`
  - auth/setup failures were explicit and honest
- Tool/runtime stability: `2`
  - install, doctor, smoke execution, file-reading turn, and simple continue path all worked after mirrored config
- Provider/session control: `1`
  - mirrored route and default model now work
  - deeper session persistence/inspectability still needs more evidence
- Integration burden: `1`
  - executable now, but far from full workflow parity
- Repair velocity: `1`
  - one config intervention made the runtime usable on the same route

## Current conclusion

After day 1:
- OpenClaw remains the only system currently verified to be operational in this environment.
- `maoclaw` is now operational on the same provider route after mirrored config, but parity is still partial.
- The correct next move is not migration.
- The correct next move is:
  - continue OpenClaw control-plane repair
  - keep `maoclaw` in pilot status until it can complete deeper same-task continuity and integration checks
