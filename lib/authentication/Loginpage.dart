// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/Homepage.dart';
import 'package:luxurycars/admin_panel/admin_home_page/admin_home.dart';

import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/forget_password/forget_password.dart';


import 'package:luxurycars/authentication/register_screen/register_main.dart';

import 'package:luxurycars/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final maincolorf = Color.fromARGB(255, 46, 70, 90);
bool obsecure = true;
final maincolor = Colors.white;
bool isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool idLogin = true;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Auth().signInWithEmailandPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);

      const Center(child: CircularProgressIndicator());
      goToUserHome();
      ProjectUtils().sucessmessage(context: context, text: 'Login Sucessful');
      final _sharedpref = await SharedPreferences.getInstance();
      _sharedpref.setBool(SAVE_KEY_NAME, true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ProjectUtils()
            .errormessage(context: context, text: 'invalid email or password');
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Welcome back! Glad',
                    style: GoogleFonts.raleway(
                        color: maincolorf,
                        fontSize: MediaQuery.of(context).size.width * .08,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'to see you, Again!',
                    style: GoogleFonts.raleway(
                        color: maincolorf,
                        fontSize: MediaQuery.of(context).size.width * .099,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            ProjectUtils().sizedbox20,
            ProjectUtils().sizedbox20,
            ProjectUtils().sizedbox20,
            Form(
                key: formkey,
                child: SingleChildScrollView(
                    child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TextFormField(
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          controller: _emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Fill This Field !';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'Enter your email',
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          )),
                    ),
                  ),
                  ProjectUtils().sizedbox20,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        controller: _passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Fill This Field !';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: 'Enter your password',
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 10),
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsecure = !obsecure;
                                  });
                                },
                                icon: obsecure == true
                                    ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey,
                                      )
                                    : const Icon(Icons.visibility,
                                        color: Colors.grey))),
                        obscureText: obsecure,
                      ),
                    ),
                  ),
                  ProjectUtils().sizedbox20,
                ]))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => const ForgetPassword()));
                    },
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.poppins(color: maincolorf),
                    ),
                  ),
                ),
              ],
            ),
            ProjectUtils().sizedbox10,
            GestureDetector(
              onTap: () {
                if (formkey.currentState!.validate()) {
                  signin();
                } else {
                  ProjectUtils().errormessage(
                      context: context, text: 'Please Fill This Fields!');
                }
              },
              child: ProjectUtils()
                  .button(context: context, text: 'Login', Color: maincolorf),
            ),
            ProjectUtils().sizedbox20,
            Divider(),
            ProjectUtils().sizedbox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectUtils().headingsmall(
                    context: context,
                    color: const Color.fromARGB(255, 117, 117, 117),
                    text: "Don't Have An Account?   "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (c) => const RegisterMain()));
                  },
                  child: ProjectUtils().headingsmall(
                      context: context, color: maincolorf, text: 'Register'),
                )
              ],
            ),
          ],
        ));
  }

  signin() {
    if (_emailcontroller.text == 'admin@gmail.com' &&
        _passwordcontroller.text == 'admin123') {
      gotoadminhome();
    } else {
      signInWithEmailAndPassword();
    }
  }

  Future<void> gotoadminhome() async {
    showDialog(
      barrierColor: const Color.fromARGB(65, 0, 0, 0),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const AdminHome()),
    );
  }

  Future goToUserHome() async {
    showDialog(
      barrierColor: const Color.fromARGB(65, 0, 0, 0),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 2));

    Navigator.pop(context);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => const HomePage()));
  }
}
