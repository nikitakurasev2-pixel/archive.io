# 📚 Навигация по документации

## 🚀 Начните отсюда

**Впервые в проекте?** → Прочитайте [**QUICKSTART.md**](QUICKSTART.md) (2 минуты)

Хотите понять архитектуру? → Читайте [**ARCHITECTURE.md**](ARCHITECTURE.md)

Нужна полная справка? → Смотрите [**README.md**](README.md)

---

## 📖 Полный путь для начинающих

### 1️⃣ Быстрый старт (2 минуты)
**Файл:** [QUICKSTART.md](QUICKSTART.md)
- ✅ Как запустить за 1 команду
- ✅ Что вы должны увидеть
- ✅ Примеры фильтрации
- ✅ Быстрые ответы на частые вопросы

### 2️⃣ Подробная установка
**Файл:** [INSTALL.md](INSTALL.md)
- ✅ Требования (Python, Node.js)
- ✅ Ручной запуск (терминал 1 и 2)
- ✅ Решение проблем
- ✅ Проверка API

### 3️⃣ Основная документация
**Файл:** [README.md](README.md)
- ✅ Общее описание приложения
- ✅ Все возможности
- ✅ Структура проекта
- ✅ Как работает парсинг

### 4️⃣ API справка
**Файл:** [API.md](API.md)
- ✅ Все 8 эндпоинтов
- ✅ Параметры запросов
- ✅ Примеры cURL
- ✅ Интеграция с разными языками (JavaScript, Python)

### 5️⃣ Как это устроено?
**Файл:** [ARCHITECTURE.md](ARCHITECTURE.md)
- ✅ Архитектура приложения
- ✅ Поток данных
- ✅ Backend детали
- ✅ Frontend детали
- ✅ БД схема
- ✅ Как расширить функциональность

### 6️⃣ Production развертывание
**Файл:** [DEPLOYMENT.md](DEPLOYMENT.md)
- ✅ Docker
- ✅ Heroku/Railway/AWS
- ✅ PostgreSQL миграция
- ✅ CI/CD pipeline
- ✅ Мониторинг

### 7️⃣ Полная сводка
**Файл:** [SUMMARY.md](SUMMARY.md)
- ✅ Что было создано
- ✅ Статистика кода
- ✅ Ключевые особенности
- ✅ Что включено в проект

### 8️⃣ Финальный чек-лист
**Файл:** [CHECKLIST.md](CHECKLIST.md)
- ✅ Полный список того, что создано
- ✅ Как протестировать
- ✅ Что дальше

---

## 🎯 Поиск по темам

### 🚀 Запуск
- Хочу быстро запустить → [QUICKSTART.md](QUICKSTART.md)
- Проблемы при установке → [INSTALL.md](INSTALL.md) (раздел "Если что-то не работает")
- Хочу запустить на production → [DEPLOYMENT.md](DEPLOYMENT.md)

### 💻 Код
- Как работает приложение? → [ARCHITECTURE.md](ARCHITECTURE.md)
- Где находится какой код? → [README.md](README.md) (раздел "Структура проекта")
- Как добавить новый фильтр? → [ARCHITECTURE.md](ARCHITECTURE.md) (раздел "Расширение функциональности")

### 📡 API
- Какие эндпоинты есть? → [API.md](API.md)
- Как отправить запрос? → [API.md](API.md) (раздел "Integration Examples")
- Где найти Swagger документацию? → [QUICKSTART.md](QUICKSTART.md) или http://localhost:8000/docs

### 🛢️ БД
- Как работает база данных? → [ARCHITECTURE.md](ARCHITECTURE.md) (раздел "Database Schema")
- Как мигрировать на PostgreSQL? → [DEPLOYMENT.md](DEPLOYMENT.md) (раздел "Миграция на PostgreSQL")

### 🎨 UI/UX
- Как изменить дизайн? → [frontend/src/App.jsx](frontend/src/App.jsx) или [frontend/src/index.css](frontend/src/index.css)
- Как изменить цвета? → [frontend/tailwind.config.js](frontend/tailwind.config.js)

### 🧪 Тестирование
- Как протестировать фильтры? → [QUICKSTART.md](QUICKSTART.md) (раздел "Тестирование фильтров")
- Как протестировать API? → [QUICKSTART.md](QUICKSTART.md) или [API.md](API.md)

### 🐛 Отладка
- Что-то не работает → [INSTALL.md](INSTALL.md) (раздел "Если что-то не работает")
- Ошибки в консоли → [ARCHITECTURE.md](ARCHITECTURE.md) (раздел "Performance Considerations")

### 🚀 Production
- Как развернуть приложение? → [DEPLOYMENT.md](DEPLOYMENT.md)
- Какие инструменты использовать? → [DEPLOYMENT.md](DEPLOYMENT.md)
- Как настроить CI/CD? → [DEPLOYMENT.md](DEPLOYMENT.md)

---

## 📱 Структура папок

