# 📖 InkVerse Companion App

Welcome to the **InkVerse Companion App** — a Flutter-based application designed to bring the **InkVerse** literary universe straight to your mobile device.

> **InkVerse** is a sanctuary for novel enthusiasts and bold storytellers — a digital haven where stories unfold in their purest form. Born from the creative soul of **Purrs**, it began as a platform to host personal tales and is now blossoming into a home for a vibrant community of writers.

---

## 🚀 Overview

The companion app provides a seamless, full-screen, distraction-free reading experience, enabling readers to immerse themselves in InkVerse stories on the go — no browser tabs, no clutter. Just you and the story.

> 🌐 **Currently loading:** [https://sumit7739.github.io/InkVerse](https://sumit7739.github.io/InkVerse)

---

## ✨ Current Features

* **Immersive Reading**
  A distraction-free, full-screen environment tailored for enjoying stories without browser UI elements.

* **Branded Splash Screen**
  A clean launch experience with the InkVerse logo and a soft background.

* **Smart Back Navigation**
  Android’s back gesture navigates within the WebView history before exiting the app.

* **Custom App Icon & Name**
  The InkVerse name and icon are displayed on your device for easy access.

* **Loading Indicator**
  Subtle progress indicator while content is being fetched.

* **Robust Internet Access**
  Configured for smooth, uninterrupted loading of web content.

---

## 🔮 Coming Soon

We’re working actively to bring more powerful features to both the **InkVerse Platform** and this **Companion App**.

### 📱 Upcoming App Features:

* **Login Integration**
  Stay logged in with secure token storage (no repeated logins).

* **Offline Reading**
  Download stories and enjoy them without an internet connection.

* **Sync Reading Progress**
  Seamlessly sync bookmarks, preferences, and reading history.

* **Push Notifications**
  Get alerts for new chapters, story updates, and announcements.

### 🌐 Upcoming Platform Features:

* **Story Upload & Management**
  Creators can upload, edit, and manage their work directly.

* **Community Features**
  Discussions, comments, and interactive tools to connect writers and readers.

* **Advanced Discovery Tools**
  Smarter recommendations and search filters to help you find stories you’ll love.

---

## 🛠️ Getting Started (For Developers)

To run this project locally:

```bash
# Clone the repository
git clone https://github.com/Sumit7739/inkverse_app.git
cd inkverse_app

# Install dependencies
flutter pub get

# Generate app icons (if needed)
flutter pub run flutter_launcher_icons

# Run the app
flutter run
```

> 💡 *Ensure you have an Android emulator running or a physical device connected.*

---

## 📦 Building for Release (Android)

To generate a release APK:

1. Make sure the following permission is added to `android/app/src/main/AndroidManifest.xml`:

   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```

2. Build the APK:

   ```bash
   flutter build apk --release
   ```

3. The APK will be located at:

   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork** the repository
2. **Create a branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make changes** and **commit**

   ```bash
   git commit -m 'feat: Add amazing new feature'
   ```
4. **Push changes**

   ```bash
   git push origin feature/your-feature-name
   ```
5. **Open a Pull Request**

---

## 📜 License

This project is licensed under the **MIT License**.
See the [LICENSE](LICENSE) file for more details.

---

## 🙏 Acknowledgements

* Built with ❤️ using [Flutter](https://flutter.dev)
* Powered by the **InkVerse** platform, created by **Purrs**
* Thanks to the communities behind:

  * [`webview_flutter`](https://pub.dev/packages/webview_flutter)
  * [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons)

---

