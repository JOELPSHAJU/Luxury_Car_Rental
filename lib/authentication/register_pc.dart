import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:luxurycars/authentication/registerRedirect.dart';

class RegisterscreenPc extends StatefulWidget {
  const RegisterscreenPc({Key? key}) : super(key: key);

  @override
  State<RegisterscreenPc> createState() => _RegisterscreenPcState();
}

// Button style
final buttonStyle = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  backgroundColor: MaterialStateProperty.all<Color>(
    const Color.fromARGB(255, 132, 0, 185),
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: const BorderSide(color: Colors.white),
    ),
  ),
);

// Text form field
Widget textformfield(
    {required IconData icon,
    required TextEditingController controller,
    required bool obsecure}) {
  return Center(
    child: Container(
      child: TextFormField(
        cursorColor: const Color.fromARGB(255, 255, 255, 255),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Fill This Field!';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(47, 0, 0, 0),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 209, 209, 209),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 3,
              color: Color.fromARGB(255, 0, 68, 171),
            ),
            borderRadius: BorderRadius.circular(0),
          ),
          prefixIcon: Icon(
            icon,
            size: 23,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        obscureText: obsecure,
      ),
    ),
  );
}

class _RegisterscreenPcState extends State<RegisterscreenPc> {
  String? errorMessage = '';
  bool idLogin = true;
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/bg/leon-seibert-1RiyAwNIiew-unsplash.jpg'),
                    fit: BoxFit.cover)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .67,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.transparent,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(186, 0, 0, 0),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Text(
                                  'S I G N U P',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.039,
                                    fontFamily: 'fonts/Righteous-Regular.ttf',
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
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
                                            Form(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              key: formkey,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Full Name',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.016,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.09,
                                                    child: textformfield(
                                                      icon: Icons.person,
                                                      controller:
                                                          _namecontroller,
                                                      obsecure: false,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Email',
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.016,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.09,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .9,
                                                    child: textformfield(
                                                      icon: Icons.email,
                                                      controller:
                                                          _emailcontroller,
                                                      obsecure: false,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Password',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.016,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.09,
                                                    child: textformfield(
                                                      icon: Icons.security,
                                                      controller:
                                                          _passwordcontroller,
                                                      obsecure: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (formkey
                                                              .currentState!
                                                              .validate()) {
                                                            createUserWithEmailAndPassword();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                content: Text(
                                                                    'Account Created'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                            Navigator.of(
                                                                    context)
                                                                .pushReplacement(
                                                              MaterialPageRoute(
                                                                builder: (ctx) =>
                                                                    const RegisterRedirect(),
                                                              ),
                                                            );
                                                            _namecontroller
                                                                .clear();
                                                            _emailcontroller
                                                                .clear();
                                                            _passwordcontroller
                                                                .clear();
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                behavior:
                                                                    SnackBarBehavior
                                                                        .floating,
                                                                backgroundColor:
                                                                    Color
                                                                        .fromARGB(
                                                                            255,
                                                                            213,
                                                                            0,
                                                                            0),
                                                                content: Text(
                                                                    'Invalid credentials! Try again'),
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .28,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 95, 142),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .06,
                                                          child: Center(
                                                            child: Text(
                                                              'SIGN UP',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'fonts/Righteous-Regular.ttf',
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.03,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Already have an Account?',
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              255, 255, 255),
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          gotoLogin(context);
                                                        },
                                                        child: Text(
                                                          'SignIn',
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
                                                                0.02,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void gotoLogin(context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const LoginPage()));
}
