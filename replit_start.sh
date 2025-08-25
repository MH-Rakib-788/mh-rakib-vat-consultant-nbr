#!/usr/bin/env bash
set -e
echo ">> MH Rakib VAT Consultant (NBR) – Replit runner"
if command -v docker >/dev/null 2>&1; then
  echo "Docker available → docker compose up --build"
  docker compose up --build
else
  echo "Docker not available → starting direct processes"
  (cd backend && python -m venv venv && source venv/bin/activate && pip install -r requirements.txt && python manage.py migrate && python manage.py runserver 0.0.0.0:8000) &
  (cd frontend && npm i && export NEXT_PUBLIC_API_BASE_URL=http://localhost:8000/api && export NEXT_PUBLIC_BRAND='MH Rakib VAT Consultant (NBR) — VAT Consultancy Firm' && npm run dev) &
  wait -n
fi
