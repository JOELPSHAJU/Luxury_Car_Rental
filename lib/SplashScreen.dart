import 'package:flutter/material.dart';
import 'package:luxurycars/UserPanel/Homepage.dart';
import 'package:luxurycars/authentication/loginpage.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:luxurycars/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .93,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/latest/870688.webp'),
                  fit: BoxFit.cover,
                  opacity: 0.5)),
          child: Center(
            child: Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('G O   D R I V E',
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text(
                    'Your Ultimate Travel Companion',
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const HomePage()));
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginPage()));
  }

  Future<void> checkUserLoggedIn() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    final userloggedIn = _sharedprefs.getBool(SAVE_KEY_NAME);
    if (userloggedIn == null || userloggedIn == false) {
      gotoLogin();
    } else {
      gotoHome();
    }
  }
}
