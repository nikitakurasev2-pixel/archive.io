# Deployment guide

## 1. Локальный веб-сервис на вашей машине

Запустите backend:

```powershell
cd C:\Users\User\OneDrive\Рабочий стол\my-website\backend
C:\Users\User\AppData\Local\Programs\Python\Python313\python.exe -m uvicorn main:app --host 0.0.0.0 --port 8000
```

Запустите frontend:

```powershell
cd C:\Users\User\OneDrive\Рабочий стол\my-website\frontend
C:\Program Files\nodejs\npm.cmd run dev -- --host 0.0.0.0 --port 5173
```

После этого сайт будет доступен:
- http://localhost:5173
- http://YOUR_LOCAL_IP:5173

## 2. Публикация в сеть

### Вариант A: Vercel + Render
- Frontend: Vercel
- Backend: Render
- Затем в frontend укажите публичный URL backend в переменной окружения:
  - VITE_API_BASE_URL=https://your-backend-url

### Вариант B: Netlify + Railway
- Frontend: Netlify
- Backend: Railway

## 3. Что нужно для реального веб-сервиса

- публичный backend URL;
- публичный frontend URL;
- переменная VITE_API_BASE_URL для фронтенда;
- CORS на backend с разрешёнными доменами.
