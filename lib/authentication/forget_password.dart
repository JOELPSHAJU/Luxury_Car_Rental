import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/authentication/login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

final email = TextEditingController();
final maincolor = Color.fromARGB(255, 46, 70, 90);

class _ForgetPasswordState extends State<ForgetPassword> {
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => const LoginPage()));

      ProjectUtils().sucessmessage(
          context: context,
          text: 'Password reset Link send ! Check your Email');
    } on FirebaseAuthException catch (ex) {
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
      decoration: BoxDecoration(color: Colors.grey[100]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectUtils().headingbig(
                    context: context,
                    text: 'Forget Password',
                    color: maincolor),
                const Divider(),
                ProjectUtils().sizedbox10,
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ProjectUtils().headingsmall(
                      context: context,
                      color: const Color.fromARGB(255, 147, 147, 147),
                      text:
                          'Step 1 : Enter The Registered Email Address,\nStep 2 : Submit The Email,\nStep 3 : A Link Will Be Sent Your Email,\nStep 4 : Open That Link And Update Your Password,\nStep 5 : Now, You Can Login With The Updated Password.'),
                ),
                ProjectUtils().sizedbox10,
                Form(
                  key: formkeyfrgt,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: TextFormField(
                          cursorColor: Colors.black,
                          cursorWidth: 1,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          controller: email,
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
                            hintText: 'Enter your registered email',
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
                      context: context, text: 'Send Mail', Color: maincolor),
                ),
                ProjectUtils().sizedbox20,
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (c) => const LoginPage()));
                  },
                  child: ProjectUtils().headingsmall(
                      context: context,
                      color: maincolor,
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
