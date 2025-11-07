#!/bin/sh
set -e

python --version

echo "Running database migrations..."
python manage.py migrate --noinput

if [ "${DJANGO_COLLECTSTATIC}" = "1" ]; then
  echo "Collecting static files..."
  python manage.py collectstatic --noinput
fi

exec gunicorn config.wsgi:application \
  --workers ${WEB_CONCURRENCY:-3} \
  --bind 0.0.0.0:${PORT:-8000} \
  --timeout ${GUNICORN_TIMEOUT:-60}

