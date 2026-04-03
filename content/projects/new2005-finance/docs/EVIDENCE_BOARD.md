# New2005 Goal-Driven Evidence Board

## Goal
Upgrade `www.new2005.com` from a recoverable live-data MVP into a stable, scalable, low-touch financial content system that can publish reliably and expand content volume quickly.

## Criteria Status
- domain returns 200 through managed service path: met
- supervisor-managed restartable process: unmet
- rollback-capable release structure: unmet
- live stock APIs return non-demo data: met
- health endpoint exists and reports truthfully: unmet
- evidence board maintained: met
- batch content generation emits at least 20 assets with manifest: unmet
- generation failures handled by retry/fallback policy: unmet

## Latest Evidence
- Public domain recovered after permission repair and local port 3010 restart.
- `api/stocks/AAPL` returned live provider-backed values after the fix.
- Current service is still hand-started rather than service-managed.
- Content generation CLI reached real remote LLM execution but failed with a 504 response from the configured gateway.

## Current Worker State
- deployment hardening: active
- content generation hardening: active
- verifier state: active

## Next Supervisory Action
1. Add a proper health endpoint and verify it locally.
2. Add release / rollback structure plus service management docs/scripts.
3. Harden content generation with retry/fallback and manifest-first failure recording.
