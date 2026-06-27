# Marketplace Monitor - Быстрый старт на PowerShell

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Marketplace Monitor - Быстрый старт" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Запуск Backend
Write-Host "[1/2] Запуск Backend (FastAPI на порту 8000)..." -ForegroundColor Yellow
$backendProcess = Start-Process python -ArgumentList "backend/main.py" -PassThru
Write-Host "Backend запущен (PID: $($backendProcess.Id))" -ForegroundColor Green

# Пауза
Start-Sleep -Seconds 3

# Запуск Frontend
Write-Host "[2/2] Запуск Frontend (Vite на порту 3000)..." -ForegroundColor Yellow
Push-Location frontend
$frontendProcess = Start-Process npm -ArgumentList "run dev" -PassThru
Pop-Location
Write-Host "Frontend запущен (PID: $($frontendProcess.Id))" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Приложение запускается..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Backend:  http://localhost:8000" -ForegroundColor Cyan
Write-Host "Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "API Docs: http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "Для остановки нажмите Ctrl+C" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Ожидание процессов
Wait-Process -Id $backendProcess.Id, $frontendProcess.Id
