# AibrowserAtlas v1 Release

Patch closure note:

- current runtime line: `1.0.2 stable`
- baseline release date remains `2026-03-13`
- closure patch date: `2026-03-18`
- this patch keeps the v1 workspace scope intact while replacing the public mac client line with a rebuilt `1.0.2` package that fixes the hardened-runtime startup crash

## Release Identity

- Product: `AibrowserAtlas`
- Version: `1.0.2`
- Stage: `v1`
- Channel: `stable`
- Release date: `2026-03-18`
- Codename: `iAtlas`

## What v1 Means

`1.0.2` is the stable v1 patch line where the product is no longer just a chat proxy with uploads. It is one coherent workspace for conversation, retrieval, orchestration, and session-level knowledge management, with the public package line refreshed to remove the mac desktop startup crash.

The release standard for v1 is:

- the public domain serves the new product surface
- the main user flows pass scripted acceptance
- the chat workbench has a stable interaction model for active sessions
- version identity is visible both in runtime metadata and in release docs
- the owner-approved direct cutover policy removes any remaining manual sign-off gate

## Product Scope Locked Into v1

- account registration and login with invite code `2026`
- streaming chat with automatic agent routing
- persisted session memory and session archive management
- session pinning and local conversation filtering
- knowledge uploads from files, folders, quick notes, and images
- background knowledge import jobs with persisted queue state
- unified search across sessions, knowledge, and memories
- retrieval evidence rendering through trace badges and citation panels
- user-turn edit, assistant regenerate, and truncate-backed delete flows
- focused workspace mode for active sessions
- contextual right drawer for active-session tooling
- hover and focus reveal for secondary message controls
- public download center with exact package URLs and truth-based package labeling
- desktop test packages, Android test/build artifacts, and iOS/Harmony source bundles
- real conversation-to-artifact delivery for `PPTX` slides, `DOCX` documents, and website `ZIP` bundles

## Architectural Outcome

v1 settles on a three-surface model:

- left rail: conversation inventory and archive control
- center stage: chat-first execution surface with docked composer
- right rail: contextual tools that collapse into a drawer in active sessions

This is the key product correction made during the final stretch. The product now behaves like a chat workspace first, with orchestration and library controls available on demand instead of permanently competing with the message timeline.

## Quality Bar Reached

- release metadata is centralized in `VERSION.json`
- server exposes `/api/version` and includes release info in `/health`
- server exposes `/api/capabilities` so the frontend can show only live modes and delivery channels
- server exposes `/api/downloads` and serves published client artifacts under `/downloads/files/*`
- server can turn a persisted session into real `PPTX`, `DOCX`, and website `ZIP` files, not just JSON/markdown exports
- acceptance evidence is version-aware and updates `data/acceptance/latest.json`
- acceptance now verifies capability exposure plus real `DOCX` and website `ZIP` generation chains
- focused active-session layout was live-verified before release
- hover and focus message actions were changed from fragile CSS assumptions to explicit UI state
- public homepage download cards were live-verified with exact package URLs and installability labels
- mac client packaging was upgraded from ad-hoc signing to Developer ID signed `app` + `DMG`, while still staying truthful about missing notarization

## Evidence

- latest acceptance summary: [latest.json](/Users/lu/.openclaw/workspace/projects/chat-mirror/data/acceptance/latest.json)
- formal v1 acceptance run: [20260313T043120Z.json](/Users/lu/.openclaw/workspace/projects/chat-mirror/data/acceptance/20260313T043120Z.json)
- focused/drawer validation run: [20260313T033102Z.json](/Users/lu/.openclaw/workspace/projects/chat-mirror/data/acceptance/20260313T033102Z.json)
- UI density audit: [UI_DENSITY_AUDIT_2026-03-13.md](/Users/lu/.openclaw/workspace/projects/chat-mirror/docs/UI_DENSITY_AUDIT_2026-03-13.md)
- download center live evidence: `www.aibrowseratlas.com` with `10 packages live`, `6 installable now`, `3 source bundles`
- live capability evidence: `GET https://chat.aibrowseratlas.com/api/capabilities` returns the full creation surface, and production currently exposes `email` because the delivery channel is configured

## Remaining Truth After v1

v1 is the first formal release, not the end state. The main remaining product work is no longer baseline stability. It is refinement:

- make the message timeline feel even lighter under long-session load
- keep reducing contextual chrome around secondary controls
- continue hardening orchestration visibility without bloating the default chat surface

## Summary

`AibrowserAtlas v1.0.2` is the point where the project becomes a coherent product: stable enough to deploy, inspect, accept, package, and refer to as a real versioned system rather than a moving target, with the public mac package line repaired for actual desktop use.
