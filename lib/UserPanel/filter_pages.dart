// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  fontstyle({required context}) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * .02,
        fontWeight: FontWeight.w500);
  }

  final sizedb = const SizedBox(
    height: 10,
  );

  static const List<String> filterdropdown = <String>[
    'Manual Transmission',
    'Automatic Transmission',
    'Automatic+Manual',
    'Price < ₹250000/-',
    'Price < ₹320000/-',
    'Fuel : Diesel',
    'Fuel : Petrol',
    'Fuel : Electric'
  ];
  String transmissiondropdownvalue = filterdropdown.first;

  Future<List<DocumentSnapshot>> _getDocuments(String name) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('cardetails');

    if (name == filterdropdown[0]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Transmission', isEqualTo: 'Manual').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[1]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Transmission', isEqualTo: 'Full Automatic')
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[2]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Transmission', isEqualTo: 'Automatic + Manual')
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[3]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Price Per Day', isLessThan: '250000').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[4]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Price Per Day', isLessThan: '320000').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[5]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Fuel Type', isEqualTo: 'Diesel').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[6]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Fuel Type', isEqualTo: 'Petrol').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[7]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Fuel Type', isEqualTo: 'Electric').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Company', isEqualTo: 'rr').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: ProjectColors.white,
          centerTitle: true,
          backgroundColor: ProjectColors.white,
          title: Text(
            'Find Your Specifications',
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * .05,
                color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 0, 0, 0),
              )),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 243, 243),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .091,
                color: ProjectColors.white,
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Filter',
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width * .6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                menuMaxHeight: 250,
                                style: GoogleFonts.oswald(
                                  fontWeight: FontWeight.w400,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ),
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 19,
                                value: transmissiondropdownvalue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    transmissiondropdownvalue = newValue!;
                                  });
                                },
                                items: filterdropdown
                                    .map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: _getDocuments(transmissiondropdownvalue),
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
                                'Oops,No Inventory Found In This Spec!',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 81, 81, 81),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 252, 252, 252),
                        ),
                        width:
                            MediaQuery.of(context).size.width * double.infinity,
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 229, 229, 229),
                                                spreadRadius: 2,
                                                blurRadius: 3,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  88, 163, 214, 232),
                                            ),
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .18,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .545,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .4,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .18,
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        88, 163, 214, 232),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15))),
                                              ),
                                            ),
                                            Positioned(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .5,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .18,
                                                child: CachedNetworkImage(
                                                  imageUrl: data['MainImage'],
                                                  placeholder: (context, url) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.black,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .45,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .18,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        data['Model Name']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: ProjectColors
                                                              .black,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .045,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      Text(
                                                        data['Company'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .032,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        'Category : ${data['Category']}',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              132, 132, 132),
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .032,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      Text(
                                                        '₹ ${data['Price Per Day']}/day',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: ProjectColors
                                                              .primarycolor1,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .035,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ))));
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
