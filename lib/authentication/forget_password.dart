import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/authentication/login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final email = TextEditingController();

class _ForgetPasswordState extends State<ForgetPassword> {
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => LoginPage()));
      // ignore: use_build_context_synchronously
      ProjectUtils().sucessmessage(
          context: context,
          text: 'Password reset Link send ! Check your Email');
    } on FirebaseAuthException catch (ex) {
      // ignore: use_build_context_synchronously
      ProjectUtils()
          .errormessage(context: context, text: 'Some Error Happened $ex');
    }
  }

  final formkeyfrgt = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectUtils().headingbig(
                    context: context,
                    text: 'Forget Password',
                    color: ProjectColors.primarycolor2),
                Divider(),
                ProjectUtils().sizedbox10,
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ProjectUtils().headingsmall(
                      context: context,
                      color: Color.fromARGB(255, 147, 147, 147),
                      text:
                          'Step 1 : Enter The Registered Email Address,\nStep 2 : Submit The Email,\nStep 3 : A Link Will Be Sent Your Email,\nStep 4 : Open That Link And Update Your Password,\nStep 5 : Now, You Can Login With The Updated Password.'),
                ),
                ProjectUtils().sizedbox10,
                Form(
                  key: formkeyfrgt,
                  child: ProjectUtils().textformfield(
                      icon: Icons.email,
                      controller: email,
                      obsecure: false,
                      focusedcolor: ProjectColors.primarycolor2,
                      enabled: const Color.fromARGB(255, 215, 215, 215),
                      label: 'Email Address',
                      iconcolor: ProjectColors.primarycolor2),
                ),
                ProjectUtils().sizedbox20,
                GestureDetector(
                  onTap: () {
                    if (formkeyfrgt.currentState!.validate()) {
                      resetPassword();
                    } else {
                      ProjectUtils().errormessage(
                          context: context,
                          text: 'Please Enter The Email Address');
                    }
                  },
                  child: ProjectUtils().button(
                      context: context,
                      text: 'Submit',
                      Color: ProjectColors.primarycolor2),
                ),
                ProjectUtils().sizedbox20,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (c) => LoginPage()));
                  },
                  child: ProjectUtils().headingsmall(
                      context: context,
                      color: ProjectColors.primarycolor2,
                      text: ' Go Back To Login Page'),
                )
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
