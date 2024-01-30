// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/cartdetails.dart';

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
          color: const Color.fromARGB(255, 239, 239, 239),
          child: FutureBuilder<List<DocumentSnapshot>>(
            future: _getDocuments(email.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> documents = snapshot.data!;

                if (documents.isEmpty) {
                  return Center(
                    child: Stack(
                      children: [
                        Lottie.asset(
                          'assets/animations/Animation - 1706182910823.json',
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          bottom: 30.0,
                          left: 100.0,
                          child: Center(
                            child: Text(
                              'Oops,Your Cart Is Empty!',
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * .04,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 81, 81, 81),
                              ),
                            ),
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
                            builder: (ctx) => CartDetails(id: data['Id'])));
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
                                    width: 130,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${data['Image']}'),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Padding(
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
                                                .019,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 8,
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
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Price : ₹${data['Priceperday']}/-',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .016,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          DatabaseMethods()
                                              .deletecartitem(docid);

                                          setState(() {});
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                3), // <-- Radius
                                          ),
                                          backgroundColor: Color.fromARGB(
                                              255, 211, 211, 211),
                                        ),
                                        child: const Text(
                                          'Remove From Cart',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 12, 12, 12)),
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
