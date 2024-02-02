import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * .023,
              color: Colors.white),
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
                    Lottie.asset(
                      'assets/animations/Animation - 1706182910823.json',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      'Oops,No Car Found For This Brand',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 81, 81, 81),
                      ),
                    ),
                  ],
                ),
              );
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
                          height: MediaQuery.of(context).size.width * .37,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 225, 225, 225),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .44,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: data['MainImage'],
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                      color: ProjectColors.primarycolor1,
                                    )),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data['Company']}\n${data['Model Name']}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .017,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Category : ${data['Category']}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .016,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Price : ${data['Price Per Day']}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .016,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Fuel Type : ${data['Fuel Type']}',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .016,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
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
