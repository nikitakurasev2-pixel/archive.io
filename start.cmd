@echo off
REM Marketplace Monitor - Быстрый старт

echo.
echo ========================================
echo  Marketplace Monitor - Быстрый старт
echo ========================================
echo.

REM Запуск Backend
echo [1/2] Запуск Backend (FastAPI на порту 8000)...
cd backend
start cmd /k "python main.py"
cd ..

REM Небольшая задержка
timeout /t 3 /nobreak

REM Запуск Frontend
echo [2/2] Запуск Frontend (Vite на порту 3000)...
cd frontend
start cmd /k "npm install && npm run dev"
cd ..

echo.
echo ========================================
echo  Приложение запускается...
echo ========================================
echo.
echo Backend:  http://localhost:8000
echo Frontend: http://localhost:3000
echo API Docs: http://localhost:8000/docs
echo.
echo Нажмите Ctrl+C для остановки
echo ========================================
echo.

pause
