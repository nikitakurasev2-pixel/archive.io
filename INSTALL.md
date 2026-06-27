# 🚀 Инструкция по установке и запуску

## ✅ Предварительные требования

Убедитесь, что у вас установлены:
- **Python 3.10 или выше** → [Скачать](https://www.python.org/downloads/)
- **Node.js 18+ и npm** → [Скачать](https://nodejs.org/)

Проверить установку:
```bash
python --version
npm --version
```

---

## 📦 Способ 1: Автоматический запуск (Windows)

### Быстрый старт через скрипт

**Вариант A (CMD):**
```bash
# Просто запустите файл
start.cmd
```

**Вариант B (PowerShell):**
```powershell
# Разрешить выполнение скриптов (если требуется)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Запустить скрипт
.\start.ps1
```

После запуска приложение будет доступно по адресам:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **Swagger API Docs**: http://localhost:8000/docs

---

## 🔧 Способ 2: Ручной запуск (Все платформы)

### Шаг 1: Установка и запуск Backend

```bash
# Перейти в папку backend
cd backend

# Установить зависимости
pip install -r requirements.txt

# Запустить приложение
python main.py
```

**Успешный запуск:**
```
INFO:     Uvicorn running on http://0.0.0.0:8000 [ENTER A KEY TO QUIT]
```

### Шаг 2: Запуск Frontend (в отдельном терминале)

```bash
# Перейти в папку frontend
cd frontend

# Установить зависимости
npm install

# Запустить dev-сервер
npm run dev
```

**Успешный запуск:**
```
➜  Local:   http://localhost:3000/
```

---

## 🌐 Доступ к приложению

После запуска откройте в браузере:
```
http://localhost:3000
```

### Что вы увидите:
✅ Сетка товаров с реалистичными данными  
✅ Боковое меню с фильтрами  
✅ Прямые ссылки на маркетплейсы  
✅ Процент скидки для каждого товара  

---

## 🧪 Проверка API

```bash
# Получить все товары
curl http://localhost:8000/api/items

# Получить товары с фильтрами
curl "http://localhost:8000/api/items?brands=Supreme&min_discount=20"

# Проверить здоровье API
curl http://localhost:8000/api/health
```

---

## 📊 Структура БД

При первом запуске backend **автоматически** создает БД `marketplace_monitor.db` с 18 тестовыми товарами:
- Rick Owens (куртки, кроссовки)
- Balenciaga (кроссовки, сумки)
- Supreme (худи, сумки)
- Nike (кроссовки)
- Stussy, Raf Simons, Chrome Hearts и другие

---

## 🛠 Если что-то не работает

### Backend не запускается
```bash
# Убедитесь, что порт 8000 свободен
netstat -ano | findstr :8000  # Windows PowerShell

# Если занят, измените порт в main.py (строка: uvicorn.run(..., port=8001))
```

### Frontend не запускается
```bash
# Очистить кеш npm
npm cache clean --force

# Переустановить зависимости
rm -r node_modules
npm install

# Запустить заново
npm run dev
```

### Ошибка "ModuleNotFoundError"
```bash
# Переустановить зависимости Python
pip install --upgrade pip
pip install -r requirements.txt
```

### CORS ошибки
- Убедитесь, что backend работает на http://localhost:8000
- Если используете другой порт/хост, отредактируйте CORS в [backend/main.py](backend/main.py#L19-L25)

---

## 📱 Структура файлов

```
my-website/
├── backend/
│   ├── main.py              # FastAPI приложение с эндпоинтами
│   ├── database.py          # SQLAlchemy модели и подключение БД
│   ├── scraper.py           # Парсер и генерация тестовых данных
│   ├── requirements.txt      # Зависимости Python
│   └── .gitignore
├── frontend/
│   ├── src/
│   │   ├── App.jsx          # Главный компонент с фильтрами и сеткой
│   │   ├── index.css        # Tailwind стили
│   │   └── main.jsx         # React точка входа
│   ├── index.html           # HTML файл
│   ├── package.json         # Зависимости Node.js
│   ├── vite.config.js       # Конфиг Vite
│   ├── tailwind.config.js   # Конфиг Tailwind CSS
│   ├── postcss.config.js    # PostCSS конфиг
│   └── .gitignore
├── README.md                # Полная документация
├── INSTALL.md               # Эта инструкция
├── start.cmd                # Скрипт для Windows (CMD)
└── start.ps1                # Скрипт для Windows (PowerShell)
```

---

## 🚀 Дополнительные команды

### Production сборка Frontend
```bash
cd frontend
npm run build
# Файлы появятся в папке frontend/dist
```

### Просмотр Swagger API документации
```
http://localhost:8000/docs
```

### Просмотр логов в реальном времени
- Backend выводит логи в консоль
- Frontend выводит логи в браузер (F12 → Console)

---

## ✨ Готово!

Приложение полностью готово к использованию. Все данные загружаются автоматически при первом запуске.

**Дальше:**
- Отредактируйте фильтры в [frontend/src/App.jsx](frontend/src/App.jsx)
- Добавьте реальный парсинг в [backend/scraper.py](backend/scraper.py)
- Замените SQLite на PostgreSQL для production

**Вопросы или проблемы?** Проверьте консоль (F12) и логи терминала.

---

Успехов! 🎉
