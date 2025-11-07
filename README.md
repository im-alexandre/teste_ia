# mcda_xandao — Django + Docker + PostgreSQL (Coolify-ready)

Projeto Django criado com `django-admin startproject` e `python manage.py startapp mcda_xandao`, preparado para desenvolvimento local via Docker Compose e deploy no Coolify (com Traefik).

## Requisitos
- Docker e Docker Compose

## Estrutura do projeto
- Código do app: `web/mcda_xandao/` (views, models, admin, tests)
- Config do projeto: `web/config/` (settings, urls, asgi/wsgi)
- Templates: `web/templates/` com parciais em `web/templates/partials/`
- Estáticos (dev): `web/static/` → publicados em produção em `web/staticfiles/`
- Infra: `docker-compose.yml`, `web/Dockerfile`, `web/entrypoint.sh`

Páginas:
- `/` — Home renderizada via template `home.html` (base moderna com header e footer)
- `/admin/` — Admin do Django
- `/healthz` — Healthcheck JSON

## Como foi gerado
```bash
python -m venv .venv
. .venv/Scripts/activate  # Windows PowerShell: .\.venv\Scripts\Activate.ps1
pip install "Django>=5,<6"
django-admin startproject config .
python manage.py startapp mcda_xandao
```

## Rodando localmente
1. Copie as variáveis de ambiente:
   ```bash
   cp .env.example .env  # PowerShell: Copy-Item .env.example .env
   ```
2. Suba os serviços com hot-reload e porta mapeada:
   ```bash
   docker compose up --build
   ```
3. Acesse:
   - App: http://localhost:8000/
   - Healthcheck: http://localhost:8000/healthz

Observações:
- Em desenvolvimento, `docker-compose.override.yml` usa `runserver` com `DEBUG=1` e desativa `collectstatic`.
- O banco usa credenciais padrão configuráveis via `.env`.

### Dev sem Docker
```bash
python web/manage.py runserver
```

## Front-end (templates & estáticos)
- Base de layout: `web/templates/base.html` com blocks `title`, `extra_head`, `content`, `extra_js` e includes de `partials/_header.html` e `partials/_footer.html`.
- Home: `web/templates/home.html` usando `{% extends 'base.html' %}`.
- Estilos & scripts: `web/static/css/style.css` e `web/static/js/app.js` (carregados via `{% load static %}`).

Coleta de estáticos (produção/CI):
```bash
docker compose run --rm web python manage.py collectstatic --noinput
```

## Deploy no Coolify (com Traefik)
1. Adicione este repositório ao Coolify como aplicação (Docker Compose).
2. Selecione o arquivo `docker-compose.yml` (não inclua o `docker-compose.override.yml`).
3. Configure variáveis na aplicação:
   - `SECRET_KEY` (obrigatório)
   - `DEBUG=0`
   - `ALLOWED_HOSTS=seu-dominio.com`
   - `CSRF_TRUSTED_ORIGINS=https://seu-dominio.com`
   - `DJANGO_COLLECTSTATIC=1`
   - `PORT=8000`
   - Banco: `DATABASE_URL=postgres://user:pass@host:5432/dbname` (ou `DB_*` variables)
4. Conecte um Postgres do Coolify (ou externo) e ajuste `DATABASE_URL`.
5. Defina o domínio. O Traefik roteará para a porta interna (`8000`).
6. Deploy. O container executa `migrate` e `collectstatic` (se `DJANGO_COLLECTSTATIC=1`).

## Comandos úteis
- Criar superusuário:
  ```bash
  docker compose exec web python manage.py createsuperuser
  ```
- Rodar migrações manualmente:
  ```bash
  docker compose exec web python manage.py migrate
  ```

- Rodar testes:
  ```bash
  docker compose run --rm web python manage.py test
  ```

## Notas de segurança
- Em produção, `DEBUG=0` e `SECRET_KEY` forte.
- `ALLOWED_HOSTS` e `CSRF_TRUSTED_ORIGINS` devem incluir seu domínio (com `https://`).

— Veja também: `AGENTS.md` para guias de contribuição e padrões do repositório.
