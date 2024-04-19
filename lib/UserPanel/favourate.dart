// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        FirebaseFirestore.instance.collection('favourites');

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
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
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
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8,
                          top: 10,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromARGB(31, 86, 86, 86),
                                    Color.fromARGB(115, 255, 255, 255),
                                    Colors.black12,
                                  ]),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 204, 204, 204)),
                              color: ProjectUtils().listcolor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 45,
                                      left: 20,
                                      child: Text(
                                        data['Model Name']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .06,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Positioned(
                                      top: 15,
                                      right: 15,
                                      child: Text(
                                        "₹${data['Priceperday']}/day",
                                        style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .05,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      left: 20,
                                      child: Text(
                                        data['Company']
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .033,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CachedNetworkImage(
                                          imageUrl: "${data['Image']}",
                                          height: 150,
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        DatabaseMethods().deletecartitem(docid);
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(9))),
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .47,
                                        child: Center(
                                          child: Text(
                                            'Remove',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 255, 0, 0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    ParticularInventory(
                                                      id: data['Id'],
                                                      cart: 'cart',
                                                    )));
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(9))),
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .47,
                                        child: Center(
                                            child: Text('View Inventory',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0)))),
                                      ),
                                    ),
                                  ],
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
