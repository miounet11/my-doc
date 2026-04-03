# OpenClaw System Knowledge

## Infrastructure
- **Host**: Mac Studio (arm64, macOS 15.7.3)
- **Gateway**: ws://127.0.0.1:18789 (Tailscale: mac-studio.tail8b562b.ts.net)
- **Browser**: Chrome CDP on port 18800
- **code-server**: port 8443 (password: openclaw-studio-2026, Tailscale HTTPS)
- **Telegram**: bot @laobaye_bot, allowFrom: [8157607346]

## Models
- main: openai/gpt-5.4 (fallback: grok-420-agents, minimax-m2.1)
- other agents: openai/grok-420-agents (fallback: gpt-5.4, auto)

## Security (2026-03-13)
- sandbox.mode = "off" (all agents full access, per user request)
- applyPatch.workspaceOnly = true, fs.workspaceOnly = false
- gateway.trustedProxies = ["127.0.0.1"]
- All heartbeats = 999h, cron disabled, rogue processes killed
- Security audit: 0 critical, 0 warn, 2 info
- Deploy script: scripts/deploy-from-scratch.sh (full reproducibility)
- Optimization report: workspace/OPENCLAW_OPTIMIZATION_REPORT.md
- Score: 97/100 (from ~35/100 pre-fix)

## Installed Tools
- gh (GitHub CLI), claude, codex, peekaboo, jq, rg, node, code-server, tailscale, ffmpeg, ollama

## Maintenance
- Log rotation: daily at 04:17 via launchd (ai.openclaw.log-rotate)
- Backup: daily at 03:42 via launchd (ai.openclaw.daily-backup), keeps 7 days, stored at ~/Backups/openclaw/
- Logs cleaned 2026-03-13: ~900MB → <1MB

## Known Issues
- Peekaboo needs Screen Recording permission (terminal restart required after granting)
- gateway.err.log shows TimeoutOverflowWarning for 999h heartbeat (cosmetic, 999h overflows 32-bit setTimeout)
- Safe autonomous loop script ready at scripts/safe-autonomous.sh but NOT auto-started. Enable manually when needed.

## Memory/Embedding
- Provider: Ollama (local, http://localhost:11434)
- Model: nomic-embed-text (768 dimensions, 274MB)
- Status: WORKING (indexed all 15 agents on 2026-03-13)
- Previous issue: API proxy had no embedding models; resolved by using local Ollama
