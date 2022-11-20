import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/screens/login.dart';
import 'package:flutter_todolist_firebase/utils/navbar.dart';
import 'package:flutter_todolist_firebase/utils/themes.dart';

// build command = flutter build apk --target-platform android-arm64
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todolist with Firebase',
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheem,
        themeMode: ThemeMode.system,
        home: const MainPage());
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (contexy, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return const Navbar();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