```
my-website/
├── backend/                    # Python/FastAPI
│   ├── main.py                (API эндпоинты)
│   ├── database.py            (ORM модели)
│   ├── scraper.py             (парсер + тестовые данные)
│   └── requirements.txt        (зависимости)
│
├── frontend/                   # React/Vite/Tailwind
│   ├── src/
│   │   ├── App.jsx            (главный компонент)
│   │   ├── index.css          (стили)
│   │   └── main.jsx           (точка входа)
│   ├── package.json
│   ├── vite.config.js
│   └── tailwind.config.js
│
└── 📚 Документация
    ├── README.md              (начните здесь)
    ├── QUICKSTART.md          (запуск за 2 минуты)
    ├── INSTALL.md             (подробная установка)
    ├── API.md                 (справка эндпоинтов)
    ├── ARCHITECTURE.md        (как это работает)
    ├── DEPLOYMENT.md          (production)
    ├── SUMMARY.md             (полная сводка)
    └── CHECKLIST.md           (финальный чек-лист)
```

---

## 🎯 Рекомендуемый порядок чтения

### Для нетерпеливых (10 минут)
1. [QUICKSTART.md](QUICKSTART.md) - запустить
2. [CHECKLIST.md](CHECKLIST.md) - понять что получилось

### Для разработчиков (30 минут)
1. [QUICKSTART.md](QUICKSTART.md) - запустить
2. [ARCHITECTURE.md](ARCHITECTURE.md) - понять код
3. [API.md](API.md) - изучить эндпоинты

### Для DevOps (1 час)
1. [INSTALL.md](INSTALL.md) - убедиться что работает
2. [ARCHITECTURE.md](ARCHITECTURE.md) - понять архитектуру
3. [DEPLOYMENT.md](DEPLOYMENT.md) - развернуть на production

### Для всех остальных (полное погружение)
1. [README.md](README.md) - общее описание
2. [QUICKSTART.md](QUICKSTART.md) - быстрый старт
3. [INSTALL.md](INSTALL.md) - детальная установка
4. [ARCHITECTURE.md](ARCHITECTURE.md) - архитектура
5. [API.md](API.md) - справка эндпоинтов
6. [DEPLOYMENT.md](DEPLOYMENT.md) - production
7. [SUMMARY.md](SUMMARY.md) - полная сводка
8. [CHECKLIST.md](CHECKLIST.md) - финальный чек-лист

---

## 💡 Полезные команды

### Быстрый запуск
```bash
# Windows PowerShell
.\start.ps1

# Windows CMD
start.cmd

# macOS/Linux
bash start.sh
```

### Ручной запуск
```bash
# Backend (терминал 1)
cd backend && pip install -r requirements.txt && python main.py

# Frontend (терминал 2)
cd frontend && npm install && npm run dev
```

### Проверка API
```bash
# Swagger документация
http://localhost:8000/docs

# Прямой запрос
curl http://localhost:8000/api/items

# С фильтрами
curl "http://localhost:8000/api/items?brands=Supreme&min_discount=20"
```

---

## 🆘 Быстрые ответы

**Q: Где начать?**
A: [QUICKSTART.md](QUICKSTART.md)

**Q: Как запустить?**
A: `.\start.ps1` (Windows) или читайте [QUICKSTART.md](QUICKSTART.md)

**Q: Где исходный код?**
A: [backend/](backend/) и [frontend/src/](frontend/src/)

**Q: Какие API эндпоинты?**
A: [API.md](API.md)

**Q: Как изменить дизайн?**
A: Отредактируйте [frontend/src/App.jsx](frontend/src/App.jsx) и [frontend/tailwind.config.js](frontend/tailwind.config.js)

**Q: Как добавить товары?**
A: Отредактируйте [backend/scraper.py](backend/scraper.py)

**Q: Как развернуть на production?**
A: [DEPLOYMENT.md](DEPLOYMENT.md)

**Q: Что-то не работает?**
A: [INSTALL.md](INSTALL.md) (раздел "Если что-то не работает") или [QUICKSTART.md](QUICKSTART.md) (раздел "Если что-то не работает")

---

## 📞 Контакты документации

- Основная справка → [README.md](README.md)
- Быстрые вопросы → [QUICKSTART.md](QUICKSTART.md)
- Технические детали → [ARCHITECTURE.md](ARCHITECTURE.md)
- API запросы → [API.md](API.md)
- Проблемы → [INSTALL.md](INSTALL.md)
- Production → [DEPLOYMENT.md](DEPLOYMENT.md)

---

## ✅ Итог

```
📚 8 файлов документации
✅ Полное покрытие всех аспектов
✅ От новичка до production
✅ Пошаговые инструкции
✅ Быстрые ответы на вопросы
✅ Примеры кода
✅ Решение проблем
```

**Начните с [QUICKSTART.md](QUICKSTART.md) - это займет 2 минуты! 🚀**

---

Последнее обновление: 27.06.2024
