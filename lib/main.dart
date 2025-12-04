import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fitness_flutter/screens/tab_bar/page/tab_bar_page.dart';
import 'package:fitness_flutter/screens/onboarding/page/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDpwuiV5mAlMuUmXtbjpSKAkOgIZoU5bl0",
        authDomain: "fitness-flutter-a2890.firebaseapp.com",
        projectId: "fitness-flutter-a2890",
        storageBucket: "fitness-flutter-a2890.appspot.com",
        messagingSenderId: "248685715013",
        appId: "1:248685715013:web:e9ca091b36dc97ff2bcd2c",
        measurementId: "G-RJWHQXRYJM",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Flutter App',
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Something went wrong: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          return const TabBarPage();
        } else {
          return const OnboardingPage();
        }
      },
    );
  }
}
