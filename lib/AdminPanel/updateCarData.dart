import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/UserPanel/booking_page.dart';

class UpdatecarData extends StatelessWidget {
  final String documentid;
  UpdatecarData({required this.documentid});
  final cardetailsdata = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference cars =
        FirebaseFirestore.instance.collection('cardetails');
    return FutureBuilder<DocumentSnapshot>(
        future: cars.doc(documentid).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> cardata =
                snapshot.data!.data() as Map<String, dynamic>;

            return Container(
                height: MediaQuery.of(context).size.height * .23,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
                                image:
                                    NetworkImage('${cardata['Image Urls'][1]}'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${cardata['Company']}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${cardata['Model Name']}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Category : ${cardata['Category']}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Price : ${cardata['Price Per Day'].toString()}',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          }
          return const Text('Loading......');
        }));
  }
}
