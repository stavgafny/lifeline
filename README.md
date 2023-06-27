# Lifeline

## 🛠️ Prerequisites
Before running the app, ensure that you have the following set up:
* Flutter SDK installed. If not, follow the official [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
* Firebase project with enabled authentication and database services: [Firebase Console](https://console.firebase.google.com/)

Additionally, make sure to install a mobile emulator or use a physical device as the app doesn't currently support web.

## ⚙️ Setup

1. Clone this repository to your local machine:
```bash
git clone https://github.com/stavgafny/lifeline.git
```
2. Navigate to the project directory:
```bash
cd lifeline
```
3. Install the dependencies:
```bash
flutter pub get
```
4. Update the Firebase options:
* Add `firebase_options.dart` file in ./lib/constants/
* Replace the placeholder values with your Firebase configuration.
```dart
// TODO: Replace with your Firebase configuration
final firebaseOptions = FirebaseOptions(
  appId: 'your-app-id',
  apiKey: 'your-api-key',
  projectId: 'your-project-id',
  // ...
);
```

## 🚀 Run
```bash
flutter run
```

## 🎬 Usage
* Open the app on your mobile device or emulator.
* Sign up using your email and password or choose the Google Sign-In option.
* Log in using your credentials.
* Explore the app's features.
* Enjoy the app!

## 🤝 Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to share them.

## 📧 Contact
For any inquiries or support, you can reach out to stavgafny@gmail.com.
