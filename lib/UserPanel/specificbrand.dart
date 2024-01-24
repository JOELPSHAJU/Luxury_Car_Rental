import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class SpecificBrand extends StatelessWidget {
  final String name;
  SpecificBrand({super.key, required this.name});
  Future<List<DocumentSnapshot>> _getDocuments(String name) async {
    print(name);
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('cardetails');

    try {
      QuerySnapshot querySnapshot =
          await usersRef.where('Company', isEqualTo: name).get();
      return querySnapshot.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _getDocuments(name),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!;
            if (documents.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/bg/Screenshot 2024-01-11 193510-PhotoRoom.png-PhotoRoom.png',
                    width: MediaQuery.of(context).size.width * .5,
                  ),
                  Text(
                    'Oops,No Inventory Found For This Brand!',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 81, 81, 81)),
                  )
                ],
              ));
            }

            return Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * double.infinity,
              height: MediaQuery.of(context).size.height * .99,
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = documents[index];
                  String documentId = document.id;
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx) => ParticularInventory(
                                id: documentId,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 165,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 225, 225, 225),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              data['Image Urls'][0]),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data['Company']}\n${data['Model Name']}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Category : ${data['Category']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Price : ${data['Priceperday']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Fuel Type : ${data['Fuel Type']}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
