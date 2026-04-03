# Iteration 19 - Deduplication Engine

## What Changed

### Problem
Every pipeline run re-ingested all source events with new UUIDs. Result: **500 events in store, only 83 unique** (83.4% duplicate rate). All downstream stages — annotations, profiles, retrospectives — were polluted by repeated content.

### Solution: Content Fingerprinting + Dedup

1. **`schemas.py`**: Added `content_fingerprint()` — deterministic SHA256-based hash of `(source, speaker, content, conversation_id)`. Added `fingerprint` field to `Event` dataclass, auto-computed on `Event.create()`.

2. **`storage.py`**: `JsonlEventStore.write()` now deduplicates by default:
   - Lazy-loads fingerprint index from existing JSONL files on first write
   - Returns `None` (skip) if fingerprint already seen
   - Backward-compatible: computes fingerprints for old events missing the field
   - New `deduplicate()` method for cleaning existing data in-place
   - `dedup=False` parameter available for tests/migration

3. **`pipeline.py`**: Ingest stage now tracks `dedup_skipped` count in stage output.

4. **`dedup.py`**: New CLI module — `python3 -m yuanshi.dedup [--dry-run] [--events PATH]`

5. **`scripts/dedup.sh`** + **Makefile targets**: `make dedup`, `make dedup-dry`

### Data Cleanup
Ran dedup on live data: **500 → 83 events**, 417 duplicates removed. Old timestamp-named files consolidated to date-based naming.

## Files Modified
- `src/yuanshi/schemas.py` — fingerprint function + Event.fingerprint field
- `src/yuanshi/storage.py` — dedup-aware write, deduplicate(), fingerprint index
- `src/yuanshi/pipeline.py` — dedup tracking in ingest stage
- `src/yuanshi/dedup.py` — NEW: dedup CLI
- `scripts/dedup.sh` — NEW: shell wrapper
- `Makefile` — NEW targets: dedup, dedup-dry
- `tests/test_dedup.py` — NEW: 12 tests covering fingerprinting, write dedup, backfill, in-place cleanup
- `data/events/` — cleaned: 500→83 events

## Test
```bash
make test  # 77 tests, all pass
make dedup-dry  # verify no new duplicates
```

## How This Helps OpenClaw
- **Memory quality**: No more duplicate events polluting annotation and profile stages
- **Judgment**: Pipeline can now distinguish "already seen" from "new" — prerequisite for incremental ingest
- **Self-correction**: `make dedup-dry` provides ongoing data hygiene verification

## Next Iteration Suggestions (no human prompting needed)
1. **Orphaned annotation cleanup** — annotations pointing to removed duplicate event_ids need garbage collection
2. **Incremental ingest** — track last-ingested position per source file, only parse new content
3. **Profile rebuild** — re-run profile/retrospective on clean 83-event dataset for accurate understanding
