import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';
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
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, bottom: 15, top: 8),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 154, 154, 154).withOpacity(0.4),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(0),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['Company'],
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                data['Model Name'],
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹ ${data['Price']}",
                                style: GoogleFonts.roboto(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hour',
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width * .8,
                      child: CachedNetworkImage(
                        imageUrl: '${data['Image']}',
                        fit: BoxFit.fitHeight,
                        placeholder: (context, url) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text(
                            'GO DRIVE',
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => ParticularInventory(
                                      id: data['Id'],
                                    )));
                          },
                          child: Container(
                            height: 40,
                            width: 190,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 149, 121, 121),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Check Out',
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList();
          return CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .32,
              aspectRatio: 6 / 3,
              enableInfiniteScroll: true,
              viewportFraction: 0.9,
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
