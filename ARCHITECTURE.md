# 🏗️ Архитектура и детали реализации

## 📊 Структура приложения

```
Frontend (React + Vite + Tailwind)
         ↓
    REST API (FastAPI)
         ↓
   Database (SQLAlchemy + SQLite/PostgreSQL)
```

---

## 🧩 Backend архитектура

### 1. main.py - FastAPI приложение

```
GET /api/items          → Получить товары с фильтрацией
GET /api/filters/*      → Получить доступные значения фильтров
GET /api/health         → Проверка здоровья API
```

**Особенности:**
- ✅ CORS настроен для локальной разработки
- ✅ Автоматическая инициализация БД при startup
- ✅ Валидация параметров query через Pydantic
- ✅ Асинхронная обработка запросов

### 2. database.py - ORM модели

```python
Item (id, title, brand, brand_country, category, size, 
      price, market_price, discount, url, image_url, 
      marketplace, created_at)

MarketPrice (id, item_id, price, created_at)
```

**Особенности:**
- ✅ SQLAlchemy для типобезопасности
- ✅ Индексы на часто ищущихся полях (brand, category, marketplace)
- ✅ Автоматические временные метки
- ✅ Поддержка SQLite и PostgreSQL

### 3. scraper.py - Парсер и генерация данных

```
18 реалистичных товаров (Rick Owens, Supreme, Nike и др.)
    ↓
Генерация URL: {marketplace}/listings/{uuid}
    ↓
Расчет средней рыночной цены (sum(10_prices) / 10)
    ↓
Расчет дисконта: ((market_price - price) / market_price) * 100
    ↓
Заполнение БД
```

**Особенности:**
- ✅ Поддельные User-Agent для имитации браузера
- ✅ Асинхронная обработка (asyncio)
- ✅ Реалистичные тестовые данные
- ✅ Готовность к интеграции настоящего парсинга

---

## 🎨 Frontend архитектура

### 1. App.jsx - Главный компонент

```
App
├── Sidebar (слева)
│   ├── Category Filter (checkbox)
│   ├── Brand Filter (checkbox)
│   ├── Country Filter (checkbox)
│   ├── Size Filter (button tabs)
│   ├── Price Range (range sliders)
│   └── Marketplace Select
└── Main Content (справа)
    ├── Header (название, счетчик товаров)
    └── Items Grid
        ├── Product Card
        │   ├── Image
        │   ├── Discount Badge
        │   ├── Title & Brand
        │   ├── Price Info
        │   └── Marketplace Link
```

**State Management:**
```javascript
const [filters, setFilters] = useState({
  brands: [],
  categories: [],
  countries: [],
  sizes: [],
  minPrice: 0,
  maxPrice: 1000,
  marketplace: '',
})

const [items, setItems] = useState([])
const [loading, setLoading] = useState(true)
const [availableFilters, setAvailableFilters] = useState({})
```

### 2. Фильтрация логика

**Клиент строит query string:**
```
GET /api/items?brands=Supreme,Nike&categories=Одежда&min_discount=20&...
```

**Сервер применяет фильтры:**
```python
query = db.query(Item)
if brands: query = query.filter(Item.brand.in_(brand_list))
if categories: query = query.filter(Item.category.in_(category_list))
if min_price: query = query.filter(Item.price >= min_price)
# ... и так далее
return query.all()
```

### 3. Стилизация (Tailwind CSS)

