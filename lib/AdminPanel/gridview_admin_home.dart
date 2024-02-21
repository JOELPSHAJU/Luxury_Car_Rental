// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_declarations, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:luxurycars/Universaltools.dart';

class Gridview_admin extends StatefulWidget {
  const Gridview_admin({super.key});

  @override
  State<Gridview_admin> createState() => _Gridview_adminState();
}

final textst = const TextStyle(
    fontWeight: FontWeight.w500, color: Color.fromARGB(255, 124, 124, 124));

class _Gridview_adminState extends State<Gridview_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 236, 236, 236),
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                'popular inventories',
              )
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Image.asset(
                            'assets/carTypes/placeholder7.png',
                            fit: BoxFit.cover,
                          )),
                      Text(
                        'No Popular Inventory Found!',
                        style: GoogleFonts.signikaNegative(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    String documentId = doc.id;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .48,
                        child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  width:
                                      MediaQuery.of(context).size.width * .47,
                                  child: CachedNetworkImage(
                                    imageUrl: doc['Image'],
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: ProjectColors.primarycolor1,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProjectUtils().headingsmall(
                                        context: context,
                                        color: ProjectColors.primarycolor1,
                                        text: '${doc['Company']}'),
                                    Text(
                                      'Category: ' + doc['Category'],
                                      style: textst,
                                    ),
                                    Text(
                                      'Price ₹' + doc['Price'] + '/-',
                                      style: textst,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
