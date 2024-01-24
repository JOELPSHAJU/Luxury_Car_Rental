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
        appBar: AppBar(
          backgroundColor: ProjectColors.primarycolor1,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ProjectColors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const HomePage()));
              },
              icon: Icon(
                Icons.arrow_back,
                color: ProjectColors.black,
              )),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * double.infinity,
            height: MediaQuery.of(context).size.height * .99,
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
