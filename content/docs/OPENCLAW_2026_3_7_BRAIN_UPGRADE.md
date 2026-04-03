# OpenClaw 2026.3.7 Brain Upgrade

## Purpose

Translate the `2026.3.7` runtime upgrade into concrete brain-level upgrades instead of treating it as a passive version bump.

## Adopted Now

- `agents.defaults.compaction.recentTurnsPreserve = 6`
  - Preserve a bounded recent-turn window so long sessions do not lose immediate task intent after compaction.
- `agents.defaults.compaction.postCompactionSections = ["Every Session", "Safety"]`
  - Re-inject the AGENTS sections that carry startup discipline and safety constraints.
- `plugins.slots.contextEngine = "legacy"`
  - Make the current context engine explicit.
  - New context-engine extensibility exists in `2026.3.7`, but we are not switching engines until the current supervision/evidence loop is measurably stable.

## Adopted In Runtime And Protocol

- `sessions.get`
  - Use as the preferred inspection surface when debugging session drift, stuck state, or compaction side effects.
  - Runtime entrypoint: `scripts/openclaw-session-evidence.sh`
  - Current safety stance: if `sessions.get` closes the gateway RPC, degrade to `world-state/status/heartbeat` evidence instead of losing visibility.
- `prependSystemContext` / `appendSystemContext`
  - Treat as the right place for stable static guidance when a plugin needs system-level guidance.
  - This is better than uncontrolled repeated prompt injection because it reduces prompt churn and is cache-friendly.
- `plugins.entries.<id>.hooks.allowPromptInjection`
  - Default stance: keep prompt mutation disabled unless a plugin is specifically audited.

## Not Enabled Yet

- Alternative context engines
  - Reason: the current system still has unresolved timeout, lock, and invalid-output problems.
  - Adding a non-legacy context engine now would increase the state space before the baseline is stable.

## Main-Brain Upgrade

The main brain should now reason with these defaults:

- Compaction is a reliability boundary, not just a memory optimization.
- Session inspection should be evidence-based, not inferred from narrative summaries.
- Stable guidance should migrate to system-context space when plugin support is used.
- Prompt mutation is a security and drift surface; default to denial.

## Acceptance Test

This upgrade counts as real only if:

- config stays valid
- gateway still probes healthy
- compaction settings are explicit in live config
- future retrospectives stop treating compaction and plugin behavior as invisible background details
