import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Universaltools.dart';

class ViewRental extends StatelessWidget {
  ViewRental({super.key});
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'RENTAL RULES',
          style: TextStyle(
              fontSize: 20,
              color: ProjectColors.black,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ProjectColors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            }),
      ),
      body: Container(
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
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 212, 212, 212)),
                                width: MediaQuery.of(context).size.width * .93,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$a. ' + client['rule'],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ],
                      );
                      clientwidgets.add(clientwidget);
                      a++;
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
    );
  }
}
