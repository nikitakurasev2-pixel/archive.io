# 📡 API Reference

## Базовый URL
```
http://localhost:8000
```

---

## ✅ Health Check

### GET `/api/health`
Проверить, запущен ли API.

**Запрос:**
```bash
curl http://localhost:8000/api/health
```

**Ответ:**
```json
{
  "status": "ok"
}
```

---

## 🛍️ Товары

### GET `/api/items`
Получить товары с применением фильтров.

**Параметры запроса:**
| Параметр | Тип | Описание | Пример |
|----------|-----|---------|--------|
| `brands` | string | Бренды через запятую | `Rick Owens,Supreme` |
| `categories` | string | Категории через запятую | `Одежда,Обувь` |
| `countries` | string | Страны через запятую | `Франция,США` |
| `sizes` | string | Размеры через запятую | `M,L,42,43` |
| `min_price` | float | Минимальная цена | `100` |
| `max_price` | float | Максимальная цена | `500` |
| `min_discount` | float | Минимальный дисконт (%) | `20` |
| `marketplace` | string | Конкретный маркетплейс | `Grailed` |

**Примеры запросов:**

#### Все товары
```bash
curl http://localhost:8000/api/items
```

#### Товары с скидкой >= 20% (по умолчанию)
```bash
curl "http://localhost:8000/api/items?min_discount=20"
```

#### Товары бренда Supreme
```bash
curl "http://localhost:8000/api/items?brands=Supreme"
```

#### Одежда размеры S и M
```bash
curl "http://localhost:8000/api/items?categories=Одежда&sizes=S,M"
```

#### Кроссовки из USA цена 100-300$
```bash
curl "http://localhost:8000/api/items?categories=Обувь&countries=США&min_price=100&max_price=300"
```

#### Товары на Grailed с скидкой >= 30%
```bash
curl "http://localhost:8000/api/items?marketplace=Grailed&min_discount=30"
```

#### Комплексный фильтр
```bash
curl "http://localhost:8000/api/items?brands=Rick%20Owens,Balenciaga&categories=Обувь&countries=Франция&min_discount=25&min_price=200&max_price=800"
```

**Ответ:**
```json
[
  {
    "id": 1,
    "title": "Rick Owens Drkshdw Ramone High Sneakers",
    "brand": "Rick Owens",
    "brand_country": "Италия",
    "category": "Обувь",
    "size": "43",
    "price": 280,
    "market_price": 385.2,
    "discount": 27.4,
    "url": "https://www.grailed.com/listings/abc123",
    "image_url": "https://images.unsplash.com/...",
    "marketplace": "Grailed",
    "created_at": "2024-06-27T12:00:00"
  },
  ...
]
```

---

## 🏷️ Фильтры

### GET `/api/filters/brands`
Получить все доступные бренды.

```bash
curl http://localhost:8000/api/filters/brands
```

**Ответ:**
```json
{
  "brands": [
    "Rick Owens",
    "Balenciaga",
    "Supreme",
    "Nike",
    "Stussy",
    ...
  ]
}
```

### GET `/api/filters/categories`
Получить все доступные категории.

```bash
curl http://localhost:8000/api/filters/categories
```

**Ответ:**
```json
{
  "categories": [
    "Одежда",
    "Обувь",
    "Аксессуары"
  ]
}
```

### GET `/api/filters/countries`
Получить все страны брендов.

```bash
curl http://localhost:8000/api/filters/countries
```

**Ответ:**
```json
{
  "countries": [
    "США",
    "Франция",
    "Италия",
    "Англия",
    "Япония"
  ]
}
```

### GET `/api/filters/sizes`
Получить все доступные размеры.

```bash
curl http://localhost:8000/api/filters/sizes
```

**Ответ:**
```json
{
  "sizes": [
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "39",
    "40",
    "41",
    ...
  ]
}
```

### GET `/api/filters/price-range`
Получить минимальную и максимальную цены в каталоге.

