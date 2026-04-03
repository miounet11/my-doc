# Chat Mirror Decisions

## 2026-03-14

### Use Node 22 as the default engineering runtime

- Reason:
  Node 22 is the safest common path for `better-sqlite3`, `bcrypt`, local builds, and CI.
- Consequence:
  local scripts, CI, and troubleshooting should assume Node 22 first; Node 24 is fallback, Node 25+ is unsupported.

### Treat public acceptance as the release gate

- Reason:
  the project is already public-facing, so release truth must come from fresh scripted evidence rather than local build success.
- Consequence:
  local build and smoke are required for iteration speed, but public `acceptance.sh` remains the bar for saying a release is done.

### Add a minimum CI loop before more feature expansion

- Reason:
  iteration speed is now limited more by manual regression checking than by missing features.
- Consequence:
  the repository keeps a baseline GitHub Actions workflow that installs deps, builds both apps, starts the server, and runs smoke.
