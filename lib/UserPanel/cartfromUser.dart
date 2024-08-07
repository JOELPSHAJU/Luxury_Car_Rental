// ignore_for_file: avoid_print

import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class AddtoCartUser extends StatefulWidget {
  const AddtoCartUser({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddtoCartUserState createState() => _AddtoCartUserState();
}

class _AddtoCartUserState extends State<AddtoCartUser> {
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Cart',
            style: GoogleFonts.oswald(color: Colors.white),
          ),
        ),
        extendBody: true,
        body: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 223, 223, 223)),
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
                                    Container(
                                        height: 260,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    Positioned(
                                      top: 10,
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  data['Company']
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: GoogleFonts.robotoFlex(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  '₹${data['Priceperday'].toString().toUpperCase()}/day',
                                                  style: GoogleFonts.robotoFlex(
                                                    color: Colors.green,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 40,
                                      left: 10,
                                      child: BorderedText(
                                        strokeWidth: 2,
                                        strokeColor:
                                            Color.fromARGB(154, 0, 0, 0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          data['Model Name']
                                              .toString()
                                              .toUpperCase(),
                                          style: GoogleFonts.robotoFlex(
                                            color: Colors.transparent,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .08,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: CachedNetworkImage(
                                          imageUrl: "${data['Image']}",
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        )),
                                    Positioned(
                                      bottom: 10,
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                DatabaseMethods()
                                                    .deletecartitem(docid);
                                                setState(() {});
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Center(
                                                    child: Text(
                                                  'Remove',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                )),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            ParticularInventory(
                                                              id: data['Id'],
                                                            )));
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Center(
                                                    child: Text(
                                                  'View Inventory',
                                                  style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
