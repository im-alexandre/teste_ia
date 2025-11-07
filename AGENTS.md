# Repository Guidelines

## Project Structure & Module Organization
- App code: `web/mcda_xandao/` (views, models, tests).
- Project config: `web/config/` (settings, urls, wsgi/asgi).
- Templates: `web/templates/` with partials in `web/templates/partials/`.
- Static assets (dev): `web/static/` → served at `/static/` (collected to `web/staticfiles/`).
- Entrypoints & infra: `web/Dockerfile`, `web/entrypoint.sh`, `docker-compose.yml`.

Example layout:
```
web/
  manage.py
  config/ ...
  mcda_xandao/ ...
  templates/ (base.html, home.html, partials/_header.html)
  static/ (css/, js/)
```

## Build, Test, and Development Commands
- Run locally (Docker): `docker compose up --build`
- Migrations: `docker compose run --rm web python manage.py migrate`
- Create app superuser: `docker compose run --rm web python manage.py createsuperuser`
- Tests: `docker compose run --rm web python manage.py test`
- Dev server (non‑Docker): `python web/manage.py runserver`

## Coding Style & Naming Conventions
- Python: PEP 8, 4‑space indent; `snake_case` for functions/vars, `PascalCase` for classes.
- Templates: use Jinja/Django blocks; partials in `partials/` prefixed with `_` (e.g., `_footer.html`).
- Static: group by type (`css/`, `js/`); filenames `kebab-case`.
- Keep functions small and view logic thin; move formatting to templates and utilities.

## Testing Guidelines
- Framework: Django `unittest` (`manage.py test`).
- Place tests in `web/mcda_xandao/tests.py` or `tests/` modules; name files `test_*.py`.
- Write unit tests for views and simple integration for URLs; mock external services.

## Commit & Pull Request Guidelines
- Commits: imperative mood and scoped changes (e.g., "Add base template and header").
- Reference issues (e.g., `Fixes #12`).
- PRs: include description, screenshots for UI changes, steps to test, and migration notes.

## Security & Configuration Tips
- Never commit secrets. Use env vars: `SECRET_KEY`, `DEBUG`, `ALLOWED_HOSTS`, `DATABASE_URL`.
- Static in production: run `python manage.py collectstatic` (WhiteNoise serves from `staticfiles/`).
- Set `CSRF_TRUSTED_ORIGINS` and review HTTPS settings in `web/config/settings.py`.

## Agent‑Specific Notes
- Keep diffs minimal; follow existing structure and naming.
- When adding views, wire URLs in `web/config/urls.py` and prefer templates over raw HTML.
- Responda em português do Brasil (pt‑BR) por padrão; mantenha o tom conciso, direto e cordial.
