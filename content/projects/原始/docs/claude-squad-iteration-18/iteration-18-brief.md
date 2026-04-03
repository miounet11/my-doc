# Iteration 18 Brief - Smart Annotator Upgrade

## What Changed

### Problem
The annotator was brain-dead: every event got `emotion="focused"` and `confidence=0.68` regardless of content. Profile and retrospective were built on meaningless data. The `theme` field required by the annotation protocol didn't exist. `EventStore.read_range()` was defined in the protocol but not implemented.

### Changes

| File | Change |
|------|--------|
| `schemas.py` | Added `theme` field to `Annotation` (default `"general"`, backward compatible) |
| `annotate.py` | Added `infer_emotion()` (7 emotions), `infer_theme()` (8 themes), `compute_confidence()` (signal-based) |
| `storage.py` | Implemented `read_range(start, end)` on `JsonlEventStore` |
| `profile.py` | Profile now includes `top_themes`, `emotion_mix`; hypotheses derive from emotion/theme signals |
| `retrospect.py` | Retrospective now includes `top_theme`, `dominant_emotion`, `avg_confidence`, distributions |
| `tests/test_smart_annotator.py` | 22 new tests covering emotion, theme, confidence, read_range |

### Test Results
- Before: 35/35
- After: 57/57

## How This Helps OpenClaw

### Memory
- Annotations now carry real semantic signal (emotion, theme, confidence) instead of placeholders
- Profile snapshots are actually informative — they reflect what Lu talks about and how

### Judgment
- `compute_confidence` is explicit about what it knows vs doesn't know
- Low-signal short messages get low confidence; multi-signal content gets high confidence

### Self-correction
- When cognition upgrades trigger re-annotation, the new annotator produces genuinely different (better) results
- The supersede chain now has meaning: old annotations say `emotion=focused, confidence=0.68`, new ones say `emotion=curious, theme=architecture, confidence=0.75`

### Decomposition
- Theme extraction separates "what topic" from "what intent" — two orthogonal axes for understanding Lu

## Backward Compatibility
- `theme` field defaults to `"general"` — old annotations without it still work
- All legacy functions preserved
- Old JSONL data loads fine (missing `theme` just reads as default)

## Next Iteration Suggestions
1. **Re-annotate existing events** with the new annotator to populate theme/emotion across the corpus
2. **Add `follow_up` and `insight` fields** from the annotation protocol (still missing)
3. **Confidence calibration** — track whether high-confidence annotations correlate with user validation
4. **Query by theme/emotion** — add theme and emotion filters to `AnnotationQuery`