**Дизайн принципы:**
- ✅ Минимализм (как Apple, Arc Browser)
- ✅ Белый фон (#ffffff)
- ✅ Монохромная гамма (черный, серый, белый)
- ✅ Тонкие границы (border-neutral-200)
- ✅ Sans-serif шрифты системы
- ✅ Плавные переходы (transition)

**Цветовая схема:**
```css
Background:  #ffffff
Text:        #000000 (primary), #525252 (secondary), #d4d4d4 (tertiary)
Border:      #e5e5e5 (light), #525252 (hover)
Accent:      #000000 (buttons, active states)
```

---

## 📡 Поток данных

### 1. Инициализация приложения

```
Frontend загружается
    ↓
useEffect вызывает fetch для фильтров
    ↓
Параллельные запросы:
  - /api/filters/brands
  - /api/filters/categories
  - /api/filters/countries
  - /api/filters/sizes
  - /api/filters/price-range
  - /api/filters/marketplaces
    ↓
Данные загружены в availableFilters
    ↓
Первый fetch /api/items (без фильтров)
    ↓
Сетка товаров отрендерена
```

### 2. Фильтрация при взаимодействии

```
Пользователь кликает на фильтр (например, brand=Supreme)
    ↓
handleFilterChange обновляет state
    ↓
setFilters(newFilters)
    ↓
fetchItems вызывается с новыми фильтрами
    ↓
Строится query string: ?brands=Supreme&min_discount=20
    ↓
GET /api/items?brands=Supreme&min_discount=20
    ↓
Backend фильтрует в БД
    ↓
JSON ответ отправляется
    ↓
setItems(data) обновляет сетку
    ↓
Компонент перерендеривается с новыми товарами
```

---

## 🔄 Database Schema

```sql
CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR NOT NULL,
    brand VARCHAR NOT NULL,
    brand_country VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    size VARCHAR NOT NULL,
    price FLOAT NOT NULL,
    market_price FLOAT NOT NULL,
    discount FLOAT NOT NULL,
    url VARCHAR UNIQUE NOT NULL,
    image_url VARCHAR NOT NULL,
    marketplace VARCHAR NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Индексы для быстрого поиска
CREATE INDEX idx_items_brand ON items(brand);
CREATE INDEX idx_items_category ON items(category);
CREATE INDEX idx_items_brand_country ON items(brand_country);
CREATE INDEX idx_items_marketplace ON items(marketplace);
```

---

## 🔐 API Эндпоинты - Детально

### GET /api/items

**Логика:**
```python
1. Получить параметры: brands, categories, countries, sizes, min_price, max_price, marketplace, min_discount

2. Построить query:
   query = db.query(Item)
   
3. Применить фильтры (если указаны):
   - Если brands: WHERE brand IN (...)
   - Если categories: WHERE category IN (...)
   - Если countries: WHERE brand_country IN (...)
   - Если sizes: WHERE size IN (...)
   - Если min_price: WHERE price >= min_price
   - Если max_price: WHERE price <= max_price
   - Если marketplace: WHERE marketplace = marketplace

4. Обязательный фильтр (дисконт >= 20%):
   WHERE discount >= min_discount (default 20)

5. Выполнить query и вернуть JSON
```

**Сложность:**
- O(n) выполнение query с индексами на основные фильтры
- Данные маленькие (несколько сотен товаров), поэтому быстро

### GET /api/filters/*

**Логика:**
```python
1. Выполнить DISTINCT запрос для каждого поля:
   SELECT DISTINCT brand FROM items WHERE discount >= 20
   
2. Вернуть массив уникальных значений

3. Для price-range:
   SELECT MIN(price), MAX(price) FROM items
```

---

## 🧪 Тестовые данные

18 товаров покрывают:

**Бренды (Premium):**
- Rick Owens (4 позиции)
- Balenciaga (3 позиции)
- Maison Margiela (2 позиции)
- Raf Simons (2 позиции)
- Chrome Hearts (2 позиции)

**Бренды (Streetwear):**
- Supreme (2 позиции)
- Stussy (2 позиции)
- Nike (2 позиции)

**Категории:**
- Одежда (10 позиций)
- Обувь (7 позиций)
- Аксессуары (1 позиция)

**Маркетплейсы:**
- Grailed (5 позиций)
- eBay (4 позиции)
- Depop (4 позиции)
- Mercari (3 позиции)
- GoFish (2 позиции)

**Дисконты:**
- Диапазон: 20% - 40%
- Средний: ~27%

---

## 🚀 Performance Considerations

### Frontend
- ✅ Параллельные fetch запросы для фильтров (Promise.all)
- ✅ Ленивая загрузка изображений (img с URL)
- ✅ Плавные переходы (CSS transitions)
- ✅ Мемоизация через React.memo (можно добавить)

### Backend
- ✅ Индексы на часто фильтруемые поля
- ✅ Асинхронная обработка (FastAPI/asyncio)
- ✅ Валидация параметров (Pydantic)
- ✅ Кеширование можно добавить (Redis)

### Database
- ✅ SQLite для разработки (быстро)
- ✅ PostgreSQL для production (scalable)
- ✅ Индексы на brand, category, marketplace, size
- ✅ Денормализованное хранилище (discount вычисляется и хранится)

---

## 🔗 External Resources

### Images
- Unsplash API (бесплатные стоки фото)
- Формат: `https://images.unsplash.com/photo-{id}?w=400&h=400&fit=crop`

### Marketplaces
- Grailed: https://www.grailed.com/
- eBay: https://www.ebay.com/
- Depop: https://www.depop.com/
- Mercari: https://www.mercari.com/
- GoFish: https://www.gofish.com/

---

## 🛠️ Расширение функциональности

### Добавить реальный парсинг
```python
# backend/scraper.py

from playwright.async_api import async_playwright

async def scrape_grailed():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        
        await page.goto('https://www.grailed.com/...')
        items = await page.query_selector_all('.item-card')
        
        # ... парсим товары ...
        
        await browser.close()
```

### Добавить аутентификацию
```python
from fastapi import Depends, HTTPException
from fastapi.security import HTTPBearer

security = HTTPBearer()

@app.get("/api/items")
async def get_items(
    credentials: HTTPAuthCredentials = Depends(security),
    db: Session = Depends(get_db),
):
    # Проверить JWT токен
    user = verify_token(credentials.credentials)
    if not user:
        raise HTTPException(status_code=401)
    
    # ... получить товары ...
```

### Добавить пагинацию
```python
@app.get("/api/items")
async def get_items(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 20,
    ...
):
    items = query.offset(skip).limit(limit).all()
    total = query.count()
    
    return {
        "items": items,
        "total": total,
        "skip": skip,
        "limit": limit,
    }
```

### Добавить сортировку
```python
@app.get("/api/items")
async def get_items(
    db: Session = Depends(get_db),
    sort_by: str = "created_at",  # или "price", "discount"
    order: str = "desc",  # или "asc"
    ...
):
    if sort_by == "price":
        query = query.order_by(Item.price.desc() if order == "desc" else Item.price)
    # ...
    
    return query.all()
```

---

## 📈 Масштабирование

### Текущий стек (Development)
- Frontend: Vite (fast refresh)
- Backend: FastAPI (async)
- Database: SQLite (файл на диске)

### Production стек
- Frontend: React + Tailwind, собран в static files, раздается Nginx
- Backend: FastAPI + Gunicorn + Nginx, контейнеризирован в Docker
- Database: PostgreSQL, размещена отдельно (AWS RDS, Railway, Supabase)
- Cache: Redis для кеширования часто запрашиваемых данных
- CDN: Cloudflare для статических файлов

---

**Архитектура спроектирована для простоты разработки, но масштабируется до production размеров! 🚀**
