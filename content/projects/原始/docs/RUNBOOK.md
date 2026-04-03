# Runbook

## Start
- `make dev`
- `docker compose up --build`

## Test
- `make test`
- `make smoke`
- `../../scripts/projectctl.sh doctor 原始`
- `../../scripts/projectctl.sh autonomy-evidence`
- `../../scripts/projectctl.sh autonomy-guard`

## Iterate With Claude Code
- `../../scripts/projectctl.sh brief 原始 1`
- `../../scripts/projectctl.sh complex-cycle 原始 18 "complex feature delivery"`
- `../../scripts/projectctl.sh proactive-next 10`
- `../../scripts/projectctl.sh browser-smoke`
- `../../scripts/projectctl.sh memory-bank-index`
- `../../scripts/projectctl.sh memory-bank-search "autonomy guard" 5`
- `../../scripts/projectctl.sh github-deploy-plan 原始`
- `../../scripts/projectctl.sh obsidian-sync 原始`
- OpenClaw 先生成任务，再把简报送入 Claude Code
- 完成后记录迭代结果并推进到下一轮
- 如需判断主脑/自动循环是否真的在工作，先看 `docs/EVIDENCE_BOARD.md`，再跑 `../../scripts/projectctl.sh autonomy-evidence`
- 如需判断主脑是否陷入重复循环，不要只看进程；跑 `../../scripts/projectctl.sh autonomy-guard`
- 如需走更复杂的开发工作流，优先走 `complex-cycle`，让 readiness / Claude / Codex / evidence 一次性留痕
- 如需沉淀浏览器表单工作，先建 spec：`../../scripts/projectctl.sh form-scaffold 名称 URL 原始`
- 如需准备对外汇报，先写本地草稿：`../../scripts/projectctl.sh mail-draft email "主题" /tmp/body.txt 原始`

## Control Model
- 人类给方向和标准
- Codex 负责教学、架构、审计
- OpenClaw 是正在成长的大脑
- Claude Code 是 OpenClaw 用来创造的手脚和工具

## Deploy
- Fill `ops/deploy.env`
- Run `./scripts/deploy.sh`


## Claude Code Squad
- `../../scripts/projectctl.sh squad-brief 原始 8`
- 输出目录：`docs/claude-squad-iteration-8/`
- 角色文件：`architect.md` / `coder.md` / `reviewer.md` / `profiler.md`
- 用法：由 OpenClaw 把对应角色 brief 分别交给 Claude Code 的不同 agent / subagent / 线程
- 目标：让 OpenClaw 学会拆解、分发、验收，而不是让 Claude Code 替代它思考


## Service
- `./scripts/serve.sh`
- `curl http://127.0.0.1:3000/health`
- `curl http://127.0.0.1:3000/profile`
- `curl -X POST http://127.0.0.1:3000/run`

## Audit
- `./scripts/audit.sh`
- report: `data/retrospectives/final-review.md`

## Re-annotation (Cognition Upgrade)
- `make reannotate`
- `./scripts/reannotate.sh openclaw-v1 openclaw-v2 "improved intent detection"`
- `./scripts/reannotate.sh openclaw-v2 openclaw-v3 "added emotion analysis" 50`
- See `docs/BOUNDARIES.md` for re-annotation strategy details

## Deployment
- Deployment guide: `docs/DEPLOYMENT.md`
