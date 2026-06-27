# 🚀 Production Deployment Guide

## ☁️ Развертывание на Vercel/Netlify (Frontend)

### 1. Сборка Frontend
```bash
cd frontend
npm run build
# Файлы появятся в frontend/dist
```

### 2. Развертывание на Vercel

```bash
# Установить Vercel CLI
npm install -g vercel

# Развернуть
vercel
```

Настройте в `vercel.json`:
```json
{
  "rewrites": [
    {
      "source": "/api/:path*",
      "destination": "https://your-backend.com/api/:path*"
    }
  ]
}
```

### 3. Развертывание на Netlify

```bash
# Установить Netlify CLI
npm install -g netlify-cli

# Развернуть
netlify deploy --prod --dir=frontend/dist
```

Настройте `netlify.toml`:
```toml
[[redirects]]
  from = "/api/*"
  to = "https://your-backend.com/api/:splat"
  status = 200
```

---

## 🖥️ Развертывание Backend

### Вариант 1: Heroku (Бесплатно)

```bash
# Установить Heroku CLI
# https://devcenter.heroku.com/articles/heroku-cli

# Логин
heroku login

# Создать приложение
heroku create your-app-name

# Добавить Procfile в корень backend папки
echo "web: uvicorn main:app --host 0.0.0.0 --port \$PORT" > backend/Procfile

# Развернуть
cd backend
heroku git:remote -a your-app-name
git push heroku main

# Открыть
heroku open
```

### Вариант 2: Railway (Рекомендуется)

```bash
# Установить Railway CLI
npm install -g @railway/cli

# Логин
railway login

# Создать проект
railway init

# Развернуть
railway up
```

### Вариант 3: Docker + AWS/GCP/Azure

#### Dockerfile для Backend

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### Docker Compose для локальной работы

```yaml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=sqlite:///./marketplace.db
    volumes:
      - ./backend:/app

  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
```

---

## 🗄️ Миграция на PostgreSQL (Production)

### 1. Установка зависимостей

```bash
cd backend
pip install psycopg2-binary
```

### 2. Обновите `database.py`

```python
import os

# Для локальной разработки
if os.getenv("DATABASE_URL") is None:
    DATABASE_URL = "sqlite:///./marketplace_monitor.db"
else:
    # Для production
    DATABASE_URL = os.getenv("DATABASE_URL")
    # Преобразуйте postgres:// на postgresql://
    if DATABASE_URL.startswith("postgres://"):
        DATABASE_URL = DATABASE_URL.replace("postgres://", "postgresql://", 1)

engine = create_engine(
    DATABASE_URL,
    connect_args={"check_same_thread": False} if "sqlite" in DATABASE_URL else {}
)
```

### 3. Создайте PostgreSQL базу на хостинге

Варианты:
- **Heroku Postgres**: `heroku addons:create heroku-postgresql:hobby-dev`
- **Railway**: Создать PostgreSQL сервис
- **AWS RDS**: Создать RDS инстанс
- **Supabase**: Создать проект (Postgres + Auth)

### 4. Задайте переменные окружения

```bash
# Для Heroku
heroku config:set DATABASE_URL=postgresql://...

# Для Railway
railway variables set DATABASE_URL=postgresql://...

# Для Docker
export DATABASE_URL=postgresql://user:password@host:5432/dbname
```

---

## 🔐 Настройка CORS для Production

Обновите [backend/main.py](backend/main.py):

```python
origins = [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:5173",
    "https://your-frontend-domain.com",  # ← Добавьте
    "https://www.your-frontend-domain.com",  # ← Добавьте
]
```

---

## 🌍 Environment Variables

Создайте `.env` файл в backend папке:

```env
DATABASE_URL=postgresql://user:pass@localhost/dbname
DEBUG=False
CORS_ORIGINS=https://yourdomain.com
API_PORT=8000
```

Загружайте в коде:

```python
from dotenv import load_dotenv
import os

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL", "sqlite:///./marketplace_monitor.db")
DEBUG = os.getenv("DEBUG", "True").lower() == "true"
CORS_ORIGINS = os.getenv("CORS_ORIGINS", "http://localhost:3000").split(",")
```

---

## 📊 CI/CD Pipeline (GitHub Actions)

Создайте `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main, production]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          cd backend
          pip install -r requirements.txt
      
      - name: Lint
        run: |
          cd backend
          pip install flake8
          flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics

  deploy-backend:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy to Heroku
        uses: akhileshns/heroku-deploy@v3.12.12
        with:
          heroku_api_key: ${{ secrets.HEROKU_API_KEY }}
          heroku_app_name: "your-app-name"
          heroku_email: "your-email@gmail.com"
          appdir: "backend"

  deploy-frontend:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Build
        run: |
          cd frontend
          npm install
          npm run build
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-args: '--prod'
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          working-directory: frontend
```

---

## 🔍 Мониторинг и Логирование

### Backend логирование

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.get("/api/items")
async def get_items(db: Session = Depends(get_db)):
    logger.info(f"Fetching items...")
    try:
        items = db.query(Item).all()
        logger.info(f"Found {len(items)} items")
        return items
    except Exception as e:
        logger.error(f"Error: {str(e)}")
        raise
```

### Интеграция с Sentry (Error Tracking)

```python
import sentry_sdk

sentry_sdk.init(
    dsn="https://your-sentry-dsn@sentry.io/your-project-id",
    traces_sample_rate=1.0
)

@app.middleware("http")
async def log_requests(request: Request, call_next):
    with sentry_sdk.start_transaction(op="http", name=request.url.path):
        response = await call_next(request)
    return response
```

---

## 🚀 Performance Optimization

### Frontend
```bash
# Анализ бандла
npm run build -- --analyze

# Используйте code splitting
import { lazy, Suspense } from 'react';
const ItemGrid = lazy(() => import('./ItemGrid'));
```

### Backend
```python
# Добавить кеширование (Redis)
from fastapi_cache2 import FastAPICache2
from fastapi_cache2.backends.redis import RedisBackend

@app.get("/api/items")
@cached(expire=300)  # кеш на 5 минут
async def get_items(db: Session = Depends(get_db)):
    return db.query(Item).all()
```

### Database
```python
# Индексы для быстрого поиска
class Item(Base):
    __tablename__ = "items"
    
    id = Column(Integer, primary_key=True, index=True)
    brand = Column(String, index=True)  # ← Индекс
    category = Column(String, index=True)  # ← Индекс
    marketplace = Column(String, index=True)  # ← Индекс
```

---

## 📋 Чек-лист перед развертыванием

- [ ] Обновить `CORS_ORIGINS` в backend/main.py
- [ ] Создать `.env` файл с production переменными
- [ ] Настроить PostgreSQL базу
- [ ] Собрать и протестировать frontend (`npm run build`)
- [ ] Протестировать API (`npm run dev` + `python main.py`)
- [ ] Настроить CI/CD на GitHub Actions
- [ ] Добавить Sentry для error tracking
- [ ] Настроить логирование
- [ ] Протестировать CORS на production домене
- [ ] Добавить SSL сертификат (HTTPS)
- [ ] Настроить резервную копию БД

---

## 🆘 Troubleshooting

### CORS Error в production
```python
# Проверьте origins в main.py
origins = [
    "https://yourdomain.com",
    "https://www.yourdomain.com",
]
```

### 502 Bad Gateway на Heroku
```bash
# Посмотрите логи
heroku logs --tail

# Проверьте Procfile
cat Procfile
```

### Database connection error
```bash
# Проверьте переменные
heroku config:get DATABASE_URL

# Переподключитесь
heroku restart
```

---

**Готово к production! 🎉**
