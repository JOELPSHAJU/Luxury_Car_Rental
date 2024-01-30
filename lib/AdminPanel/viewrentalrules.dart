import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';

class ViewRental extends StatelessWidget {
  ViewRental({super.key});
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'RENTAL RULES',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .02,
              color: ProjectColors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ProjectColors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: const Color.fromARGB(255, 235, 235, 235),
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
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                width: MediaQuery.of(context).size.width * .93,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$a. ' + client['rule'],
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .02,
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
