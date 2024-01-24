import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/AdminPanel/OntapViewInventory.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/AdminPanel/updateCarData.dart';
import 'package:luxurycars/Universaltools.dart';

class ViewInventories extends StatefulWidget {
  const ViewInventories({super.key});

  @override
  State<ViewInventories> createState() => _ViewInventoriesState();
}

class _ViewInventoriesState extends State<ViewInventories> {
  @override
  Widget build(BuildContext context) {
    List<String> docIDs = [];
    Future getDocId() async {
      await FirebaseFirestore.instance
          .collection('cardetails')
          .get()
          .then((snapshot) => snapshot.docs.forEach((document) {
                print(document.reference);
                docIDs.add(document.reference.id);
              }));
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: ProjectColors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
          ),
          centerTitle: true,
          title: Text(
            'VIEW Inventories'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ProjectColors.white),
          ),
          backgroundColor: ProjectColors.primarycolor1,
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 235, 235, 235),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ViewSingleInventory(
                                                      id: docIDs[index])));
                                    },
                                    child: UpdatecarData(
                                      documentid: docIDs[index],
                                    ),
                                  )));
                        },
                      );
                    }))
          ],
        ));
  }
}
