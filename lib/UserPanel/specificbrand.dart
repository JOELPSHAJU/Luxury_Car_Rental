import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          await usersRef.where('Category', isEqualTo: name).get();
      return querySnapshot.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(.5),
        title: Text(
          name.toUpperCase(),
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * .023,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 0, 0, 0),
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
                      'Oops,No Car Found In This Category!',
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
              color: Colors.grey[100],
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ParticularInventory(
                                  id: documentId,
                                )));
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: double.infinity,
                              height: 230,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BorderedText(
                                    child: Text(
                                      data['Model Name']
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 44, color: Colors.white),
                                    ),
                                    strokeWidth: 3,
                                    strokeColor: Colors.grey,
                                  ),
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    child: Image.network(
                                      'https://www.pngmart.com/files/22/Dodge-Challenger-PNG-HD-Isolated.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ))));
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

  List<String> imag = [
    'https://www.pngmart.com/files/22/Dodge-Challenger-PNG-HD-Isolated.png',
    'https://platform.cstatic-images.com/xlarge/in/v2/stock_photos/98a1a282-0c8c-470b-aa27-12fd795953d3/a4c7a3ee-ea47-4ab9-958d-2cfdfa2e6953.png',
  ];
}
