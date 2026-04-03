#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
python3 scripts/build-index.py
python3 - <<'PY'
from pathlib import Path
import json
import html as html_mod

root = Path.cwd()
index_path = root / 'site-index.json'
site_dir = root / 'site'
site_dir.mkdir(parents=True, exist_ok=True)
html_path = site_dir / 'index.html'
items = []
if index_path.exists():
    data = json.loads(index_path.read_text(encoding='utf-8'))
    items = data.get('items', [])

public_items = [item for item in items if str(item.get('path', '')).startswith('public/')]
rows = []
for item in public_items[:300]:
    path = str(item.get('path', ''))
    modified = html_mod.escape(str(item.get('modified', '')))
    size = html_mod.escape(str(item.get('size', '')))
    label = path[len('public/'):] if path.startswith('public/') else path
    href = '/content/' + path
    rows.append(
        f"<tr><td><a href='{html_mod.escape(href, quote=True)}'>{html_mod.escape(label)}</a></td><td>{modified}</td><td>{size}</td></tr>"
    )

html = """<!doctype html><html><head><meta charset='utf-8'><meta name='viewport' content='width=device-width,initial-scale=1'><title>mydoc.inping.com</title><style>body{font-family:system-ui;padding:40px;max-width:980px;margin:auto;background:#0b1020;color:#e5e7eb}a{color:#93c5fd;text-decoration:none}table{width:100%;border-collapse:collapse}td,th{padding:10px;border-bottom:1px solid #243041;text-align:left}code{background:#111827;padding:2px 6px;border-radius:6px}.meta{opacity:.8}.notice{padding:14px 16px;background:#111827;border:1px solid #243041;border-radius:10px;margin:18px 0}.empty{opacity:.8;font-style:italic}</style></head><body><h1>mydoc.inping.com</h1><p>Protected documentation portal.</p><div class='notice'><strong>Access policy:</strong> password required for this site, including public materials. The homepage now exposes only the curated <code>public/</code> subset and no longer links directly to internal workspace-root or memory files.</div><p class='meta'>Visible index scope: <code>/content/public/</code></p><h2>Public documents</h2>"""

if rows:
    html += "<table><thead><tr><th>Path</th><th>Modified</th><th>Size</th></tr></thead><tbody>" + ''.join(rows) + "</tbody></table>"
else:
    html += "<p class='empty'>No public documents are currently indexed.</p>"

html += "</body></html>"
html_path.write_text(html, encoding='utf-8')
PY
