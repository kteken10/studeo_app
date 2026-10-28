# Studéo

<p align="center"><img src="docs/banner.png" alt="Studéo: student housing app built with Flutter" width="100%"></p>

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS-0A2540)

A Flutter app to find student housing: browse cities, filter rooms, save favorites and follow notifications.

## Screens

<p align="center"><img src="docs/tour.gif" width="260" alt="Tour of the app: home, search, favorites, profile"></p>

| Home | Search | Favorites | Profile |
|:---:|:---:|:---:|:---:|
| <img src="docs/screens/home.png" width="160" alt="Home screen"> | <img src="docs/screens/search.png" width="160" alt="Search screen"> | <img src="docs/screens/favorites.png" width="160" alt="Favorites screen"> | <img src="docs/screens/profile.png" width="160" alt="Profile screen"> |

## Features

- **Home**: housing by city (Paris, Bordeaux, Lille, Lyon…) and a featured offer with insurance and guarantor included.
- **Search**: room listings with filters by type, budget and number of rooms, promotions and availability.
- **Favorites**: rooms saved for later.
- **Notifications**: messages and alerts with unread counters.
- **Profile**: account and preferences.

## Tech stack

- Flutter, Dart
- [iconsax](https://pub.dev/packages/iconsax), [ionicons](https://pub.dev/packages/ionicons)

```
lib/
├── constants/   colors, text styles
├── data/        sample data: cities, locations, rooms, notifications
├── screens/     home, search, favorites, notifications, profile
└── ui/          reusable widgets
```

## Getting started

```bash
flutter pub get
flutter run
```

## Status and roadmap

The app runs on local sample data (`lib/data/`). Next steps:

- [ ] Backend for listings and accounts
- [ ] Booking and payment flow
- [ ] In-app messaging with landlords

## Author

**Dissang Kevin** · Mobile AI Engineer
[Portfolio](https://dissangkevin.work) · [GitHub](https://github.com/kteken10)
