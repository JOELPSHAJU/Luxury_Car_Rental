import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';


// ignore: must_be_immutable, camel_case_types
class addnotification extends StatelessWidget {
  addnotification({super.key});
  int b = 1;
  final rental = TextEditingController();

  final formkeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ProjectColors.primarycolor1,
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => notificationAdd(context: context),
          );
        },
        child: const Icon(
          Icons.notification_add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 23,
              color: ProjectColors.white,
            )),
        toolbarHeight: 40,
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'ADD NOTIFICATION',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .02,
              color: ProjectColors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 231, 231, 231),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            ProjectUtils().headingsmall(
                context: context,
                color: ProjectColors.primarycolor1,
                text: '<- Swipe To Delete ->'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('notification')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator()); // or any loading indicator
                  }

                  final clients = snapshot.data?.docs.reversed.toList();

                  return ListView.builder(
                    itemCount: clients!.length,
                    itemBuilder: (context, index) {
                      final client = clients[index];

                      return Dismissible(
                        key: Key(client.id),
                        onDismissed: (direction) {
                          FirebaseFirestore.instance
                              .collection('notification')
                              .doc(client.id)
                              .delete();
                        },
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                " ${client['note']}",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploaddata() async {
    Map<String, String> note = {
      "note": rental.text,
    };
    await DatabaseMethods().addnotification(note);
    rental.clear();
    // ignore: unused_element
    snackbars(BuildContext ctx) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        content: Text('Notification Added Sucessfully'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  notificationAdd({context}) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          content: Column(
            children: [
              ProjectUtils().headingsmall(
                  context: context,
                  color: ProjectColors.primarycolor1,
                  text: 'ADD NOTIFICATION'),
              const SizedBox(
                height: 10,
              ),
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
                        borderRadius: BorderRadius.circular(100),
                        color: ProjectColors.primarycolor1),
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .07,
                    child: Center(
                      child: Text(
                        'ADD Notification'.toUpperCase(),
                        style: TextStyle(
                            color: ProjectColors.white,
                            fontSize: MediaQuery.of(context).size.height * .02,
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
    );
  }
}
