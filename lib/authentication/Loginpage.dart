// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/Homepage.dart';

import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/forget_password.dart';
import 'package:luxurycars/authentication/register_main.dart';

import 'package:luxurycars/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

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
      ProjectUtils().sucessmessage(context: context, text: 'Login Sucessful');
      const Center(child: CircularProgressIndicator());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomePage()));
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
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/max/loginbg.png',
                      ),
                      opacity: .9,
                      fit: BoxFit.cover,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .73,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (isLoading)
                                  const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                                ProjectUtils().sizedbox20,
                                ProjectUtils().sizedbox20,
                                ProjectUtils().headingbig(
                                    context: context,
                                    text: 'Welcome Back',
                                    color: ProjectColors.primarycolor2),
                                ProjectUtils().sizedbox20,
                                Form(
                                    key: formkey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProjectUtils().headingsmall(
                                                  context: context,
                                                  color: ProjectColors
                                                      .primarycolor2,
                                                  text: 'Email')
                                            ],
                                          ),
                                        ),
                                        ProjectUtils().sizedbox10,
                                        ProjectUtils().textformfield(
                                            label: 'Email Address',
                                            enabled: const Color.fromARGB(
                                                255, 208, 208, 208),
                                            focusedcolor:
                                                ProjectColors.primarycolor2,
                                            iconcolor:
                                                ProjectColors.primarycolor2,
                                            icon: Icons.person,
                                            controller: _emailcontroller,
                                            obsecure: false),
                                        ProjectUtils().sizedbox10,
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProjectUtils().headingsmall(
                                                  context: context,
                                                  color: ProjectColors
                                                      .primarycolor2,
                                                  text: 'Password')
                                            ],
                                          ),
                                        ),
                                        ProjectUtils().sizedbox10,
                                        ProjectUtils().textformfield(
                                            label: 'Password',
                                            enabled: const Color.fromARGB(
                                                255, 208, 208, 208),
                                            focusedcolor:
                                                ProjectColors.primarycolor2,
                                            iconcolor:
                                                ProjectColors.primarycolor2,
                                            icon: Icons.security,
                                            controller: _passwordcontroller,
                                            obsecure: true),
                                      ],
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      ForgetPassword()));
                                        },
                                        child: ProjectUtils().headingsmall(
                                            context: context,
                                            color: ProjectColors.primarycolor2,
                                            text: 'Forget Password?'))
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      signin();
                                    } else {
                                      ProjectUtils().errormessage(
                                          context: context,
                                          text: 'Please Fill This Fields!');
                                    }
                                  },
                                  child: ProjectUtils().button(
                                      context: context,
                                      text: 'Login',
                                      Color: ProjectColors.primarycolor2),
                                ),
                                ProjectUtils().sizedbox20,
                                const Divider(
                                  thickness: 1,
                                ),
                                ProjectUtils().sizedbox20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ProjectUtils().headingsmall(
                                        context: context,
                                        color: const Color.fromARGB(
                                            255, 194, 194, 194),
                                        text: "Don't Have An Account?   "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    const RegisterMain()));
                                      },
                                      child: ProjectUtils().headingsmall(
                                          context: context,
                                          color: ProjectColors.primarycolor2,
                                          text: 'Sign Up'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))));
  }

  signin() {
    setState(() {
      usercurrent = _emailcontroller.text;
    });
    if (_emailcontroller.text == 'admin@gmail.com' &&
        _passwordcontroller.text == 'admin123') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const AdminHome()));
    } else {
      signInWithEmailAndPassword();
    }
  }
}
