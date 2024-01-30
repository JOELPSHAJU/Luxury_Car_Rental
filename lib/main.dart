import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/SplashScreen.dart';
import 'package:luxurycars/firebase_options.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = 'IsUserLoggedIn';
late String usercurrent;

late String updateuseridprofile;
void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
