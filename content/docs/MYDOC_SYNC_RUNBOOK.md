# mydoc Sync Runbook

Date: 2026-03-24

## Purpose

This runbook defines the canonical sync and upload flow for `mydoc.inping.com`.

Use it to prevent two recurring failures:

- the mirror falls behind because only one-off files were published
- OpenClaw forgets the workflow because it only lived in daily memory

## Canonical Surfaces

Source of truth:

- workspace files under `/Users/lu/.openclaw/workspace`

Canonical local mirror and deploy tree:

- `/Users/lu/.openclaw/workspace/my-doc-site`

Legacy/stale copy unless explicitly re-wired:

- `/Users/lu/.openclaw/workspace/my-doc-site-repo`

Do not treat `my-doc-site-repo` as the active publish surface.

## Managed Mirror Logic

Managed workspace roots are declared in:

- `/Users/lu/.openclaw/workspace/my-doc-site/config/workspace-sync-manifest.json`

Current managed roots:

- `workspace-root/`
- `memory/`
- `docs/`
- `projects/*/docs/`

The sync is manifest-driven and delete-aware for those managed roots only.
It does not manage `content/public/`, `content/private/`, or `content/archive/`.

## Canonical Commands

Refresh the managed local mirror:

```bash
/Users/lu/.openclaw/workspace/scripts/sync-mydoc-workspace.sh
```

Refresh and deploy the full site tree to the VPS:

```bash
/Users/lu/.openclaw/workspace/scripts/sync-mydoc-workspace.sh --deploy
```

Refresh and publish using an explicit transport:

```bash
/Users/lu/.openclaw/workspace/scripts/sync-mydoc-workspace.sh --deploy --deploy-mode ssh
/Users/lu/.openclaw/workspace/scripts/sync-mydoc-workspace.sh --deploy --deploy-mode git
```

Publish one extra public deliverable:

```bash
/Users/lu/.openclaw/workspace/scripts/publish-mydoc-public.sh <source> [target]
```

Publish one extra private deliverable:

```bash
/Users/lu/.openclaw/workspace/scripts/publish-mydoc-private.sh <source> [target]
```

`publish-mydoc*.sh` now refreshes the managed mirror first, then publishes the requested public/private file.

## Auth And Recovery

Preferred auth path:

- `SSHPASS` if explicitly exported
- macOS Keychain internet-password entry for server `172.245.114.89`, account `root`, protocol `ssh `
- SSH agent only if password auth is unavailable

Automatic recovery path:

- local retry script: `/Users/lu/.openclaw/workspace/scripts/ensure-mydoc-deploy.sh`
- LaunchAgent: `~/Library/LaunchAgents/ai.openclaw.mydoc-deploy.plist`
- retry cadence: every 2 minutes plus `RunAtLoad`
- do not use aggressive SSH burst retries as the default recovery behavior
- verified lesson from 2026-03-25: this host can accept one clean SSH session after a quiet window, but repeated 2-second retry bursts can push it back into refusal/timeout behavior

Deploy transport behavior:

- `scripts/sync-mydoc-workspace.sh` and `scripts/publish-mydoc.sh` now try to establish one SSH control session first, then reuse that connection for `rsync` and remote rebuild
- this reduces handshake loss when `172.245.114.89:22` is flapping
- if the control session itself cannot be established, treat the blocker as external server reachability, not OpenClaw memory loss
- if one clean login succeeds after a quiet period, prefer a single-session deploy over reconnect-heavy probing
- `--deploy-mode auto` is now the default:
  - try SSH live publish first
  - if SSH is blocked, fall back to `git push` on the `my-doc-site` repo
  - write deploy state as `git-pushed-awaiting-live` instead of pretending the public site is live
- `--deploy-mode git` is durable sync only, not live publish
- Git fallback is for coordination and recoverability; SSH remains the path that actually updates `https://mydoc.inping.com/` today

Logs:

- `~/.openclaw/logs/mydoc-deploy-retry.log`
- `~/.openclaw/logs/mydoc-deploy-retry.launchd.out.log`
- `~/.openclaw/logs/mydoc-deploy-retry.launchd.err.log`

## When To Run It

Run the workspace sync after changes to:

- `MEMORY.md`
- `memory/YYYY-MM-DD.md`
- baseline doctrine files under `docs/`
- active project docs under `projects/*/docs/`
- workspace bootstrap files such as `AGENTS.md`, `HEARTBEAT.md`, `SOUL.md`, `USER.md`, `TOOLS.md`, and `IDENTITY.md`

## Verification Standard

Local verification:

- `my-doc-site/.last-workspace-sync.json` exists
- `my-doc-site/site-index.json` is rebuilt
- expected managed files exist under `my-doc-site/content/`

Deploy verification:

- root `https://mydoc.inping.com/` returns `200`
- key mirror URLs from `.last-workspace-sync.json` return `200`
- if remote SSH is unstable, `.last-workspace-deploy.json` must show `blocked` or `failed` with a concrete reason instead of silent drift
- if Git fallback runs, `.last-workspace-deploy.json` must show `git-pushed-awaiting-live`
- never present `git-pushed-awaiting-live` as a public delivery claim

## Durable Rule

One-off `publish-mydoc` uploads are not a substitute for the canonical workspace mirror sync.
If the managed mirror is not refreshed, the site will drift and future sessions will infer stale state.
