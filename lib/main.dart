import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luxurycars/authentication/splash_screen/splash_screen.dart';
import 'package:luxurycars/firebase_options.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = 'IsUserLoggedIn';

// ignore: constant_identifier_names
const SAVE_KEY_ADMIN = 'IsAdminLoggedIn';

late String updateuseridprofile;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
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
