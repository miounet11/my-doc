# OpenClaw Runtime Recovery - 2026-03-11

## Scope

Bring OpenClaw back to a state that is honest to operate and close to normal use.

This pass focused on:

- making readiness reflect real instability instead of one lucky green sample
- separating gateway liveness from session inspection health
- distinguishing visible action from thinking-only autonomy loops

## What Was Changed

### Health-surface repairs

- `scripts/openclaw-session-evidence.sh`
  - retries `sessions.get` 3 times before falling back
  - records gateway attempt count and per-attempt errors
  - marks whether gateway evidence was flaky
  - if gateway RPC still fails, reads local transcript evidence from `~/.openclaw/sessions/sessions.json` + `sessionFile`
- `scripts/openclaw-autonomy-guard.sh`
  - degrades not only on missing gateway evidence
  - also degrades on `thinking-only session surface`
  - treats transcript-backed local session evidence as usable but flaky instead of blind failure
- `scripts/openclaw-readiness.sh`
  - performs consecutive autonomy probes
  - degrades when consecutive probes disagree
  - records browser auto-start recovery in notes instead of silently treating it as stable

### Result

- readiness no longer reports a false all-green state while autonomy is stuck in thinking-only loops
- session-evidence output now contains enough detail to prove whether the problem is:
  - gateway RPC failure
  - fallback-only inspection
  - thinking-only agent behavior

## Verified Current State

### Healthy enough

- gateway process is running and listening on `127.0.0.1:18789`
- Claude provider probe is `ok`
- memory-bank is `ok`
- browser can recover to working state via auto-start

### Still degraded

- `sessions.get` remains unreliable at runtime and often fails with:
  - `1006 abnormal closure (no close frame)`
- autonomy readiness is degraded because auto agents often expose:
  - gateway failure / fallback-only evidence
  - or gateway-readable but thinking-only session surfaces
- browser is not persistently warm; it often needs auto-start recovery

## Hard Findings

### 1. Gateway liveness is not the same as gateway RPC health

Evidence:

- `openclaw gateway status` can report `RPC probe: ok`
- direct `openclaw gateway call sessions.get ...` can still fail with `1006 abnormal closure`
- temporarily stopping the long-running `autonomous-loop.ts` and `learning-engine.ts` processes does not restore `sessions.get`

Operational meaning:

- the gateway process is alive
- a meaningful RPC sub-surface is still unstable
- the defect is not explained only by a currently active autonomy write lock

### 2. Readiness used to overstate health

Before this pass:

- one successful autonomy sample could turn readiness green

After this pass:

- `scripts/openclaw-readiness.sh` now degrades when autonomy is thinking-only or probe results are unstable

### 3. Autonomy is still performing fake work

When gateway reads succeed, several auto-agent sessions still expose only `{"type":"thinking" ...}` previews and no visible action surface.

Operational meaning:

- not all degradation is transport-level
- some degradation is behavioral

### 4. Browser is recoverable, not yet stable

The browser smoke check frequently succeeds only after:

- direct-http auto-start

Operational meaning:

- browser capability exists
- browser steady-state readiness is still weaker than process liveness suggests

### 5. Session cleanup has its own bug

External runtime evidence:

- `/Users/lu/.openclaw/scripts/session-cleanup.py` throws:
  - `TypeError: '>=' not supported between instances of 'NoneType' and 'int'`

Operational meaning:

- background cleanup is not fully reliable
- this is a separate runtime defect outside the workspace scripts patched in this pass

### 6. Session cleanup crash was patched in the live runtime

Live fix installed:

- `/Users/lu/.openclaw/scripts/session-cleanup.py`
  - now normalizes `percentUsed=None` to `0`
  - skips invalid non-numeric `percentUsed` values instead of crashing

Operational meaning:

- the background cleanup job is no longer blocked by that `None >= threshold` crash
- it still depends on gateway status, so it is not a full recovery of the cleanup path

## Current Blocking Problems

