import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/UserPanel/Homepage.dart';

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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/latest/870688.webp'),
                    fit: BoxFit.cover,
                    opacity: 0.5)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .45,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .18,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('G O   D R I V E',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * .09,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        const SizedBox(height: 10),
                        Text('Your Ultimate Travel Companion',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              color: const Color.fromARGB(150, 255, 255, 255),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LottieBuilder.asset(
                          'assets/animations/loading.json',
                          width: MediaQuery.of(context).size.width * .5,
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )),
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
