# ✅ QUICKSTART - Запуск за 2 минуты

## 🚀 Самый быстрый способ запуска

### Вариант 1: PowerShell (Рекомендуется)
```powershell
# Откройте PowerShell в папке проекта и выполните:
.\start.ps1
```

### Вариант 2: CMD (Командная строка)
```cmd
# Запустите файл start.cmd
start.cmd
```

### Вариант 3: Ручной запуск

**Откройте 2 терминала:**

#### Терминал 1: Backend
```bash
cd backend
pip install -r requirements.txt
python main.py
```

#### Терминал 2: Frontend
```bash
cd frontend
npm install
npm run dev
```

---

## 🌐 Откройте браузер

```
http://localhost:3000
```

**Вы должны увидеть:**
- ✅ Боковое меню с фильтрами слева
- ✅ Сетку товаров справа (18 реалистичных товаров)
- ✅ Фото товаров, названия, цены, скидки
- ✅ Кнопки "Открыть на [маркетплейс]"

---

## ⚡ Тестирование фильтров

1. **Кликните на категорию** → "Одежда"
   - Сетка обновится, показав только одежду
   
2. **Выберите размер** → "M"
   - Фильтр применится мгновенно
   
3. **Выберите бренд** → "Supreme"
   - Товары обновятся
   
4. **Передвиньте ползунок цены**
   - Динамически обновляется диапазон

5. **Выберите маркетплейс** → "Grailed"
   - Только товары Grailed

---

## 🔌 Проверка API

### В браузере откройте:
```
http://localhost:8000/docs
```
Вы увидите интерактивную Swagger документацию всех эндпоинтов.

### Или в терминале (cURL):
```bash
# Получить все товары
curl http://localhost:8000/api/items

# Товары Supreme с скидкой >= 20%
curl "http://localhost:8000/api/items?brands=Supreme&min_discount=20"

# Проверить здоровье API
curl http://localhost:8000/api/health
```

---

## 📊 Что вы получили?

### Backend API (7 эндпоинтов)
```
✅ GET /api/items                # Товары с фильтрацией
✅ GET /api/filters/brands       # Список брендов  
✅ GET /api/filters/categories   # Список категорий
✅ GET /api/filters/countries    # Список стран
✅ GET /api/filters/sizes        # Список размеров
✅ GET /api/filters/price-range  # Min/Max цены
✅ GET /api/filters/marketplaces # Список маркетплейсов
```

### Frontend компоненты
```
✅ Боковое меню с фильтрами
✅ Адаптивная сетка товаров
✅ Карточки с фото и информацией
✅ Интерактивные фильтры в реал-тайме
✅ Минималистичный Apple-style дизайн
```

### База данных
```
✅ SQLite (локально) + PostgreSQL (production ready)
✅ 18 тестовых товаров
✅ Полностью индексирована
```

---

## 🎨 18 Тестовых товаров

### Rick Owens (4 товара)
- Ramone High Sneakers (43, $280, Grailed)
- Beanie (One Size, $95, Grailed)
- Shorts (S, $220, GoFish)
- Bomber Jacket будет случайным

### Supreme (2 товара)
- Box Logo Hoodie (M, $250, eBay)
- Crossbody Bag (One Size, $280, Grailed)

### Balenciaga (3 товара)
- Triple S Trainer (42, $350, eBay)
- Speed Trainer (39, $290, Grailed)
- City Bag (One Size, $580, eBay)

### Nike (2 товара)
- x Sacai Waffle (44, $210, GoFish)
- Dunk High Retro (40, $145, Mercari)

### Остальное
- Stussy, Raf Simons, Maison Margiela, Chrome Hearts

---

## 🧪 Примеры фильтрации

### Супер дешевые вещи (< $150)
```bash
http://localhost:3000
# Используйте ползунок: max_price = 150
```

### Премиум бренды со скидкой >= 30%
```bash
# Выберите: Rick Owens, Balenciaga, Raf Simons
# Видимые товары будут с скидкой >= 30%
```

### Только кроссовки из США
```bash
# Категория: Обувь
# Страна: США
# Результат: Nike, Supreme обувь
```

---

## 📂 Файлы проекта (кратко)

```
backend/
  ├── main.py          (240 строк) - FastAPI + эндпоинты
  ├── database.py      (70 строк)  - SQLAlchemy модели
  ├── scraper.py       (280 строк) - Тестовые данные
  └── requirements.txt

frontend/
  ├── src/App.jsx      (650 строк) - React + фильтры
  ├── src/index.css    (130 строк) - Tailwind стили
  ├── package.json
  └── vite.config.js

📄 README.md          - Основная инструкция
📄 API.md             - Полная справка API  
📄 ARCHITECTURE.md    - Как это работает
📄 DEPLOYMENT.md      - Production запуск
📄 INSTALL.md         - Пошаговая установка
```

---

## ⚠️ Если что-то не работает

### Backend не запускается
```bash
# Очистить кеш Python
rm -r backend/__pycache__

# Переустановить зависимости
cd backend
pip install --upgrade pip
pip install -r requirements.txt
python main.py
```

### Frontend не запускается
```bash
# Очистить кеш npm
cd frontend
npm cache clean --force
rm -r node_modules
npm install
npm run dev
```

### CORS ошибка в браузере
- ✅ Проверьте, что backend работает на http://localhost:8000
- ✅ Проверьте консоль браузера (F12)
- ✅ Перезагрузите страницу (Ctrl+R)

### Порт занят
```bash
# Переустановить все, используя другой порт
# В backend/main.py строка 154: port=8001
# В frontend/vite.config.js строка 4: port: 3001
```

---

## 📚 Полная документация

Для более подробной информации смотрите:
- 📖 [README.md](README.md) - начните отсюда
- 🔧 [INSTALL.md](INSTALL.md) - пошаговая установка  
- 📡 [API.md](API.md) - полная справка API
- 🏗️ [ARCHITECTURE.md](ARCHITECTURE.md) - как это устроено
- 🚀 [DEPLOYMENT.md](DEPLOYMENT.md) - развертывание

---

## 🎯 Что дальше?

### Сразу же
```
1. Запустить приложение
2. Поэкспериментировать с фильтрами
3. Открыть http://localhost:8000/docs (Swagger)
```

### Когда привыкнете
```
1. Изучить код (чистая архитектура)
2. Добавить свои товары в scraper.py
3. Скастомизировать дизайн в App.jsx
```

### Для production
```
1. Прочитать DEPLOYMENT.md
2. Мигрировать на PostgreSQL
3. Развернуть на Heroku/Railway/AWS
```

---

## 🎉 Готово!

Приложение **полностью готово к использованию**. 

```bash
# Просто запустите:
.\start.ps1
```

И наслаждайтесь мониторингом маркетплейсов! 🚀

---

**Вопросы?** Все ответы в документации:
- [README.md](README.md)
- [API.md](API.md)
- [ARCHITECTURE.md](ARCHITECTURE.md)
- [INSTALLATION.md](INSTALL.md)

**Удачи! 💪**
