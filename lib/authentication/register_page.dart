import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/BookingScreens/orders_done.dart';
import 'package:luxurycars/UserPanel/privacy_policies.dart';

import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:luxurycars/authentication/registerRedirect.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

final maincolor = Color.fromARGB(255, 46, 70, 90);

class _RegisterscreenState extends State<Registerscreen> {
  bool passwordobsecure = true;
  bool confirmpasswordobsecure = true;
  String? errorMessage = '';
  bool idLogin = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
      );
      ProjectUtils().sucessmessage(context: context, text: 'Account Created');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (d) => const RegisterRedirect()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ProjectUtils().errormessage(
            context: context, text: 'Account Not Created? Already Used Email');
      });
    }
  }

  bool _isChecked = false;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectUtils().sizedbox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Hello! Register to get',
                        style: GoogleFonts.raleway(
                            fontSize: MediaQuery.of(context).size.width * .08,
                            fontWeight: FontWeight.w600,
                            color: maincolor),
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
                        'started',
                        style: GoogleFonts.raleway(
                            color: maincolor,
                            fontSize: MediaQuery.of(context).size.width * .08,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                ProjectUtils().sizedbox20,
                Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
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
                                    hintText: 'Email',
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
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
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
                                    hintText: 'Password',
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
                                            passwordobsecure =
                                                !passwordobsecure;
                                          });
                                        },
                                        icon: passwordobsecure == true
                                            ? const Icon(
                                                Icons.visibility_off,
                                                color: Colors.grey,
                                              )
                                            : const Icon(Icons.visibility,
                                                color: Colors.grey))),
                                obscureText: passwordobsecure,
                              ),
                            ),
                          ),
                          ProjectUtils().sizedbox20,
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                cursorWidth: 1,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                                controller: _confirmpassword,
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
                                    hintText: 'Confirm password',
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
                                            confirmpasswordobsecure =
                                                !confirmpasswordobsecure;
                                          });
                                        },
                                        icon: confirmpasswordobsecure == true
                                            ? const Icon(
                                                Icons.visibility_off,
                                                color: Colors.grey,
                                              )
                                            : const Icon(Icons.visibility,
                                                color: Colors.grey))),
                                obscureText: confirmpasswordobsecure,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                ProjectUtils().sizedbox20,
                GestureDetector(
                  onTap: () {
                    if (formkey.currentState!.validate()) {
                      if (_passwordcontroller.text == _confirmpassword.text) {
                        if (_isChecked == true) {
                          createUserWithEmailAndPassword();
                        } else {
                          ProjectUtils().warningMessage(
                              context: context,
                              text:
                                  'To Proceed, You Need To Accept The Privacy Policies!');
                        }
                      } else {
                        ProjectUtils().errormessage(
                            context: context, text: 'Password does not match!');
                      }
                    } else {
                      ProjectUtils().errormessage(
                          context: context, text: 'Please Fill This Fields!');
                    }
                  },
                  child: ProjectUtils().button(
                      context: context, text: 'Register', Color: maincolor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = !_isChecked;
                        });
                      },
                    ),
                    Text(
                      'I Accept the',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 117, 117, 117),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (c) => const PrivacyPolicies()));
                      },
                      child: Text(
                        ' Privacy Policies',
                        style: GoogleFonts.poppins(color: maincolor),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                ),
                ProjectUtils().sizedbox10,
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * .03,
                      width: MediaQuery.of(context).size.width * .9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProjectUtils().headingsmall(
                              context: context,
                              color: const Color.fromARGB(255, 117, 117, 117),
                              text: 'Already Have An Account? '),
                          GestureDetector(
                            onTap: () {
                              gotoLogin(context);
                            },
                            child: ProjectUtils().headingsmall(
                                context: context,
                                color: maincolor,
                                text: 'Login'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])
              ],
            )),
      ),
    );
  }
}

void gotoLogin(context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const LoginPage()));
}
