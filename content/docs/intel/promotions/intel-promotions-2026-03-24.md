# Intel Promotions - 2026-03-24

- generated_at: 2026-03-24 17:38:26 CST
- builders_report: /Users/lu/.openclaw/workspace/docs/intel/builders/high-output-builders-2026-03-24.md
- frontier_report: /Users/lu/.openclaw/workspace/docs/intel/frontier-ai-2026-03-24.md
- x_curated_report: /Users/lu/.openclaw/workspace/docs/intel/x-watch-curated/x-watch-curated-20260324-172229.json
- promotions: 3

- p0_now: 2
- p1_review: 1
- suppressed: builders=4 frontier=10 x=3

## Promotion Rule
- Promote only when an item plausibly changes OpenClaw workflow, tooling, evaluation, memory, or authority doctrine.
- Freshness alone does not qualify.
- X-only commentary does not qualify without artifact-backed corroboration.

- Repeated versions from the same recurring source family collapse to the latest/highest-signal item.

- Curated X items are supporting signal only and must clear a higher threshold than builders or feed-backed frontier items.

## P0 Now
- lane: builders
  score: 7
  date: March 20, 2026
  source: Claude Code Changelog
  source family: claude-code-changelog
  title: 2.1.81
  link: https://code.claude.com/docs/en/changelog
  why promote: Version 2.1.81 listed on Claude Code Changelog
  rationale: already ranked P0 in builder lane; explicit workflow/tool impact; direct execution-surface change
  promotion target: doctrine/workflow/evaluation
  action type: workflow patch

- lane: builders
  score: 7
  date: 2026-03-18T06:02:22+08:00
  source: GitHub Releases - obra/superpowers
  source family: obra-superpowers-releases
  title: v5.0.5
  link: https://github.com/obra/superpowers/releases/tag/v5.0.5
  why promote: New release movement from GitHub Releases - obra/superpowers: v5.0.5
  rationale: already ranked P0 in builder lane; explicit workflow/tool impact; builder methodology source with direct operator value
  promotion target: doctrine/workflow/evaluation
  action type: method review

## P1 Review
- lane: frontier
  score: 8
  date: 2026-03-24T12:00:00+08:00
  source: arXiv cs.AI
  source family: arxiv-cs-ai
  title: AgentComm-Bench: Stress-Testing Cooperative Embodied AI Under Latency, Packet Loss, and Bandwidth Collapse
  link: https://arxiv.org/abs/2603.20285
  why promote: Review for agent memory, tool use, evaluation, or long-context design impact before promoting into doctrine.
  rationale: title contains agentcomm; title contains latency; title contains packet loss; title contains bandwidth; title contains agent; embodied benchmark only
  promotion target: memory/doctrine/review-queue
  action type: evaluation review

