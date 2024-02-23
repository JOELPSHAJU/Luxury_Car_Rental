import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/Universaltools.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  Future<List<DocumentSnapshot>> _getDocuments(String email) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('requestreply');

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
                          width: MediaQuery.of(context).size.width * 5,
                        ),
                        Text(
                          'No Bookings Yet!',
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

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 154, 154, 154)
                                      .withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
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
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '${data['Image']}',
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: ProjectColors.primarycolor1,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      // ignore: prefer_adjacent_string_concatenation
                                      'Status : ' + '${data['Confirmation']}',
                                      style: GoogleFonts.oswald(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .019,
                                          fontWeight: FontWeight.bold,
                                          color: data['Confirmation'] ==
                                                  'SUCESSFUL'
                                              ? Colors.green
                                              : Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${data['company']}',
                                      style: GoogleFonts.carlito(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .019,
                                          color: ProjectColors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Category : ${data['category']}',
                                      style: GoogleFonts.carlito(
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .019,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      'Total Amount : ${data['Totalamount']}',
                                      style: GoogleFonts.carlito(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .019,
                                          fontWeight: FontWeight.w600,
                                          color: ProjectColors.primarycolor1),
                                    ),
                                    Text(
                                      'Pickup Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Pickupdate']))}',
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .017,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      'Dropoff Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Dropoffdate']))}',
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .017,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
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
