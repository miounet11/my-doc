#!/bin/bash
set -euo pipefail
ROOT=/srv/my-doc
STATE=/opt/mydoc-review/state
OUT="$ROOT/content/archive/review/$(date +%F)"
mkdir -p "$OUT" "$STATE"
PROMPT_FILE=$(mktemp)
cat > "$PROMPT_FILE" <<'PROMPT'
You are an external reviewer auditing OpenClaw's current phase.
Be objective, concrete, and evidence-first.
Return markdown with sections:
1. Executive summary
2. Strengths
3. Weaknesses
4. Risks of self-deception
5. Next-step priorities
Use a 1-5 capability scale where relevant.
PROMPT
INTERNAL_CONTEXT=$(find "$ROOT/content/docs" "$ROOT/content/workspace-root" "$ROOT/content/memory" -maxdepth 2 -type f | sort | tail -n 40 | sed "s#^$ROOT/content/##")
PROMPT=$(printf "%s\n\nRecent internal artifacts:\n%s\n" "$(cat "$PROMPT_FILE")" "$INTERNAL_CONTEXT")
STATUS_FILE="$OUT/llm-review.status.txt"
RAW_FILE="$OUT/llm-review.raw.json"
OUT_FILE="$OUT/llm-review.md"
call_model() {
  local model="$1"
  local body
  body=$(jq -n --arg model "$model" --arg prompt "$PROMPT" '{model:$model,messages:[{role:"user",content:$prompt}]}')
  curl -sS -w '\nHTTP_STATUS:%{http_code}\n' https://ttqq.inping.com/v1/chat/completions \
    -H "Authorization: Bearer sk-lpMQv1pUG1zg1qRjoXJzT8NV10ODfCsBWLFR7Y3CXRchfdR1" \
    -H "Content-Type: application/json" \
    -d "$body"
}
RESP=$(call_model "gpt-5.4" || true)
STATUS=$(printf "%s" "$RESP" | awk -F: '/HTTP_STATUS:/{print $2}' | tail -n1)
BODY=$(printf "%s" "$RESP" | sed '/HTTP_STATUS:/d')
CONTENT=$(printf "%s" "$BODY" | jq -r '.choices[0].message.content // empty' 2>/dev/null || true)
MODEL_USED="gpt-5.4"
if [ -z "$CONTENT" ] || [ "$CONTENT" = "null" ]; then
  RESP=$(call_model "grok-420-thinking" || true)
  STATUS=$(printf "%s" "$RESP" | awk -F: '/HTTP_STATUS:/{print $2}' | tail -n1)
  BODY=$(printf "%s" "$RESP" | sed '/HTTP_STATUS:/d')
  CONTENT=$(printf "%s" "$BODY" | jq -r '.choices[0].message.content // empty' 2>/dev/null || true)
  MODEL_USED="grok-420-thinking"
fi
if [ -z "$CONTENT" ] || [ "$CONTENT" = "null" ]; then
  RESP=$(call_model "auto" || true)
  STATUS=$(printf "%s" "$RESP" | awk -F: '/HTTP_STATUS:/{print $2}' | tail -n1)
  BODY=$(printf "%s" "$RESP" | sed '/HTTP_STATUS:/d')
  CONTENT=$(printf "%s" "$BODY" | jq -r '.choices[0].message.content // empty' 2>/dev/null || true)
  MODEL_USED="auto"
fi
printf "model=%s\nstatus=%s\ngenerated_at=%s\n" "$MODEL_USED" "$STATUS" "$(date -Is)" > "$STATUS_FILE"
printf "%s\n" "$BODY" > "$RAW_FILE"
if [ -n "$CONTENT" ] && [ "$CONTENT" != "null" ]; then
  printf "%s\n" "$CONTENT" > "$OUT_FILE"
else
  printf "LLM review generation failed. See llm-review.raw.json and llm-review.status.txt\n" > "$OUT_FILE"
fi
