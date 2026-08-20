# JOURNAL.md — журнал сессий

> Append-only: новые записи сверху. Ничего не удаляем и не переписываем.
> По одной записи на сессию, 5–10 строк.

---

## 2026-08-20 — Сессия 1: каркас проекта

**Задача:** настроить проект так, чтобы новая сессия подхватывала контекст автоматически.

**Сделано:**
- Создан `CLAUDE.md` — правила работы и карта репозитория
- Созданы `docs/PROJECT.md`, `ROADMAP.md`, `STATE.md`, `JOURNAL.md`, `DECISIONS.md`
- Создан SessionStart-хук `.claude/hooks/session-start.sh` и `.claude/settings.json`
- Добавлены команды `/start` и `/finish`
- Заведены папки `content/{ideas,drafts,published}` и `templates/`

**Артефакты:** ветка `claude/cloud-project-setup-fcame9`

**Дальше:** заполнить `PROJECT.md` под реальную нишу, смёржить в `main`.
