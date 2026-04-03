# Architecture - 原始

## Pipeline
1. Ingest
2. Normalize
3. Store immutable events
4. Annotate current interpretation
5. Re-annotate when cognition improves (see BOUNDARIES.md)
6. Synthesize retrospective
7. Update long-term memory

## Architecture Boundaries

See `docs/BOUNDARIES.md` for detailed boundary definitions.

- Storage Boundary: EventReader/Writer, AnnotationReader/Writer
- Computation Boundary: Annotator, ProfileBuilder, RetrospectiveBuilder
- Service Boundary: PipelineOrchestrator, PipelineContext, PipelineResult
- Re-annotation Boundary: CognitionUpgrade, ReAnnotationStrategy
- Adapter Boundary: SourceAdapter

## Storage Model
- `data/events/*.jsonl`：原始输入事件
- `data/annotations/*.jsonl`：事件注释版本
- `data/profiles/*.md`：阶段性用户理解画像
- `data/retrospectives/*.md`：周期复盘报告

## Event Schema
- `event_id`
- `timestamp`
- `source`
- `channel`
- `speaker`
- `content`
- `conversation_id`
- `metadata`

## Annotation Schema
- `annotation_id`
- `event_id`
- `created_at`
- `annotator`
- `cognition_version`
- `summary`
- `intent`
- `emotion`
- `importance`
- `actionable_need`
- `confidence`
- `supersedes`

## Design Constraints
- 原始事件不可覆写。
- 注释必须版本化。
- 每次认知升级允许批量重注释。
- 复盘必须引用事件和注释证据。
