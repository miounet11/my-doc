# AI Frontier Loop

## Goal
Continuously feed OpenClaw and Claude Code with current frontier AI information from official sources, browser-accessible pages, and X.com signals.

## Priority Sources
1. Official product / research announcements
2. Official docs and release notes
3. Official repositories
4. X.com signals and public discussions

## Operating Rule
- Official sources establish facts.
- Browser and X.com add context, sentiment, and early signals.
- X.com never overrides official sources or reproducible engineering evidence.

## Execution Path
1. Trigger `frontier-ai-intel` for current AI updates.
2. Read official sources first.
3. If browser relay is attached, inspect X.com pages directly.
4. If browser relay is not attached, fall back to web/domain search on `x.com`.
5. Write a dated report into `docs/intel/`.
6. Promote durable patterns into OpenClaw doctrine and memory.

## Command Surface
- `./scripts/projectctl.sh intel-report <YYYY-MM-DD>`
- `./scripts/projectctl.sh mentor-loop <project> <start-iteration> [count]`

## Current Frontier Themes
- MCP as default tool protocol
- terminal-native AI agents
- built-in search grounding
- explicit memory and context management
- agent verification and evidence capture
- multi-agent orchestration with narrow roles
