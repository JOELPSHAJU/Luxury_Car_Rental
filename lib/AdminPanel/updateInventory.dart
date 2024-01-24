import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/AdminPanel/updateFieldPage.dart';
import 'package:luxurycars/AdminPanel/updateCarData.dart';
import 'package:luxurycars/Universaltools.dart';

class UpdateInventory extends StatefulWidget {
  const UpdateInventory({super.key});

  @override
  State<UpdateInventory> createState() => _UpdateInventoryState();
}

class _UpdateInventoryState extends State<UpdateInventory> {
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
            icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: ProjectColors.black),
        centerTitle: true,
        title: Text(
          'Update Inventory'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ProjectColors.black),
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
                                height:
                                    MediaQuery.of(context).size.height * .23,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                UpdateInventoryFields(
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
      ),
    );
  }
}
