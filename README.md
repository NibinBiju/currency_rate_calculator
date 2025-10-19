# ThoughtBox Currency Rate Calculator

A modern, animated Flutter application that converts currencies using a REST API.  
The app includes Firebase authentication, offline caching, trend visualization, and clean BLoC architecture for scalability and maintainability.

## Setup Steps
Flutter & Dart Versions
Flutter version: 3.35.1

Dart version: 3.9.4

Make sure to have Flutter installed with compatible Dart SDK. You can check versions by running:

- bash
- flutter --version

## Firebase Configuration
- Create a Firebase project in the Firebase Console.
- Add an Android/iOS app and download the google-services.json / GoogleService-Info.plist respectively.
- Place the config files in the appropriate platform folders:
- Android: android/app/
- iOS: ios/Runner/
- Enable Email/Password authentication in Firebase Authentication settings.
- Update the Firebase options in your Flutter app accordingly (usually in main.dart or a config file).

## Login details

email: nibinbiju222@gmail.com 
password: Nibin@123

---

## Overview

The Currency Rate Calculator allows users to securely log in, convert between global currencies in real time, and view a simple 5-day trend chart using fixed data.  
It focuses on a delightful user experience with smooth animations, clean visuals, and reliable offline performance.

---

## Authentication

- Email/Password login and registration using Firebase Authentication  
- Persistent login sessions for seamless access  
- Smooth slide transition navigation after authentication  
- Sign-out functionality integrated with Firebase  

---

## Currency Conversion

- Real-time currency conversion
- Secure base URL and access key stored using Dart environment variables  
- Elegant UI with two animated cards for “From” and “To' currencies  
- Swap button with rotation and position animations  
- Conversion result displayed with smooth reveal animation  

---

## Folder Structure

lib/
┣ core/
┃ ┣ configs/
┃ ┃ ┗ env.dart
┃ ┗ services/
┃ ┗ dio_service.dart
┣ data/
┃ ┣ model/
┃ ┣ repository/
┃ ┗ source/
┣ domain/
┃ ┣ repository/
┃ ┗ usecases/
┣ presentation/
┃ ┣ bloc/
┃ ┣ pages/
┃ ┃ ┣ splash_page.dart
┃ ┃ ┣ login_page.dart
┃ ┃ ┣ register_page.dart
┃ ┃ ┣ home_page.dart
┃ ┃ ┗ trend_page.dart
┃ ┗ widgets/
┃ ┣ currency_picker.dart
┃ ┗ result_card.dart
┗ main.dart

---

## 5-Day Trend (Mock Data)

- Line chart representation of the last 5 days using static mock data  
- Built using the fl_chart package  
- Includes animated line draw and fade-in point effects  
- Displays minimum, average, and maximum values with opacity animation using chip widget

---

## Offline Caching

- Recent conversions are cached using SharedPreferences  
- Cached results appear at the bottom of the home screen  
- Provides offline access to previously fetched data  

---

## UI & UX Highlights

- Clean and minimal Material 3 design  
- Light and dark mode support  
- Micro animations and transitions for a polished experience  
- Lottie animation for splash and success interactions  
- Responsive layout optimized for all devices  

---

## Architecture

- Built using the BLoC (flutter_bloc) pattern  
- Follows a Clean Architecture structure separating UI, domain, and data layers  
- Includes repository abstraction and dependency injection for scalability  
- Data flow designed as:  
  UI → BLoC → Usecase → Repository → Remote/Data Source  

---

## Technical Stack

- Flutter & Dart  
- Firebase Authentication  
- Dio (API integration)  
- fl_chart (trend visualization)  
- SharedPreferences (local storage)  
- Lottie (animations)  
- flutter_animate (transitions & effects)  
- get_it (dependency injection)  

---

## Key Functionalities

- Firebase login and registration  
- Secure API handling via environment variables  
- Currency conversion with animated results  
- Swap animation for currency cards  
- Trend graph with mock data visualization  
- Offline caching with quick access to previous conversions  
- Smooth sign-out functionality  

---

## Demo Flow

1. Splash screen animation  
2. Firebase login or registration  
3. Navigation to Home with slide transition  
4. Currency selection and conversion  
5. Swap animation between currencies  
6. Display of converted value  
7. Viewing 5-day mock trend chart  
8. Cached conversions displayed at the bottom  
9. Sign-out from Firebase  

---

## Deliverables

- Firebase Authentication with clean UI  
- Currency conversion using Exconvert API  
- Offline caching for recent data  
- 5-day trend chart using fl_chart  
- Secure environment configuration  
- Animated and polished UX design  
- Complete README, APK, and demo video  

--

##Demo video

https://drive.google.com/file/d/1V5b9C_UPndVIeZaxGWJ7abU7xkpEBw7z/view?

## Developed By

**Nibin Biju**  
Flutter Developer
