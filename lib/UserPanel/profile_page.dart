import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/Homepage.dart';

import 'package:luxurycars/UserPanel/profiledetils.dart';

class ProfiePage extends StatefulWidget {
  const ProfiePage({super.key});

  @override
  State<ProfiePage> createState() => _ProfiePageState();
}

class _ProfiePageState extends State<ProfiePage> {
  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => const HomePage()));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: ProjectColors.black,
                  )),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width * double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileDetails(
                  user: email.toString(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
