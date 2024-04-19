// ignore_for_file: avoid_print

import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';
import 'package:luxurycars/authentication/forget_password/forget_password.dart';

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
    'Price < ₹ 1 lakh',
    'Price < ₹ 3 lakhs',
    'Fuel : Diesel',
    'Fuel : Petrol',
    'Fuel : Electric',
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
            await usersRef.where('Price Per Day', isLessThan: '100000').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[4]) {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Price Per Day', isLessThan: '300000').get();
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
      QuerySnapshot querySnapshot = await usersRef.get();
      return querySnapshot.docs;
    }
  }

  String title = 'GO DRIVE';
  bool customExpanded = false;
  int selectedindex = 0;
  final selectedColor = const Color.fromARGB(255, 12, 160, 168);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 50,
          title: Text(
            title,
            style: GoogleFonts.roboto(
                color: maincolor, fontWeight: FontWeight.w500),
          ),
          surfaceTintColor: const Color.fromARGB(255, 96, 96, 96),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 5,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                    color: Color.fromARGB(255, 106, 106, 106)),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 241, 241, 241),
                ),
              )),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 239, 239, 239),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExpansionTile(
                title: Text(
                  'Please Select Your Specification',
                  style: GoogleFonts.poppins(),
                ),
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 0;
                                    transmissiondropdownvalue =
                                        filterdropdown[0];
                                    title = filterdropdown[0];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .45,
                                  decoration: selectedindex == 0
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[0],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 0
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 1;
                                    transmissiondropdownvalue =
                                        filterdropdown[1];
                                    title = filterdropdown[1];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .5,
                                  decoration: selectedindex == 1
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[1],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 1
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[2];
                                    selectedindex = 2;
                                    transmissiondropdownvalue =
                                        filterdropdown[2];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .45,
                                  decoration: selectedindex == 2
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[2],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 2
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[3];
                                    selectedindex = 3;
                                    transmissiondropdownvalue =
                                        filterdropdown[3];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .5,
                                  decoration: selectedindex == 3
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[3],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 3
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[4];
                                    selectedindex = 4;
                                    transmissiondropdownvalue =
                                        filterdropdown[4];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .45,
                                  decoration: selectedindex == 4
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[4],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 4
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[5];
                                    selectedindex = 5;
                                    transmissiondropdownvalue =
                                        filterdropdown[5];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .5,
                                  decoration: selectedindex == 5
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[5],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 5
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[6];
                                    selectedindex = 6;
                                    transmissiondropdownvalue =
                                        filterdropdown[6];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .45,
                                  decoration: selectedindex == 6
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[6],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 6
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    title = filterdropdown[7];
                                    selectedindex = 7;
                                    transmissiondropdownvalue =
                                        filterdropdown[7];
                                  });
                                },
                                child: Container(
                                  height: 45,
                                  width: size.width * .5,
                                  decoration: selectedindex == 7
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedColor)
                                      : BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1.2, color: Colors.black)),
                                  child: Center(
                                      child: Text(
                                    filterdropdown[7],
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: selectedindex == 7
                                            ? Colors.white
                                            : Colors.black),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    customExpanded = expanded;
                  });
                },
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
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10, bottom: 10),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 250,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                colors: [
                                              Color.fromARGB(31, 86, 86, 86),
                                              Color.fromARGB(
                                                  115, 255, 255, 255),
                                              Colors.black12,
                                            ])),
                                      ),
                                      Positioned(
                                        top: 200,
                                        left: 10,
                                        child: SizedBox(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .9,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0))),
                                                child: Center(
                                                  child: RowSearch(
                                                    image:
                                                        'assets/carTypes/engine.png',
                                                    Texts:
                                                        ' ${data['Maximum Power']}',
                                                    last: 'hp',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  height: 40,
                                                  width: 110,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0))),
                                                  child: Center(
                                                      child: RowSearch(
                                                          image:
                                                              'assets/carTypes/seat.png',
                                                          last: 'Person',
                                                          Texts:
                                                              '  ${data['Seating Capacity']}'))),
                                              Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0))),
                                                  child: Center(
                                                    child: RowSearch(
                                                      last: '',
                                                      image:
                                                          'assets/carTypes/fuel.png',
                                                      Texts:
                                                          '${data['Fuel Type']}',
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -45,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .03,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .18,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
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
                                            )),
                                      ),
                                      Positioned(
                                        top: -48,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .18,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "₹ ${data['Price Per Day']}/day",
                                                  style: GoogleFonts.robotoFlex(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Positioned(
                                        top: -19,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .02,
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .18,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BorderedText(
                                                  strokeWidth: 2,
                                                  strokeColor: Color.fromARGB(
                                                      154, 12, 160, 168),
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    data['Model Name']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style:
                                                        GoogleFonts.robotoFlex(
                                                      color: Colors.transparent,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .08,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      Positioned(
                                        top: -5,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          child: CachedNetworkImage(
                                            imageUrl: '${data['MainImage']}',
                                            placeholder: (context, url) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
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

class RowSearch extends StatelessWidget {
  final String image;
  final String last;
  final String Texts;
  const RowSearch(
      {super.key,
      required this.image,
      required this.last,
      required this.Texts});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          '$image',
          color: const Color.fromARGB(255, 0, 0, 0),
          width: MediaQuery.of(context).size.width * .07,
        ),
        Text(
          '${Texts.toString().toUpperCase()} $last',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
