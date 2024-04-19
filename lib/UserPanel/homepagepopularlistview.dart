import 'package:bordered_text/bordered_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

// ignore: camel_case_types
class popularinventories extends StatefulWidget {
  popularinventories({Key? key}) : super(key: key);

  @override
  State<popularinventories> createState() => _popularinventoriesState();
}

class _popularinventoriesState extends State<popularinventories> {
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    advertisementsReference =
        FirebaseFirestore.instance.collection('popular inventories');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Widget> imageSliders = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .16,
                      child: CachedNetworkImage(
                        imageUrl: data['Image'],
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    sizedboc,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${data['Company']}',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' ${data['Model Name']}',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    sizedboc,
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * .32,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/carTypes/engine.png',
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                    ),
                                    Text(
                                      ' ${data['maxpower'].toString().toUpperCase()} hp',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * .32,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/carTypes/seat.png',
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                    ),
                                    Text(
                                      ' ${data['seats'].toString().toUpperCase()} Person',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * .32,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/carTypes/turbo.png',
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                    ),
                                    Text(
                                      ' ${data['maxtorque'].toString().toUpperCase()} nm',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width * .32,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/carTypes/fuel.jpeg',
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                    ),
                                    Text(
                                      ' ${data['fuel']}',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ParticularInventory(
                                        id: data['Id'],
                                      )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ProjectColors.primarycolor1,
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width * .5,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rent Now  ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'GO',
                                style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'DRIVE',
                                style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '₹ ${data['Price']}/day',
                            style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 25, 77, 27)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList();
          return CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .53,
              aspectRatio: 10 / 10,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.7,
              onPageChanged: (index, reason) {
                setState(() {});
              },
            ),
            items: imageSliders,
          );
        } else {
          return Center(
            child: Text(
              'Check Your Internet Connection',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          );
        }
      },
      stream: advertisementsReference.snapshots(),
    );
  }
}
