#!/bin/bash
# Скрипт для быстрого запуска на macOS/Linux

echo "========================================"
echo " Marketplace Monitor - Быстрый старт"
echo "========================================"
echo ""

# Запуск Backend
echo "[1/2] Запуск Backend (FastAPI на порту 8000)..."
cd backend
python3 main.py &
BACKEND_PID=$!
echo "Backend запущен (PID: $BACKEND_PID)"

# Пауза
sleep 3

# Запуск Frontend
echo "[2/2] Запуск Frontend (Vite на порту 3000)..."
cd ../frontend
npm run dev &
FRONTEND_PID=$!
echo "Frontend запущен (PID: $FRONTEND_PID)"

echo ""
echo "========================================"
echo " Приложение запускается..."
echo "========================================"
echo ""
echo "Frontend: http://localhost:3000"
echo "Backend:  http://localhost:8000"
echo "API Docs: http://localhost:8000/docs"
echo ""
echo "Для остановки нажмите Ctrl+C"
echo "========================================"
echo ""

# Ожидание сигнала прерывания
trap "kill $BACKEND_PID $FRONTEND_PID" EXIT

wait
