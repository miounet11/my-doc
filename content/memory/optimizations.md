## 2026-03-26
- Optimization opportunity: stop presenting the benchmark/dashboard surface as live evidence until the runner produces real measurements. Short-term fix: label dashboard as static/mock. Next step: replace mock JSON generation in `evals/benchmark-runner.sh` with real evaluator output and surface freshness metadata from actual files under `evals/results/`.

## 2026-04-03
- Optimization opportunity: the dashboard header is already labeled mock/static, but section-level KPI cards and agent/test rows still present precise benchmark numbers without repeated inline `mock/blocked` status. Next step: relabel or suppress those detailed metrics until they are backed by a real runner, and prefer freshness/status metadata sourced from actual result artifacts.

## 2026-03-13
- Weekly benchmark remains above threshold; no regression detected.
- Optimization opportunity: the benchmark summary is healthy, so next leverage is not raw performance tuning but making the acceptance/dashboard evidence easier to inspect from one place.
