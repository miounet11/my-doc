#!/usr/bin/env python3
from pathlib import Path
from datetime import datetime, timezone
import json

root = Path(__file__).resolve().parents[1]
content = root / 'content'
index = []
for p in sorted(content.rglob('*')):
    if p.is_file():
        stat = p.stat()
        index.append({
            'path': str(p.relative_to(content)),
            'size': stat.st_size,
            'modified': datetime.fromtimestamp(stat.st_mtime, timezone.utc).isoformat()
        })
(root / 'site-index.json').write_text(json.dumps({
    'generatedAt': datetime.now(timezone.utc).isoformat().replace('+00:00', 'Z'),
    'count': len(index),
    'items': index,
}, ensure_ascii=False, indent=2))
