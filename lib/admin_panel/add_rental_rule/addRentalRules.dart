// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

// ignore: must_be_immutable
class AddRentalRules extends StatelessWidget {
  AddRentalRules({super.key});
  int b = 1;
  final rental = TextEditingController();

  final formkeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ProjectUtils().warningMessage(
                    context: context,
                    text: 'Delete\nSwipe the particular message to delete!');
              },
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: ProjectColors.white)),
        toolbarHeight: 40,
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'ADD RENTAL RULES',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .02,
                  color: ProjectColors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('rentalrules')
                        .snapshots(),
                    builder: (context, snapshot) {
                      List<Widget> clientWidgets = [];
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: Lottie.asset(
                                        'assets/animations/offroad.json')),
                                Text(
                                  'No Rental Rules Found!',
                                  style: GoogleFonts.signikaNegative(
                                    fontSize:
                                        MediaQuery.of(context).size.width * .04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        final clients = snapshot.data?.docs.reversed.toList();
                        for (var client in clients!) {
                          clientWidgets.add(
                            Dismissible(
                              key: Key(client.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                FirebaseFirestore.instance
                                    .collection('rentalrules')
                                    .doc(client.id)
                                    .delete();
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.center,
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Deleting....',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.delete, color: Colors.white),
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          client['rule'],
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .018,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      return Expanded(
                        child: ListView(
                          children: clientWidgets,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => rentalruleadd(context: context),
          );
        },
        child: const Icon(
          Icons.add,
          weight: 7,
          size: 35,
          color: Colors.white,
        ),
        backgroundColor: ProjectColors.primarycolor1,
        shape: const CircleBorder(),
      ),
    );
  }

  uploaddata() async {
    Map<String, String> rentaldetail = {
      "rule": rental.text,
    };
    await DatabaseMethods().addRentalrules(rentaldetail);
    rental.clear();
    // ignore: unused_element
    snackbars(BuildContext ctx) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('Inventory Added Sucessfully'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  rentalruleadd({context}) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: ProjectColors.primarycolor1,
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Form(
                    key: formkeys,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: ProjectUtils().textformfieldaddnotification(
                              icon: Icons.notification_add,
                              controller: rental,
                              obsecure: false,
                              focusedcolor: Colors.black,
                              enabled: ProjectColors.primarycolor1,
                              iconcolor: ProjectColors.primarycolor1),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: () {
                    if (formkeys.currentState!.validate()) {
                      uploaddata();
                      Navigator.of(context).pop();
                    } else {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ProjectColors.white),
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .05,
                      child: Center(
                        child: Text(
                          'ADD'.toUpperCase(),
                          style: TextStyle(
                              color: ProjectColors.primarycolor1,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02,
                              fontWeight: FontWeight.bold),
                        ),
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