```bash
curl http://localhost:8000/api/filters/price-range
```

**Ответ:**
```json
{
  "min_price": 95,
  "max_price": 580
}
```

### GET `/api/filters/marketplaces`
Получить все доступные маркетплейсы.

```bash
curl http://localhost:8000/api/filters/marketplaces
```

**Ответ:**
```json
{
  "marketplaces": [
    "Grailed",
    "eBay",
    "Depop",
    "Mercari",
    "GoFish"
  ]
}
```

---

## 📝 Response Format

Каждый товар содержит:

```json
{
  "id": 1,                          // Уникальный ID товара
  "title": "Product Name",          // Название товара
  "brand": "Brand Name",            // Бренд
  "brand_country": "Country",       // Страна бренда
  "category": "Category",           // Категория (Одежда/Обувь)
  "size": "M",                      // Размер
  "price": 250,                     // Текущая цена (USD)
  "market_price": 350,              // Средняя рыночная цена (USD)
  "discount": 28.6,                 // Процент скидки (%)
  "url": "https://...",             // Прямая ссылка на товар
  "image_url": "https://...",       // URL фото товара
  "marketplace": "Grailed",         // Маркетплейс
  "created_at": "2024-06-27T..."    // Время добавления в БД
}
```

---

## 🔗 Integration Examples

### JavaScript/React
```javascript
// Получить товары с фильтрами
async function fetchItems(filters) {
  const params = new URLSearchParams();
  
  if (filters.brands) {
    params.append('brands', filters.brands.join(','));
  }
  if (filters.minPrice) {
    params.append('min_price', filters.minPrice);
  }
  
  const response = await fetch(`/api/items?${params}`);
  return await response.json();
}

const items = await fetchItems({
  brands: ['Supreme', 'Nike'],
  minPrice: 100,
});
```

### Python
```python
import requests

# Получить товары Balenciaga
response = requests.get('http://localhost:8000/api/items', params={
    'brands': 'Balenciaga',
    'min_discount': 20,
})

items = response.json()
for item in items:
    print(f"{item['title']} - ${item['price']}")
```

### cURL (bash)
```bash
# Товары на распродаже (скидка >= 30%)
curl -G http://localhost:8000/api/items \
  --data-urlencode 'categories=Одежда' \
  --data-urlencode 'min_discount=30' \
  --data-urlencode 'min_price=100' \
  --data-urlencode 'max_price=500'
```

---

## 🔍 Search Tips

### Получить только дешёвые вещи (< $150)
```bash
curl "http://localhost:8000/api/items?max_price=150"
```

### Поиск премиум брендов со скидкой >= 40%
```bash
curl "http://localhost:8000/api/items?brands=Rick%20Owens,Balenciaga,Raf%20Simons&min_discount=40"
```

### Стритвир одежда из USA/UK размер M
```bash
curl "http://localhost:8000/api/items?brands=Supreme,Stussy,Nike&countries=США,Англия&categories=Одежда&sizes=M"
```

### Обувь Европейских брендов все размеры
```bash
curl "http://localhost:8000/api/items?categories=Обувь&countries=Франция,Италия"
```

---

## ⚠️ Error Handling

Все ошибки возвращают JSON с описанием:

```json
{
  "detail": "Error message"
}
```

### Коды состояния HTTP
| Код | Значение |
|-----|----------|
| 200 | ✅ OK — запрос успешен |
| 400 | ❌ Bad Request — неправильные параметры |
| 404 | ❌ Not Found — эндпоинт не найден |
| 500 | ❌ Internal Server Error — ошибка сервера |

---

## 📚 Дополнительные ресурсы

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc API Docs**: http://localhost:8000/redoc
- **Backend код**: [backend/main.py](../backend/main.py)
- **Frontend код**: [frontend/src/App.jsx](../frontend/src/App.jsx)

---

Последнее обновление: 27.06.2024
