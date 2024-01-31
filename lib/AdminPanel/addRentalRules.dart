import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/AdminPanel/homepage_admin.dart';
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
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: ProjectColors.white)),
        toolbarHeight: 40,
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'ADD RENTAL RULES',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .02,
              color: ProjectColors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Form(
                key: formkeys,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .07,
                        child: ProjectUtils().textformfield(
                            icon: Icons.star_border_outlined,
                            controller: rental,
                            obsecure: false,
                            focusedcolor: ProjectColors.primarycolor1,
                            enabled: Colors.grey,
                            iconcolor: ProjectColors.primarycolor1),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                if (formkeys.currentState!.validate()) {
                  uploaddata();
                } else {}
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: ProjectColors.primarycolor1,
                      borderRadius: BorderRadius.circular(10)),
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .06,
                  child: Center(
                    child: Text(
                      'ADD RENTAL RULE',
                      style: TextStyle(
                          color: ProjectColors.white,
                          fontSize: MediaQuery.of(context).size.height * .02,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('rentalrules')
                          .snapshots(),
                      builder: (context, snapshot) {
                        List<Row> clientwidgets = [];
                        if (snapshot.hasData) {
                          final clients = snapshot.data?.docs.reversed.toList();
                          for (var client in clients!) {
                            final clientwidget = Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          .8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          client['rule'],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .018,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                ),
                                IconButton(
                                  onPressed: () {
                                    final docId = client.id;
                                    FirebaseFirestore.instance
                                        .collection('rentalrules')
                                        .doc(docId)
                                        .delete();
                                  },
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                )
                              ],
                            );
                            clientwidgets.add(clientwidget);
                            b++;
                          }
                        }
                        return Expanded(
                            child: ListView(
                          children: clientwidgets,
                        ));
                      })
                ],
              ),
            ),
          ],
        ),
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
}
