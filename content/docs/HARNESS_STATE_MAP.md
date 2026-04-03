# Harness State Map

Status: active reference
Date: 2026-03-31

## Purpose
Provide a compact state model so OpenClaw can choose honest labels quickly.

## Primary States
### `drafted`
- a proposal, draft, or plan exists
- no meaningful execution or task verification yet

### `implemented`
- an artifact or action exists
- original ask not yet verified

### `self-checked`
- internal review/check performed
- no independent task-level verification yet

### `task-verified`
- original ask checked directly
- current evidence supports task success

### `full-chain verified`
- task verified plus final expected delivery surface verified

### `blocked`
- real blocker prevents progress or verification

### `degraded`
- partial progress or reduced verification only

### `mock`
- simulated/static/illustrative output only

## Secondary Repair States
### `repair planned`
- failure understood, next repair step known

### `repair in progress`
- corrective step underway

## Fast Transitions
- drafted -> implemented
- implemented -> self-checked
- self-checked -> task-verified
- task-verified -> full-chain verified
- any state -> blocked / degraded / mock
- failed verification -> repair planned / repair in progress / blocked / degraded

## Forbidden Shortcuts
- drafted -> full-chain verified
- implemented -> full-chain verified
- self-checked -> full-chain verified
- stale evidence -> current verified state
