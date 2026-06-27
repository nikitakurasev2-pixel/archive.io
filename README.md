# Marketplace Monitor — Мониторинг маркетплейсов

Полнофункциональное веб-приложение для поиска товаров ниже рыночной стоимости на популярных маркетплейсах (Grailed, eBay, Depop, Mercari, GoFish).

## 🚀 Быстрый старт

### Требования
- Python 3.10+
- Node.js 18+ и npm

### 1️⃣ Установка и запуск Backend

```bash
# Перейти в папку backend
cd backend

# Установить зависимости
pip install -r requirements.txt

# Запустить приложение
python main.py
```

Backend запустится на `http://localhost:8000`

API будет доступен по адресу: `http://localhost:8000/api/items`

### 2️⃣ Установка и запуск Frontend (в отдельном терминале)

```bash
# Перейти в папку frontend
cd frontend

# Установить зависимости
npm install

# Запустить dev-сервер
npm run dev
```

Frontend запустится на `http://localhost:3000`

## 📂 Структура проекта

```
my-website/
├── backend/
│   ├── main.py              # FastAPI приложение
│   ├── database.py          # SQLAlchemy модели
│   ├── scraper.py           # Парсер и генерация тестовых данных
│   └── requirements.txt      # Зависимости Python
├── frontend/
│   ├── src/
│   │   ├── App.jsx          # Главный компонент приложения
│   │   ├── index.css        # Tailwind CSS стили
│   │   └── main.jsx         # React точка входа
│   ├── index.html           # HTML корневой файл
│   ├── package.json         # Зависимости Node.js
│   ├── vite.config.js       # Конфигурация Vite
│   ├── tailwind.config.js   # Конфигурация Tailwind CSS
│   └── postcss.config.js    # PostCSS конфиг
└── README.md                # Этот файл
```

## 🎨 Особенности UI

- **Минималистичный дизайн**: белый фон, монохромная гамма, тонкие серые границы
- **Адаптивная сетка**: автоматически подстраивается под размер экрана
- **Боковое меню с фильтрами**:
  - Категории (Одежда, Обувь)
  - Бренды (Rick Owens, Supreme, Nike и другие)
  - Страны брендов (мультивыбор)
  - Размеры одежды (XXS-XXL) и обуви (39-45)
  - Ценовой диапазон с интерактивным ползунком
  - Выбор маркетплейса
- **Карточки товаров** с:
  - Фото товара
  - Название и бренд
  - Текущая цена и рыночная цена
  - Процент скидки (цветной бейдж)
  - Размер товара
  - Прямая ссылка на маркетплейс

## 🔧 API Endpoints

### Получить товары с фильтрами
```
GET /api/items?brands=Rick%20Owens,Supreme&categories=Одежда&countries=США&sizes=M,L&min_price=100&max_price=500&min_discount=20&marketplace=Grailed
```

**Параметры:**
- `brands` — бренды через запятую
- `categories` — категории через запятую
- `countries` — страны через запятую
- `sizes` — размеры через запятую
- `min_price` — минимальная цена
- `max_price` — максимальная цена
- `min_discount` — минимальный дисконт (по умолчанию 20%)
- `marketplace` — конкретный маркетплейс

### Получить доступные фильтры
```
GET /api/filters/brands      — все бренды
GET /api/filters/categories  — все категории
GET /api/filters/countries   — все страны
GET /api/filters/sizes       — все размеры
GET /api/filters/marketplaces — все маркетплейсы
GET /api/filters/price-range — минимальная и максимальная цена
GET /api/health              — проверка здоровья API
```

## 📊 База данных

Приложение использует **SQLite** для локального хранения данных.

### Таблица `items`
- `id` — уникальный идентификатор
- `title` — название товара
- `brand` — бренд
- `brand_country` — страна бренда
- `category` — категория товара
- `size` — размер
- `price` — текущая цена
- `market_price` — средняя рыночная цена (расчет по 10 аналогам)
- `discount` — процент скидки
- `url` — прямая ссылка на товар
- `image_url` — URL фото товара
- `marketplace` — маркетплейс (Grailed, eBay и т.д.)
- `created_at` — время добавления

## 🔄 Как работает парсинг

1. При первом запуске backend автоматически заполняет БД 18 реалистичными тестовыми товарами
2. Для каждого товара:
   - Генерируется прямой URL с ID товара
   - Вычисляется средняя рыночная цена (сумма цен 10 аналогов / 10)
   - Рассчитывается процент скидки
3. Используются поддельные User-Agent для имитации браузера

## 💾 Запуск в фоне

### На Windows (PowerShell)
```powershell
# Запустить backend
Start-Process python -ArgumentList "backend/main.py"

# Запустить frontend (в отдельном окне)
Start-Process npm -ArgumentList "run dev" -WorkingDirectory "frontend"
```

### На macOS/Linux (Bash)
```bash
# Запустить backend в фоне
cd backend && python main.py &

# Запустить frontend в отдельной вкладке терминала
cd frontend && npm run dev
```

## 🐛 Отладка

### Backend логи
```
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### Frontend логи
```
VITE v5.0.0  ready in XXX ms

➜  Local:   http://localhost:3000/
```

### Проверить API
```bash
curl http://localhost:8000/api/health
# Ответ: {"status":"ok"}
```

## 📈 Масштабирование

Для production:
1. Заменить SQLite на PostgreSQL в `database.py`
2. Добавить реальный парсинг в `scraper.py` с Playwright/BeautifulSoup
3. Добавить аутентификацию и авторизацию
4. Настроить CORS для production URL
5. Добавить кеширование (Redis)
6. Настроить CI/CD для автоматического обновления данных

## 📝 Лицензия

MIT
