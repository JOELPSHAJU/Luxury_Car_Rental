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
                                            255, 117, 117, 117),
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
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w500,
                                            color: ProjectColors.primarycolor2,
                                          ),
                                          controller: _passwordcontroller,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Fill This Field !';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Password',
                                              hintStyle:
                                                  GoogleFonts.signikaNegative(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              208,
                                                              208,
                                                              208)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: ProjectColors
                                                            .primarycolor2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                              enabledBorder: OutlineInputBorder(
                                                  gapPadding: 3,
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 117, 117, 117),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 255, 58, 44),
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: ProjectColors
                                                        .primarycolor2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)),
                                              prefixIcon: Icon(
                                                Icons.security_outlined,
                                                size: 23,
                                                color:
                                                    ProjectColors.primarycolor2,
                                              ),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      passwordobsecure =
                                                          !passwordobsecure;
                                                    });
                                                  },
                                                  icon: passwordobsecure == true
                                                      ? Icon(
                                                          Icons.visibility_off,
                                                          color: ProjectColors
                                                              .primarycolor2,
                                                        )
                                                      : Icon(
                                                          Icons.visibility,
                                                          color: ProjectColors
                                                              .primarycolor2,
                                                        ))),
                                          obscureText: passwordobsecure,
                                        ),
                                      ),
                                    ),
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
                                    SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8),
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: GoogleFonts.signikaNegative(
                                            fontWeight: FontWeight.w500,
                                            color: ProjectColors.primarycolor2,
                                          ),
                                          controller: _confirmpassword,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please Fill This Field !';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'Confirm Password',
                                              hintStyle:
                                                  GoogleFonts.signikaNegative(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              208,
                                                              208,
                                                              208)),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: ProjectColors
                                                            .primarycolor2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                              enabledBorder: OutlineInputBorder(
                                                  gapPadding: 3,
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 117, 117, 117),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10)),
                                              errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 255, 58, 44),
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: ProjectColors
                                                        .primarycolor2,
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)),
                                              prefixIcon: Icon(
                                                Icons.security_outlined,
                                                size: 23,
                                                color:
                                                    ProjectColors.primarycolor2,
                                              ),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      confirmpasswordobsecure =
                                                          !confirmpasswordobsecure;
                                                    });
                                                  },
                                                  icon: confirmpasswordobsecure == true
                                                      ? Icon(
                                                          Icons.visibility_off,
                                                          color: ProjectColors
                                                              .primarycolor2,
                                                        )
                                                      : Icon(
                                                          Icons.visibility,
                                                          color: ProjectColors
                                                              .primarycolor2,
                                                        ))),
                                          obscureText: confirmpasswordobsecure,
                                        ),
                                      ),
                                    ),
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
                                        255, 117, 117, 117),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                const PrivacyPolicies()));
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
                            const Divider(
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
                                                255, 117, 117, 117),
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