1. `sessions.get` RPC instability
2. thinking-only autonomous sessions
3. browser warm-state instability
4. broken external session-cleanup job

## Recovery Order

### P0

- repair or isolate `sessions.get` / gateway `1006` path
- stop treating thinking-only autonomy as acceptable readiness

### P1

- fix external `session-cleanup.py` `None` handling
- make browser stay warm instead of recovering on demand

### P2

- reduce prompt/doctrine loops in auto agents so gateway-readable sessions also show concrete action

## Current Best Truth Surface

Use these first:

- `scripts/openclaw-readiness.sh`
- `scripts/openclaw-autonomy-guard.sh 5`
- `scripts/openclaw-session-evidence.sh autonomy 5`
- `openclaw gateway call sessions.get --params '{"key":"agent:reviewer-auto:main","limit":5}' --json`

Do not rely on a stale `readiness-last.json` alone.

## Follow-up Repair: False `thinking-only` autonomy signal removed

### What changed

- `scripts/openclaw-session-evidence.sh`
  - now distinguishes assistant `thinking` content from assistant non-thinking text in local transcript evidence
  - exports per-session stats:
    - `assistant_thinking_messages`
    - `assistant_nonthinking_messages`
    - `latest_assistant_kind`
- `scripts/openclaw-autonomy-guard.sh`
  - no longer marks a session as `thinking-only` when transcript evidence shows mixed `thinking + text`
  - only flags `thinking-only` if local transcript has assistant thinking messages and zero non-thinking assistant messages
  - keeps a separate `flaky` path for sessions whose latest assistant state is still mid-thinking

### Verified result after the fix

- `scripts/openclaw-session-evidence.sh autonomy 5`
  - now shows `reviewer-auto`, `world-model`, `goal-manager-auto`, and `evolution-auto` all carrying mixed `thinking + text` transcript evidence rather than pure thinking-only surfaces
- `scripts/openclaw-autonomy-guard.sh 5`
  - now returns `overall=ok`
- `scripts/openclaw-readiness.sh`
  - now returns `overall=ok`

### Important remaining limitation

- direct websocket RPC is still broken:
  - `openclaw gateway call sessions.get ...` still fails with `1006 abnormal closure`
  - `openclaw gateway call status --json` still fails with the same closure

Operational meaning:

- OpenClaw is back to normal-enough use on the local truth surface:
  - readiness is green
  - autonomy guard is green
  - AGI services are running
- but the low-level gateway call surface is still not root-caused or repaired
- current normal use therefore depends on transcript-backed local evidence, not on a fully healthy websocket RPC layer

## Follow-up Repair Attempt: RPC path still not root-fixed

### Live changes attempted

- Patched the installed CLI bundle at `/opt/homebrew/lib/node_modules/openclaw/dist/call-Bt8r959b.js`
  - removed default direct-RPC attachment of CLI `deviceIdentity`
- Patched the installed gateway bundle at `/opt/homebrew/lib/node_modules/openclaw/dist/gateway-cli-C2ZZYgwu.js`
  - added explicit logging to the top-level websocket upgrade `catch` path that previously only did `socket.destroy()`
- Restarted the LaunchAgent-managed gateway after both live patches

### Verified result

- `openclaw gateway status`
  - still reports `RPC probe: ok` after restart once the gateway is warm
- `openclaw gateway call status --json`
  - still fails with `gateway closed (1006 abnormal closure (no close frame))`
- `openclaw gateway call sessions.get --params '{"key":"agent:goal-manager-auto:main","limit":5}' --json`
  - still fails with the same `1006`
- the new upgrade-failure log hook did not emit

### Stronger inference after this attempt

- the remaining `1006` is not explained by the CLI's default `deviceIdentity` payload
- the remaining `1006` is also not explained by the top-level `httpServer.on("upgrade") ... catch` path
- the fault is therefore narrower than "generic auth rejection" and later than the easiest upgrade wrapper failure
- the most plausible remaining buckets are:
  - websocket stack failure after upgrade but before normal gateway handshake logging
  - runtime/service interruption during the call path
  - a deeper unlogged server-side exception outside the patched top-level upgrade catch

