import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:luxurycars/authentication/register_main.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (login) => LoginPage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 36, 36, 36),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .045),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (register) => RegisterMain()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 36, 36, 36),
                      )),
                  child: Center(
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 36, 36, 36),
                          fontSize: MediaQuery.of(context).size.width * .045),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90,
            )
          ],
        ),
      ),
    );
  }
}
