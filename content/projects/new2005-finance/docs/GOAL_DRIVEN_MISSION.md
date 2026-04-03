# New2005 Goal-Driven Mission

## Goal
Upgrade `www.new2005.com` from a recoverable live-data MVP into a stable, scalable, low-touch financial content system that can publish reliably and expand content volume quickly.

## Criteria
- [ ] `www.new2005.com` returns HTTP 200 consistently through the managed service path.
- [ ] The application process is supervisor-managed and restartable without manual `nohup` recovery.
- [ ] A rollback-capable release structure exists for deployments.
- [ ] Live stock APIs return non-demo data under normal conditions.
- [ ] A health endpoint exists and reports app/runtime/provider status truthfully.
- [ ] A Goal-Driven evidence board exists and can be updated after each meaningful step.
- [ ] Batch content generation can produce at least 20 assets with a recorded manifest.
- [ ] Generation failures are captured with retry/fallback policy instead of silent collapse.

## Evidence Required
- `curl` results for domain and health endpoints
- process or service status
- listening port proof
- release/rollback directory proof
- content manifest and sample generated files
- provider/live mode API proof

## Budgets
- Max wall time per implementation slice: 90 minutes
- Max blind retries of same failing tactic: 2
- Max strategy resets before pause/re-scope: 3

## Worker Scope
Allowed to change:
- `projects/new2005-finance/**`
- service/deploy config for the new2005 app on the target host
- docs, scripts, health checks, release structure, generation pipeline

Not allowed to change:
- unrelated projects/services on the VPS
- third-party public behavior outside required provider integrations

## Failure Policy
- If service is idle/down: inspect evidence, repair, restart, verify
- If deployment tactic repeats the same failure twice: switch strategy
- If generation fails without artifact: treat as unmet, record failure cause, apply fallback
- If criteria are partially met: update evidence board and continue from unmet criteria only
