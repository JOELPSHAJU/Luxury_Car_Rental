// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/Homepage.dart';

import 'package:luxurycars/authentication/Auth.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('Login Successfull'),
        duration: Duration(seconds: 3),
      ));
      const Center(child: CircularProgressIndicator());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const HomePage()));
      final _sharedpref = await SharedPreferences.getInstance();
      _sharedpref.setBool(SAVE_KEY_NAME, true);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('invalid email or password'),
          duration: Duration(seconds: 3),
        ));
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textstyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.019,
        color: const Color.fromARGB(255, 255, 255, 255));
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/bg/bmw.png',
                  ),
                  opacity: .9,
                  fit: BoxFit.cover,
                )),
            child: Padding(
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
                      context: context, text: 'LOGIN', color: maincolor),
                  ProjectUtils().sizedbox20,
                  Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formkey,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProjectUtils().headingsmall(
                                  context: context,
                                  color: Colors.white,
                                  text: 'Email')
                            ],
                          ),
                          ProjectUtils().sizedbox10,
                          ProjectUtils().textformfield(
                              enabled: maincolor,
                              focusedcolor: ProjectUtils().textformfieldcolor,
                              iconcolor: maincolor,
                              icon: Icons.person,
                              controller: _emailcontroller,
                              obsecure: false),
                          ProjectUtils().sizedbox10,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProjectUtils().headingsmall(
                                  context: context,
                                  color: Colors.white,
                                  text: 'Password')
                            ],
                          ),
                          ProjectUtils().sizedbox10,
                          ProjectUtils().textformfield(
                              enabled: maincolor,
                              focusedcolor: ProjectUtils().textformfieldcolor,
                              iconcolor: maincolor,
                              icon: Icons.security,
                              controller: _passwordcontroller,
                              obsecure: true),
                        ],
                      )),
                  ProjectUtils().sizedbox20,
                  ProjectUtils().sizedbox20,
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        signin();
                      } else {
                        ProjectUtils().errormessage(
                            context: context, text: 'Please Fill This Fields!');
                      }
                    },
                    child: ProjectUtils().button(
                        context: context,
                        text: 'LOGIN',
                        Color: ProjectUtils().textformfieldcolor),
                  ),
                  ProjectUtils().sizedbox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProjectUtils().headingsmall(
                          context: context,
                          color: Colors.white,
                          text: "Don't Have An Account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => RegisterMain()));
                        },
                        child: ProjectUtils().headingsmall(
                            context: context,
                            color: Colors.white,
                            text: 'Sign Up'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ))),
    );
  }

  signin() {
    setState(() {
      usercurrent = _emailcontroller.text;
    });
    if (_emailcontroller.text == 'admin@gmail.com' &&
        _passwordcontroller.text == 'admin123') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AdminHome()));
    } else
      signInWithEmailAndPassword();
  }
}
