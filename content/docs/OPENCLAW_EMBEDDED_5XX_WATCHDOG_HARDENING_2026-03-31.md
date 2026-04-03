# OpenClaw Embedded 5xx Watchdog Hardening

Date: 2026-03-31

## Problem

OpenClaw could look healthy at the control plane while still failing real agent turns.

Observed pattern:

- `openclaw gateway status` -> running
- `openclaw gateway health` -> `OK`
- direct provider call to `https://ttqq.inping.com/v1/chat/completions` -> `200`
- but `openclaw agent` -> repeated embedded-agent failures such as:
  - `504 status code (no body)`
  - upstream 5xx errors

That meant the runtime was degraded in the embedded execution path, not dead at the provider or channel layer.

## Root Cause

The live watchdog in `/Users/lu/.openclaw/scripts/watch-agi.sh` did not treat repeated embedded 5xx completions as a recovery trigger.

Before the fix, it only reacted to:

- embedded timeouts
- request aborted storms
- all-models-failed events
- stale session locks
- bad gateway probes

So a real failure family could accumulate without automatic recovery if it ended as repeated embedded 5xx terminal results instead of plain timeout lines.

## Fix

Patched the live watchdog to count recent embedded-agent 5xx end states inside the existing time window logic.

New trigger class:

- `[agent/embedded] embedded run agent end`
- `isError=true`
- and one of:
  - `504 status code`
  - `503`
  - `502`
  - `500`
  - `upstream error`
  - `Proxy pool exhausted`

New threshold env:

- `OPENCLAW_EMBEDDED_5XX_THRESHOLD`
- default set to `2`

Patched files:

- `/Users/lu/.openclaw/scripts/watch-agi.sh`
- `/Users/lu/.openclaw/scripts/start-agi.sh`

## Verification

Verified in live runtime:

1. direct provider smoke still returned `200`
2. OpenClaw embedded path emitted repeated fresh `504` failures
3. patched watchdog was reloaded
4. watchdog logged:
   - `recovery triggered: mode=full reason=embedded 5xx storm embedded_5xx=2`
5. recovery completed
6. post-recovery OpenClaw smoke returned:
   - `OPENCLAW_WATCHDOG_OK`

## Operational Rule

When these are simultaneously true:

- provider-direct smoke is healthy
- gateway health is healthy
- but `openclaw agent` keeps producing embedded 5xx end states

do not misclassify the incident as a key problem, Telegram problem, or upstream total outage.

Classify it as:

- embedded runtime degradation

and let the watchdog recover it automatically.

## Follow-up

If this still recurs too often, the next layer to harden is not cron or Telegram.
It is one of:

- OpenClaw embedded provider retry behavior
- session/context compaction strategy
- lighter default lane for trivial smoke turns
