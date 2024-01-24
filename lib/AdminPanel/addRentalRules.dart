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

  final decorationTextFormField = InputDecoration(
    fillColor: const Color.fromARGB(255, 43, 0, 255),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
        borderRadius: BorderRadius.circular(0)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.deepOrange,
        ),
        borderRadius: BorderRadius.circular(0)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: const BorderSide(color: Colors.redAccent)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
  );
  final formkeys = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
            icon: Icon(Icons.arrow_back, color: ProjectColors.black)),
        toolbarHeight: 60,
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'ADD RENTAL RULES',
          style: TextStyle(
              fontSize: 20,
              color: ProjectColors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Form(
              key: formkeys,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: rental,
                        cursorColor: ProjectColors.primarycolor1,
                        style: TextStyle(color: ProjectColors.black),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Fill This Field !';
                          } else {
                            return null;
                          }
                        },
                        decoration: decorationTextFormField),
                  ),
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
                width: MediaQuery.of(context).size.width * .72,
                height: 55,
                child: Center(
                  child: Text(
                    'ADD RENTAL RULES',
                    style: TextStyle(
                        color: ProjectColors.black,
                        fontSize: 18,
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
                                      color: const Color.fromARGB(
                                          255, 219, 219, 219),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        '$b. ' + client['rule'],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
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
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
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
