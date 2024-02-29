import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/AdminPanel/updateFieldPage.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class BookingsDone extends StatefulWidget {
  const BookingsDone({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingsDoneState createState() => _BookingsDoneState();
}

class _BookingsDoneState extends State<BookingsDone> {
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
                                child: data['Confirmation'] == 'SUCESSFUL'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            // ignore: prefer_adjacent_string_concatenation
                                            'Status : ' +
                                                '${data['Confirmation']}',
                                            style: GoogleFonts.oswald(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .019,
                                                fontWeight: FontWeight.w500,
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
                                            style: GoogleFonts.gowunBatang(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .019,
                                                color: ProjectColors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          sizedboc,
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .04,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      scrollable: true,
                                                      title: Center(
                                                          child: Text(
                                                        "Order Successful",
                                                        style:
                                                            GoogleFonts.oswald(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        147,
                                                                        47)),
                                                      )),
                                                      content: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                data['Image'],
                                                            placeholder:
                                                                (context, url) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            },
                                                          ),
                                                          Text(
                                                            '${data['company']} ${data['model']}',
                                                            style: GoogleFonts.oswald(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                color: ProjectColors
                                                                    .primarycolor1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Divider(),
                                                          Text(
                                                            'Category ',
                                                            style: GoogleFonts.signikaNegative(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '${data['category']}',
                                                            style: GoogleFonts.gowunBatang(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Divider(),
                                                          Text(
                                                            'Pickup Date',
                                                            style: GoogleFonts.signikaNegative(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Pickupdate']))}',
                                                            style: GoogleFonts.gowunBatang(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Divider(),
                                                          Text(
                                                            'Dropoff Date',
                                                            style: GoogleFonts.signikaNegative(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Dropoffdate']))}',
                                                            style: GoogleFonts.gowunBatang(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Divider(),
                                                          Text(
                                                            'Amount To Be Paid',
                                                            style: GoogleFonts.signikaNegative(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '₹ ${data['Totalamount']}/-',
                                                            style: GoogleFonts.gowunBatang(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Divider(),
                                                          Text(
                                                            'Pickup Location',
                                                            style: GoogleFonts.signikaNegative(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            'Go Drive\nEttumanoor-Ernakulam Road,Vyttila\nNear Tony&Guy 682019',
                                                            style: GoogleFonts.gowunBatang(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    .019,
                                                                color:
                                                                    ProjectColors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Divider(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            8.0),
                                                                child: Text(
                                                                  '- GO DRIVE -',
                                                                  style: GoogleFonts
                                                                      .oswald(),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      actions: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .04,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                3),
                                                                    side: BorderSide(
                                                                        color: ProjectColors
                                                                            .primarycolor1)),
                                                                backgroundColor:
                                                                    ProjectColors
                                                                        .primarycolor1,
                                                                elevation: 0),
                                                            child: Text(
                                                              'Back',
                                                              style: GoogleFonts.oswald(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  elevation: 0),
                                              child: Text(
                                                'Details',
                                                style: GoogleFonts.gowunBatang(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // ignore: prefer_adjacent_string_concatenation
                                            'Status : ' +
                                                '${data['Confirmation']}',
                                            style: GoogleFonts.oswald(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .019,
                                                fontWeight: FontWeight.w500,
                                                color: data['Confirmation'] ==
                                                        'SUCESSFUL'
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                          sizedboc,
                                          Text(
                                            '${data['company']}',
                                            style: GoogleFonts.gowunBatang(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .019,
                                                color: ProjectColors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          sizedboc,
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .04,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      scrollable: true,
                                                      title: Center(
                                                          child: Text(
                                                        "Order Failed",
                                                        style: GoogleFonts.oswald(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                181, 18, 7)),
                                                      )),
                                                      content: Column(
                                                        children: [
                                                          CachedNetworkImage(
                                                            imageUrl:
                                                                data['Image'],
                                                            placeholder:
                                                                (context, url) {
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            },
                                                          ),
                                                          Text(
                                                            '''The ${data['company']} ${data['model']} You Requested To Rent From ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Pickupdate']))} to  ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Dropoffdate']))} Is Unavailable! Sorry For The Inconvenience Caused!''',
                                                            style: GoogleFonts
                                                                .gowunBatang(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            8.0),
                                                                child: Text(
                                                                  '- GO DRIVE -',
                                                                  style: GoogleFonts
                                                                      .oswald(),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      actions: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .04,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                3),
                                                                    side: BorderSide(
                                                                        color: ProjectColors
                                                                            .primarycolor1)),
                                                                backgroundColor:
                                                                    ProjectColors
                                                                        .primarycolor1,
                                                                elevation: 0),
                                                            child: Text(
                                                              'Back',
                                                              style: GoogleFonts.oswald(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  elevation: 0),
                                              child: Text(
                                                'Details',
                                                style: GoogleFonts.gowunBatang(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255)),
                                              ),
                                            ),
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
