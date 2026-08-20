#!/bin/bash
# SessionStart hook: подтягивает контекст проекта в начало каждой сессии
# и ставит зависимости, если они появятся.
set -euo pipefail

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
cd "$ROOT"

# --- 1. Зависимости (пока нет — блок ждёт своего часа) ---------------------
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ]; then
  if [ -f package.json ]; then
    npm install --no-audit --no-fund >/dev/null 2>&1 || echo "‼️ npm install не прошёл"
  fi
  if [ -f requirements.txt ]; then
    pip install -q -r requirements.txt >/dev/null 2>&1 || echo "‼️ pip install не прошёл"
  fi
fi

# --- 2. Контекст проекта в сессию ------------------------------------------
echo "=== КОНТЕКСТ ПРОЕКТА «Контент-завод» (из session-start hook) ==="
echo

if [ -f docs/STATE.md ]; then
  echo "--- docs/STATE.md ---"
  cat docs/STATE.md
  echo
else
  echo "‼️ docs/STATE.md отсутствует — состояние проекта неизвестно."
  echo
fi

if [ -f docs/JOURNAL.md ]; then
  echo "--- Последняя запись в docs/JOURNAL.md ---"
  awk '/^## /{n++} n==1' docs/JOURNAL.md | head -30
  echo
fi

if [ -f docs/ROADMAP.md ]; then
  echo "--- Незакрытые пункты docs/ROADMAP.md ---"
  grep -n -- "- \[[ ~]\]" docs/ROADMAP.md | head -12 || true
  echo
fi

echo "--- Git ---"
echo "ветка: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
CHANGED="$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
echo "незакоммиченных файлов: $CHANGED"
echo
echo "Дальше: следуй протоколу /start из CLAUDE.md — сверься со STATE.md и ROADMAP.md,"
echo "коротко отчитайся, где мы остановились, и спроси, чем занимаемся."
echo "=== конец контекста ==="
