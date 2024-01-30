import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/Universaltools.dart';

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
          MaterialPageRoute(builder: (d) => RegisterRedirect()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ProjectUtils().errormessage(
            context: context, text: 'Account Not Created? Already Used Email');
      });
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/bg/PicsArt_01-24-09.30.53.jpg'),
                fit: BoxFit.cover,
              )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProjectUtils().sizedbox20,
                    ProjectUtils().sizedbox20,
                    ProjectUtils().headingbig(
                        context: context,
                        text: 'S I G N  U P',
                        color: Colors.white),
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
                                enabled: Colors.white,
                                focusedcolor: ProjectUtils().textformfieldcolor,
                                iconcolor: Colors.white,
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
                                enabled: Colors.white,
                                focusedcolor: ProjectUtils().textformfieldcolor,
                                iconcolor: Colors.white,
                                icon: Icons.security,
                                controller: _passwordcontroller,
                                obsecure: true),
                            ProjectUtils().sizedbox10,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProjectUtils().headingsmall(
                                    context: context,
                                    color: Colors.white,
                                    text: 'Confirm Password')
                              ],
                            ),
                            ProjectUtils().sizedbox10,
                            ProjectUtils().textformfield(
                                enabled: Colors.white,
                                focusedcolor: ProjectUtils().textformfieldcolor,
                                iconcolor: Colors.white,
                                icon: Icons.security,
                                controller: _confirmpassword,
                                obsecure: true),
                          ],
                        )),
                    ProjectUtils().sizedbox20,
                    ProjectUtils().sizedbox20,
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          if (_passwordcontroller.text ==
                              _confirmpassword.text) {
                            createUserWithEmailAndPassword();
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
                          text: 'SIGN UP',
                          Color: ProjectUtils().textformfieldcolor),
                    ),
                    ProjectUtils().sizedbox20,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(111, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProjectUtils().headingsmall(
                              context: context,
                              color: Colors.white,
                              text: 'Already Have An Account? '),
                          GestureDetector(
                            onTap: () {
                              gotoLogin(context);
                            },
                            child: ProjectUtils().headingsmall(
                                context: context,
                                color: Colors.white,
                                text: 'Login'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

void gotoLogin(context) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (ctx) => const LoginPage()));
}
