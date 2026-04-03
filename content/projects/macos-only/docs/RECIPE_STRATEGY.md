# Recipe Strategy

## Principle

If a desktop workflow is likely to repeat, turn it into a recipe instead of repeating freehand GUI control forever.

## Why recipes matter

Recipes make Ghost OS more useful to OpenClaw because they are:

- faster than re-discovering every UI path
- easier to parameterize
- easier to review and improve
- easier to verify consistently
- better building blocks for higher-level planning

## Current truth

This repo intentionally ships **strategy before a claimed recipe inventory**.

Reason:

- the authoring host did not have `ghost` installed on **2026-03-17**
- there is no honest basis yet to publish a list of locally proven recipes

That is not a weakness. It is the right evidence posture.

## When to promote a flow into a recipe

Promote a workflow when it is:

- repeated often
- stable enough that the UI path does not change every day
- valuable enough to justify maintenance
- safer when parameterized than when improvised

Good early candidates:

- Finder move/copy/export flows
- Slack Desktop send or reply flows
- System Settings navigation
- repetitive cross-app handoff workflows

## What a good recipe should contain

A good Ghost recipe should define:

- a clear name
- intent and scope
- required inputs
- preconditions
- the smallest reliable action sequence
- explicit waits or state checks
- explicit postconditions
- failure notes
- last verification date

## Recommended metadata format

Even if the execution format changes upstream, the durable metadata should stay simple.

Suggested fields:

```text
name:
purpose:
status: draft | verified | blocked | deprecated
inputs:
preconditions:
steps:
verification:
last_verified:
app_dependencies:
risk_notes:
```

## Design rules

### 1. Parameterize inputs

Do not hardcode values that should vary, such as:

- recipient name
- folder name
- message text
- export destination

### 2. Keep the path narrow

A recipe should do one job well. If a workflow mixes navigation, editing, and publishing, split it unless the whole sequence is reliably inseparable.

### 3. Build verification into the recipe

The recipe should know what success looks like.

Examples:

- text appears in compose area
- target window title changes
- exported file exists in target location
- target toggle is visibly on

### 4. Fail loudly

If the expected state is not present, the recipe should stop and report the mismatch instead of bluffing past it.

### 5. Record freshness

Desktop workflows drift. A recipe without a recent verification date is only a candidate, not a promise.

## Suggested maturity ladder

### Draft

The workflow idea exists, but local execution is not yet proven.

### Verified once

The flow worked on one real machine with real evidence.

### Stable

The flow survived repeated runs or minor UI changes.

### Needs repair

The flow used to work but the UI changed or verification regressed.

### Deprecated

The recipe is no longer worth maintaining because shell, browser, or another integration is better.

## Suggested first recipe backlog

Practical first candidates for this repo once Ghost is installed:

1. `finder-move-file`
2. `finder-create-folder`
3. `slack-send-message`
4. `telegram-desktop-open-thread`
5. `system-settings-open-privacy-pane`

Treat that list as a backlog, not as proof that these recipes already exist.

## OpenClaw integration note

OpenClaw should store recipe knowledge as part of its control plane memory, not inside Ghost alone.

Useful memory fields include:

- recipe name
- what it is good for
- required parameters
- last verified date
- host-specific caveats
- preferred fallback surface if the recipe fails
