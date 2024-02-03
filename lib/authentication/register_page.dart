import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/privacy_policies.dart';

import 'package:luxurycars/authentication/Auth.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:luxurycars/authentication/registerRedirect.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  String? errorMessage = '';
  bool idLogin = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpassword = TextEditingController();
  final formkey = GlobalKey<FormState>();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailandPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      // ignore: use_build_context_synchronously
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/max/loginbg.png'),
              fit: BoxFit.cover,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  height: MediaQuery.of(context).size.height * .75,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProjectUtils().sizedbox20,
                            ProjectUtils().headingbig(
                                context: context,
                                text: 'Get Started',
                                color: ProjectColors.primarycolor2),
                            ProjectUtils().sizedbox10,
                            Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ProjectUtils().headingsmall(
                                              context: context,
                                              color:
                                                  ProjectColors.primarycolor2,
                                              text: 'Email')
                                        ],
                                      ),
                                    ),
                                    ProjectUtils().textformfield(
                                        label: 'Enter A Valid Email Address',
                                        enabled: const Color.fromARGB(
                                            255, 202, 202, 202),
                                        focusedcolor:
                                            ProjectColors.primarycolor2,
                                        iconcolor: ProjectColors.primarycolor2,
                                        icon: Icons.person,
                                        controller: _emailcontroller,
                                        obsecure: false),
                                    ProjectUtils().sizedbox10,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ProjectUtils().headingsmall(
                                              context: context,
                                              color:
                                                  ProjectColors.primarycolor2,
                                              text: 'Password')
                                        ],
                                      ),
                                    ),
                                    ProjectUtils().textformfield(
                                        label: 'Password',
                                        enabled: const Color.fromARGB(
                                            255, 202, 202, 202),
                                        focusedcolor:
                                            ProjectColors.primarycolor2,
                                        iconcolor: ProjectColors.primarycolor2,
                                        icon: Icons.security,
                                        controller: _passwordcontroller,
                                        obsecure: true),
                                    ProjectUtils().sizedbox10,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ProjectUtils().headingsmall(
                                              context: context,
                                              color:
                                                  ProjectColors.primarycolor2,
                                              text: 'Confirm Password')
                                        ],
                                      ),
                                    ),
                                    ProjectUtils().textformfield(
                                        label: 'Confirm Password',
                                        enabled: const Color.fromARGB(
                                            255, 202, 202, 202),
                                        focusedcolor:
                                            ProjectColors.primarycolor2,
                                        iconcolor: ProjectColors.primarycolor2,
                                        icon: Icons.security,
                                        controller: _confirmpassword,
                                        obsecure: true),
                                  ],
                                )),
                            ProjectUtils().sizedbox20,
                            GestureDetector(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  if (_passwordcontroller.text ==
                                      _confirmpassword.text) {
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
                                        context: context,
                                        text: 'Password does not match!');
                                  }
                                } else {
                                  ProjectUtils().errormessage(
                                      context: context,
                                      text: 'Please Fill This Fields!');
                                }
                              },
                              child: ProjectUtils().button(
                                  context: context,
                                  text: 'Sign Up',
                                  Color: ProjectColors.primarycolor2),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: ProjectColors.primarycolor2,
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                ),
                                Text(
                                  'By Signing Up, I Accept the',
                                  style: GoogleFonts.signikaNegative(
                                    color: const Color.fromARGB(
                                        255, 202, 202, 202),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (c) => PrivacyPolicies()));
                                  },
                                  child: Text(
                                    ' Privacy Policies',
                                    style: GoogleFonts.signikaNegative(
                                      color: ProjectColors.primarycolor2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            ProjectUtils().sizedbox20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: MediaQuery.of(context).size.height *
                                        .03,
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ProjectUtils().headingsmall(
                                            context: context,
                                            color: const Color.fromARGB(
                                                255, 202, 202, 202),
                                            text: 'Already Have An Account? '),
                                        GestureDetector(
                                          onTap: () {
                                            gotoLogin(context);
                                          },
                                          child: ProjectUtils().headingsmall(
                                              context: context,
                                              color:
                                                  ProjectColors.primarycolor2,
                                              text: 'Login'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
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
