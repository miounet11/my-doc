# OpenClaw + Ghost Desktop Overview

## One-line summary

Use **OpenClaw as the brain** and **Ghost OS as the macOS desktop execution layer**.

## Why this package exists

OpenClaw needs a clean way to drive native macOS applications when browser automation or shell commands are not the right surface. Ghost OS is a strong fit for that role because it is aimed at GUI automation and recipe-driven replay on macOS.

This repo packages that idea in a public-facing form:

- a skill folder that OpenClaw can consume
- docs that explain routing and verification
- a verification script that refuses to fake readiness

## Architecture boundary

### OpenClaw responsibilities

OpenClaw should remain responsible for:

- understanding the user request
- decomposing work across tools and surfaces
- choosing the correct execution surface
- collecting evidence
- deciding whether completion is verified, partial, or blocked

### Ghost OS responsibilities

Ghost OS should be used for:

- interacting with native macOS apps
- reading desktop UI context
- driving multi-window GUI flows
- replaying recipes for stable repeated workflows
- supporting guided learning and later recipe extraction

### What Ghost OS should not become

Ghost OS should **not** become:

- the memory system
- the planner
- the main control plane
- the sole source of truth for success
- a blanket replacement for browser or shell tools

## Recommended system picture

```text
User intent
  -> OpenClaw control plane
      -> Shell for CLI, files, local checks
      -> Browser for DOM-first web tasks
      -> ACP/Codex for code and repo work
      -> Ghost OS for native macOS GUI work
  -> Evidence returns to OpenClaw
  -> OpenClaw decides verified / partial / blocked
```

## Why macOS-only

This package stays narrow on purpose.

- Ghost Desktop in this repo is for **local macOS GUI automation**
- the permission model, app targets, and troubleshooting guidance are all macOS-specific
- keeping the scope narrow makes routing, verification, and documentation more honest

## Current maturity

As of **2026-03-17**, the authoring host confirmed:

- macOS is present
- `ghost` is **not** installed on `PATH`

So the current maturity level is:

- **adapter design: ready**
- **repo skeleton: ready**
- **skill packaging: ready**
- **host-level Ghost execution: not yet verified locally**

That distinction matters. This repo should not claim a working local Ghost integration until `ghost` is installed and `ghost doctor` succeeds.

## Good target use cases

Use Ghost OS through OpenClaw when the task needs one or more of these:

- Finder actions that are easier in native UI than shell-only logic
- Slack Desktop, Messages, Telegram Desktop, or other native app flows
- System Settings navigation
- cross-app workflows that jump between browser, Finder, and native dialogs
- repetitive GUI tasks that should become recipes

## Non-goals

This repo does not try to:

- ship Ghost OS itself
- prove upstream installation steps that were not tested here
- replace existing browser-first automation for normal websites
- claim recipe success without local verification evidence

## Recommended rollout sequence

1. Install Ghost OS on the host Mac
2. Run `./scripts/verify-ghost-os.sh`
3. Test 3-5 real workflows where native UI control actually matters
4. Keep only the flows where Ghost beats browser or shell alternatives
5. Promote those flows into recipes with explicit verification checks
6. Feed recipe metadata back into OpenClaw memory or docs
