// ignore_for_file: prefer_const_declarations, no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';

import 'package:luxurycars/UserPanel/Homepage.dart';
import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/register_main.dart';
import 'package:luxurycars/authentication/register_page.dart';
import 'package:luxurycars/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final buttonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 0, 0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.white))));
Widget textformfield(
    {required icon, required controller, required bool obsecure}) {
  return TextFormField(
    cursorColor: const Color.fromARGB(255, 255, 255, 255),
    cursorWidth: .98,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please Fill This Field !';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
      fillColor: const Color.fromARGB(47, 0, 0, 0),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 209, 209, 209), width: 2),
          borderRadius: BorderRadius.circular(0)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      errorBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 3,
            color: Color.fromARGB(255, 0, 68, 171),
          ),
          borderRadius: BorderRadius.circular(0)),
      prefixIcon: Icon(
        icon,
        size: 23,
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
    ),
    obscureText: obsecure,
  );
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool idLogin = true;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailandPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('Login Successfull'),
        duration: Duration(seconds: 3),
      ));
      Center(child: CircularProgressIndicator());
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
            height: MediaQuery.of(context).size.height * .96,
            width: MediaQuery.of(context).size.width * .99,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/bg/bmw.png',
                  ),
                  opacity: .9,
                  fit: BoxFit.cover,
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .58,
                          width: MediaQuery.of(context).size.width * .9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height:
                                      MediaQuery.of(context).size.height * .08,
                                  child: Text(
                                    'S I G N  I N',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        fontFamily:
                                            'fonts/Righteous-Regular.ttf',
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.99,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Welcome',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.025,
                                                  fontFamily:
                                                      'fonts/Righteous-Regular.ttf',
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Form(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                key: formkey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Email',
                                                      style: textstyle,
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .09,
                                                      child: textformfield(
                                                          icon: Icons.person,
                                                          controller:
                                                              _emailcontroller,
                                                          obsecure: false),
                                                    ),
                                                    Text(
                                                      'Password',
                                                      style: textstyle,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .09,
                                                      child: textformfield(
                                                          icon: Icons.security,
                                                          controller:
                                                              _passwordcontroller,
                                                          obsecure: true),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (formkey
                                                            .currentState!
                                                            .validate()) {
                                                          signin();
                                                        } else {}
                                                      },
                                                      child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .06,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          44,
                                                                          86)),
                                                          child: Center(
                                                            child: Text(
                                                              "sign in"
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.025,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'fonts/Righteous-Regular.ttf',
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Dont have an Account?',
                                                          style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                255, 255, 255),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.017,
                                                          ),
                                                        ),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (ctx) =>
                                                                              const RegisterMain()));
                                                            },
                                                            child: Text(
                                                                'SignUp',
                                                                style:
                                                                    textstyle))
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
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
