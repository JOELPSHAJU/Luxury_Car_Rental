import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';

import 'package:luxurycars/UserPanel/Homepage.dart';
import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/register_main.dart';
import 'package:luxurycars/authentication/register_page.dart';
import 'package:luxurycars/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

final buttonStyle = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    backgroundColor:
        MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 0, 0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: Colors.white))));
Widget textformfield(
    {required icon, required controller, required bool obsecure}) {
  return TextFormField(
    cursorColor: Color.fromARGB(255, 255, 255, 255),
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
      fillColor: Color.fromARGB(62, 255, 255, 255),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255), width: 2),
          borderRadius: BorderRadius.circular(0)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
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

class _LoginDesktopState extends State<LoginDesktop> {
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
        color: Color.fromARGB(255, 255, 255, 255));
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage(
                'assets/bg/bg.jpg',
              ),
              fit: BoxFit.cover)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .4,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(110, 0, 0, 0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .7,
                            width: MediaQuery.of(context).size.width * .28,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 100,
                                    child: Text(
                                      'S I G N  I N',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          fontFamily:
                                              'fonts/Righteous-Regular.ttf',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    )),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.99,
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
                                                            0.03,
                                                    fontFamily:
                                                        'fonts/Righteous-Regular.ttf',
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                              const SizedBox(
                                                height: 10,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Email',
                                                        style: textstyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      textformfield(
                                                          icon: Icons.person,
                                                          controller:
                                                              _emailcontroller,
                                                          obsecure: false),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        'Password',
                                                        style: textstyle,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      textformfield(
                                                          icon: Icons.security,
                                                          controller:
                                                              _passwordcontroller,
                                                          obsecure: true),
                                                      SizedBox(
                                                        height: 40,
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
                                                            height: 55,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                            child: Center(
                                                              child: Text(
                                                                "sign in"
                                                                    .toUpperCase(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.028,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          4,
                                                                          62),
                                                                  fontFamily:
                                                                      'fonts/Righteous-Regular.ttf',
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Dont have an Account?',
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      172,
                                                                      172,
                                                                      172),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .5,
            color: Colors.transparent,
          ))
        ],
      ),
    ))));
  }

  signin() {
    if (_emailcontroller.text == 'admin@gmail.com' &&
        _passwordcontroller.text == 'admin123') {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => AdminHome()));
    } else
      signInWithEmailAndPassword();
  }
}
