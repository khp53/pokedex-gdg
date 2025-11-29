# 🎮 Pokedex GDG

A Flutter-based Pokedex application that displays Pokemon information using the PokeAPI. This project was created for Google Developer Groups (GDG) demonstration purposes.

## 📱 About The Project

This is a mobile application built with Flutter that allows users to browse through Pokemon and view detailed information about each one. The app fetches real-time data from the PokeAPI and displays it in an intuitive, user-friendly interface.

### Features

- 📋 Browse a list of 50 Pokemon
- 🔍 View detailed information for each Pokemon including:
  - Pokemon sprites (front/back, normal/shiny variations)
  - Base stats (HP, Attack, Defense, etc.)
  - Abilities and types
  - Height, weight, and base experience
- 🎵 Play Pokemon cries (audio)
- ✨ Toggle between shiny and normal sprites
- 🔄 Switch between front and back sprites
- 📱 Responsive UI with Material Design

## 🌐 Data Source

This application uses the [PokeAPI](https://pokeapi.co/) - a free RESTful Pokemon API that provides comprehensive data about Pokemon species, abilities, types, and more.

**API Endpoints Used:**

- `https://pokeapi.co/api/v2/pokemon?offset=0&limit=50` - Fetches list of Pokemon
- `https://pokeapi.co/api/v2/pokemon/{name}` - Fetches detailed information for a specific Pokemon

## 📂 Project Structure

```
pokedex-gdg/
├── lib/
│   ├── main.dart                    # Application entry point
│   ├── app/
│   │   ├── home.dart               # Home screen with Pokemon list
│   │   └── pokedex_details.dart   # Pokemon detail screen
│   └── models/
│       ├── pokemon_ability.dart    # Ability model
│       ├── pokemon_cry.dart        # Cry/sound model
│       ├── pokemon_list.dart       # List response model
│       ├── pokemon_model.dart      # Main Pokemon model
│       ├── pokemon_sprites.dart    # Sprites/images model
│       ├── pokemon_stats.dart      # Stats model
│       └── pokemon_types.dart      # Type model
├── android/                        # Android-specific configuration
├── ios/                           # iOS-specific configuration
├── web/                           # Web-specific configuration
├── test/                          # Test files
├── pubspec.yaml                   # Project dependencies
└── README.md                      # This file
```

### Key Components

- **main.dart**: Initializes the app and sets up the MaterialApp with theme configuration
- **home.dart**: Displays a grid/list of Pokemon fetched from the API
- **pokedex_details.dart**: Shows comprehensive details about a selected Pokemon, including interactive sprite viewer and audio player
- **models/**: Data models that map JSON responses from PokeAPI to Dart objects

## 🛠️ Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  cached_network_image: ^3.4.1  # Efficient image loading and caching
  http: ^1.6.0                   # HTTP requests to PokeAPI
  audioplayers: ^6.4.0           # Playing Pokemon cries/sounds
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for mobile development)
- A code editor (VS Code, Android Studio, or IntelliJ IDEA)

### Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd pokedex-gdg
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation:**
   ```bash
   flutter doctor
   ```

### Running the Application

#### On Mobile (Android/iOS)

1. **Connect a device or start an emulator**

2. **Run the app:**
   ```bash
   flutter run
   ```

#### On Web

```bash
flutter run -d chrome
```

#### On Desktop (macOS/Windows/Linux)

```bash
flutter run -d macos    # For macOS
flutter run -d windows  # For Windows
flutter run -d linux    # For Linux
```

### Building for Production

#### Android APK

```bash
flutter build apk --release
```

#### iOS

```bash
flutter build ios --release
```

#### Web

```bash
flutter build web --release
```

## 🎯 How It Works

1. **App Launch**: The app starts from `main.dart` and navigates to the home screen
2. **Fetching Data**: The home screen makes an HTTP request to PokeAPI to fetch a list of 50 Pokemon
3. **Display List**: Pokemon are displayed in a scrollable grid/list view
4. **View Details**: Tapping on a Pokemon navigates to the detail screen
5. **Detail Screen**: Makes another API call to fetch comprehensive Pokemon data including sprites, stats, abilities, and cries
6. **Interactive Features**: Users can toggle sprite variations and play Pokemon sounds

## 🧪 Testing

Run tests using:

```bash
flutter test
```

## 📝 Notes

- The project name in `pubspec.yaml` is still "helloworld" (the original Flutter template name)
- The app currently loads 50 Pokemon at a time (configurable via the API limit parameter)
- Images are cached using `cached_network_image` for improved performance
- Internet connection is required to fetch Pokemon data

## 🤝 Contributing

This project was created for educational purposes. Feel free to fork and modify it for your own learning or projects.

## 📄 License

This project is open source and available for educational use.

## 🙏 Acknowledgments

- [PokeAPI](https://pokeapi.co/) for providing the free Pokemon data API

---

Made with ❤️ for GDG
