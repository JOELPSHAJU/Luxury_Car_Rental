// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class AddtoCart extends StatefulWidget {
  const AddtoCart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddtoCartState createState() => _AddtoCartState();
}

class _AddtoCartState extends State<AddtoCart> {
  Future<List<DocumentSnapshot>> _getDocuments(String email) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('addtocart');

    try {
      QuerySnapshot querySnapshot =
          await usersRef.where('email', isEqualTo: email).get();
      return querySnapshot.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<String>> getDocumentIds(String email) async {
    try {
      List<DocumentSnapshot> documents = await _getDocuments(email);
      List<String> documentIds = documents.map((doc) => doc.id).toList();
      return documentIds;
    } catch (e) {
      print(e);
      return [];
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 239),
          ),
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: _getDocuments(email.toString()),
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
                          'Oops,Your Cart Is Empty!',
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
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;
                    final docid = (documents[index].id);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ParticularInventory(
                                  id: data['Id'],
                                  cart: 'cart',
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: ProjectUtils().listcolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    height: MediaQuery.of(context).size.height *
                                        .13,
                                    child: CachedNetworkImage(
                                      imageUrl: "${data['Image']}",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error,
                                              color: Colors.grey, size: 30),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['Model Name']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.oswald(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .035,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        data['Company']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.oswald(
                                            color: Colors.grey,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .04,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3.0, bottom: 3),
                                        child: Text(
                                          'Price : ₹${data['Priceperday']}/-',
                                          style: GoogleFonts.oswald(
                                              color:
                                                  ProjectColors.primarycolor1,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .034,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .04,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            DatabaseMethods()
                                                .deletecartitem(docid);

                                            setState(() {});
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  side: BorderSide(
                                                      color: ProjectColors
                                                          .primarycolor1) // <-- Radius
                                                  ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              elevation: 0),
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 12, 12, 12)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
