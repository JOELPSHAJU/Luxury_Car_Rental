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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          name.toUpperCase(),
          style: GoogleFonts.oswald(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.height * .023,
            color: Color.fromARGB(255, 150, 94, 94),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color.fromARGB(255, 150, 94, 94),
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
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .18,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 229, 229, 229),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Color.fromARGB(255, 209, 185, 185),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * .61,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .35,
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 209, 185, 185),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * .43,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .5,
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                child: CachedNetworkImage(
                                  imageUrl: data['MainImage'],
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * .02,
                              child: Container(
                                  width: MediaQuery.of(context).size.width * .5,
                                  height:
                                      MediaQuery.of(context).size.height * .18,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        data['Model Name']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: ProjectColors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .045,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        data['Company'],
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .032,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Category : ${data['Category']}',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              255, 132, 132, 132),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .032,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '₹ ${data['Price Per Day']}/day',
                                        style: GoogleFonts.poppins(
                                          color:
                                              Color.fromARGB(255, 142, 82, 82),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .035,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        )),
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
