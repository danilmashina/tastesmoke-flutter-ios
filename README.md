# 🍃 TasteSmoke Flutter iOS

Flutter клон приложения TasteSmoke для iOS с автоматической сборкой через GitHub Actions и установкой через AltStore.

## 🎯 Особенности

- ✅ **Полная Firebase интеграция**: Auth, Firestore, Storage, Analytics, Remote Config
- ✅ **Автоматическая сборка iOS .ipa** через GitHub Actions
- ✅ **Установка без Apple Developer Program** через AltStore
- ✅ **Темная тема** в стиле оригинального Android приложения
- ✅ **Адаптивный UI** для iOS устройств
- ✅ **Offline persistence** для Firestore
- ⏳ **Push-уведомления** (требует платную подписку Apple Developer)

## 🏗 Архитектура

```
lib/
├── app/                    # Основное приложение
├── core/                   # Базовая функциональность
│   ├── services/          # Firebase сервисы
│   └── theme/             # Тема приложения
├── features/              # Модули функций
│   ├── auth/              # Авторизация
│   └── home/              # Главный экран
└── firebase_options.dart  # Firebase конфигурация
```

## 🚀 Быстрый старт

### 1. Клонирование репозитория
```bash
git clone YOUR_REPO_URL
cd tastesmoke_flutter
```

### 2. Установка зависимостей
```bash
flutter pub get
cd ios && pod install
```

### 3. Запуск на симуляторе
```bash
flutter run
```

### 4. Сборка для устройства
```bash
flutter build ios --release --no-codesign
```

## 🔧 Firebase настройка

### Необходимые файлы:
- `android/app/google-services.json` (скопирован из основного проекта)
- `ios/Runner/GoogleService-Info.plist` (сгенерирован)
- `lib/firebase_options.dart` (сгенерирован)

### Используемые сервисы:
- **Firebase Auth**: Авторизация с email и паролем
- **Cloud Firestore**: База данных для миксов, пользователей, избранного
- **Firebase Storage**: Хранение изображений профилей и миксов
- **Firebase Analytics**: Аналитика действий пользователей
- **Firebase Remote Config**: Управление функциями и обновлениями

## 📱 GitHub Actions CI/CD

### Workflow: `.github/workflows/ios_ipa_build.yml`

**Триггеры**:
- Push в `main`/`master`
- Pull Request
- Ручной запуск (`workflow_dispatch`)

**Процесс сборки**:
1. Setup Flutter (stable)
2. Flutter dependencies
3. CocoaPods install
4. iOS build (без подписи)
5. Создание .ipa архива
6. Upload артефактов

**Артефакты**:
- `TasteSmoke-iOS-{номер}` - .ipa файл для установки
- `TasteSmoke-dSYM-{номер}` - символы для отладки

## 📲 Установка через AltStore

### Требования:
- iPhone с iOS 12.2+
- Windows компьютер с iTunes и iCloud
- Бесплатный Apple ID
- AltStore и AltServer

### Процесс установки:
1. Скачайте .ipa из GitHub Actions артефактов
2. Установите AltServer на Windows
3. Установите AltStore на iPhone через AltServer
4. Загрузите .ipa через AltStore

**📖 Подробное руководство**: [ALTSTORE_INSTALLATION_GUIDE.md](ALTSTORE_INSTALLATION_GUIDE.md)

## 🎨 UI/UX Особенности

### Цветовая схема (из Android версии):
- **Фон**: `#323234` (Темно-серый)
- **Карточки**: `#474747` (Серый)
- **Акцент**: `#D44271` (Розовый) / `#4285F4` (Синий)
- **Текст**: `#FFFFFF` (Белый) / `#A1A1AA` (Серый)

### Компоненты:
- Material 3 Design
- Закругленные углы (14px)
- Темная тема по умолчанию
- Адаптивная навигация
- Анимации переходов

## 🔒 Безопасность

### Авторизация:
- Email + пароль (минимум 6 символов)
- Обязательная верификация email
- Сброс пароля через Firebase

### Данные:
- Offline persistence для Firestore
- Кэширование изображений
- Безопасные Firebase правила (настроены в основном проекте)

## ⚠️ Ограничения бесплатной установки

### AltStore ограничения:
- **Максимум 3 приложения** одновременно на бесплатный Apple ID
- **7 дней** срок действия подписи
- **Требует периодического обновления** через AltStore
- **Нет push-уведомлений** без платной подписки

### Решение:
Для продакшена рекомендуется:
1. Приобрести Apple Developer Program ($99/год)
2. Настроить правильную подпись в CI/CD
3. Использовать TestFlight для распространения

## 🛠 Разработка

### Команды:
```bash
# Анализ кода
flutter analyze

# Форматирование
flutter format .

# Тесты
flutter test

# Очистка
flutter clean

# Rebuild iOS
cd ios && pod install --repo-update
flutter build ios
```

### Добавление функций:
1. Создайте новый модуль в `lib/features/`
2. Добавьте необходимые сервисы в `lib/core/services/`
3. Обновите навигацию в `home_screen.dart`
4. Добавьте аналитику для новых экранов

## 📊 Аналитика

Используется Firebase Analytics для отслеживания:
- Регистрации и входы пользователей
- Создание миксов
- Добавление в избранное
- Навигация между экранами
- Лайки и взаимодействия

## 🔮 Roadmap

### Этап 1 (Текущий):
- ✅ Базовая авторизация
- ✅ Firebase интеграция
- ✅ GitHub Actions CI/CD
- ✅ AltStore установка

### Этап 2:
- 🔄 Перенос UI компонентов из Android версии
- 🔄 Система миксов и ингредиентов
- 🔄 Профиль пользователя с аватарами
- 🔄 Социальные функции (лайки, комментарии)

### Этап 3:
- ⏳ Push-уведомления (требует Apple Developer)
- ⏳ TestFlight распространение
- ⏳ App Store публикация
- ⏳ Синхронизация с Android версией

## 🤝 Вклад в проект

1. Fork репозитория
2. Создайте feature ветку: `git checkout -b feature/new-feature`
3. Commit изменения: `git commit -am 'Add new feature'`
4. Push в ветку: `git push origin feature/new-feature`
5. Создайте Pull Request

## 📄 Лицензия

Этот проект лицензирован под MIT License - см. [LICENSE](LICENSE) файл.

## 📞 Поддержка

- **Issues**: [GitHub Issues](https://github.com/YOUR_REPO/issues)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_REPO/discussions)
- **Email**: your-email@domain.com

---

**Создано с ❤️ для сообщества TasteSmoke**