### Additional instability observed

- file logs still show repeated gateway `SIGTERM` events during this recovery window
- that makes the system usable again on the local truth surface, but not fully stable at the raw websocket RPC layer

## 2026-03-12 Watchdog Repair: stop self-inflicted gateway restart loops

### Root cause narrowed

- the repeated `SIGTERM` pattern is not only an external mystery or a gateway-internal crash
- `/Users/lu/.openclaw/scripts/watch-agi.sh` was actively issuing `openclaw gateway restart`
- the watchdog was allowed to trigger from:
  - recent gateway error storms parsed from `gateway.err.log`
  - immediate gateway probe degradation
- before this repair, the watchdog could re-trigger from the same old error window after cooldown, which created repeat restart loops and new `SIGTERM` churn

### Live repair applied

- patched live `/Users/lu/.openclaw/scripts/watch-agi.sh`
- added a gateway startup grace window after recovery
- changed recent-failure parsing so it only counts new gateway errors after the most recent recovery timestamp
- backup created:
  - `/Users/lu/.openclaw/scripts/watch-agi.sh.bak-20260312-1020`
- restarted AGI services with `/Users/lu/.openclaw/scripts/start-agi.sh` so the new watchdog loaded

### Verified result

- syntax check passed:
  - `bash -n /Users/lu/.openclaw/scripts/watch-agi.sh`
- new watchdog started cleanly at `2026-03-12T10:00:27+08:00`
- short observation window after restart did not produce another immediate `gateway restart`
- `scripts/openclaw-readiness.sh`
  - returned `overall=ok`
- `openclaw gateway status`
  - still reports `RPC probe: ok`

### Remaining tail after watchdog repair

- prior sandboxed checks still showed `1006 abnormal closure`
- but those checks were later proven to be misleading because the sandbox itself blocks the local websocket path

### Updated runtime judgment

- main use is back in a materially better state because watchdog-induced restart churn has been reduced
- the system is closer to stable normal use on the truth surface
- at this point the remaining uncertainty moved to whether `gateway call` was a real runtime fault or only a sandbox artifact

## 2026-03-12 Final RPC Verification: prior `1006` was a sandbox artifact

### What changed in the diagnosis

- earlier `openclaw gateway call ...` checks were executed inside the sandboxed Codex environment
- those calls reported `gateway closed (1006 abnormal closure)`
- a direct `GatewayClient` diagnostic run inside the sandbox showed the lower-level cause:
  - `connect EPERM 127.0.0.1:18789 - Local (0.0.0.0:0)`
- the same diagnostic run outside the sandbox completed normally:
  - `helloOk`
  - `healthOk`

### Real-environment verification

- `openclaw gateway call status --json`
  - succeeds outside sandbox
- `openclaw gateway call sessions.get --params '{"key":"agent:goal-manager-auto:main","limit":5}' --json`
  - succeeds outside sandbox
- direct real-environment `GatewayClient` matrix checks also succeeded for:
  - `mode=probe`
  - `mode=cli`
  - read scopes
  - admin scopes
  - with and without explicit device identity

### Corrected conclusion

- the previous “raw websocket RPC still broken” conclusion was incorrect
- the observed `1006` was produced by sandbox-local network restrictions, not by the live OpenClaw gateway runtime
- after correcting for that false signal, the meaningful runtime repairs are:
  - watchdog self-restart loop reduced
  - readiness / autonomy truth surface corrected
  - live `gateway call` path verified healthy in the real environment

### Current end-state

- OpenClaw is back in normal usable state on the real machine
- the main remaining risks are operational quality risks, not a confirmed live RPC transport fault:
  - future watchdog heuristic regressions
  - browser auto-start dependence
  - autonomy quality / `thinking-only` regressions if they recur
