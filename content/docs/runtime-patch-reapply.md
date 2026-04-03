# OpenClaw Runtime Patch Reapply

## Purpose
Provide a durable operator note for the workspace repair script `scripts/reapply-openclaw-runtime-patches.sh` so the hot-patch path is not remembered only in daily chronology.

## What It Does
The script re-applies known local dist hot patches for OpenClaw `2026.3.24` under `/opt/homebrew/lib/node_modules/openclaw/dist`.

Current covered files:
- `status-DUu4C8tF.js`
- `status-json-Jwr2buEe.js`
- `channel-summary-BI4Ows9P.js`
- `gateway-cli-SPSnwPDk.js`
- `health-BKCofxn3.js`

It also:
- refuses to patch any OpenClaw version other than `2026.3.24`
- restarts the gateway only if a patch was actually applied
- runs a deep status verification and prints a small Telegram health summary

## When To Use
Use after:
- Homebrew reinstall or upgrade that replaces the patched dist files
- OpenClaw package repair that wipes local hot patches
- any regression where `status --deep` falls back to the old self-timeout / false Telegram summary behavior on the same runtime version

## Important Limits
- This is a local operator recovery path, not an upstream fix.
- It is intentionally version-gated. If OpenClaw is no longer `2026.3.24`, do not force it; inspect the new dist and create a new version-specific repair.
- Do not claim the underlying product bug is fixed globally just because this local reapply path succeeds.

## Verification Standard
After running, verify with current artifacts, not memory:
- `openclaw status --deep --json`
- visible Telegram configured/account fields in the JSON output
- direct agent smoke if needed

## Next Improvement
Upstream these fixes or replace this note/script with an official versioned patch workflow once OpenClaw includes the repairs natively.
