import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

class UpdatecarData extends StatelessWidget {
  final String documentid;
  UpdatecarData({super.key, required this.documentid});
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
                height: MediaQuery.of(context).size.height * .2,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .4,
                        height: MediaQuery.of(context).size.height * .15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: '${cardata['MainImage']}',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: ProjectColors.primarycolor1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${cardata['Company']}',
                              style: GoogleFonts.signikaNegative(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  fontWeight: FontWeight.w500,
                                  color: ProjectColors.primarycolor1),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${cardata['Model Name']}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  fontWeight: FontWeight.w500,
                                  color: ProjectColors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Category : ${cardata['Category']}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  fontWeight: FontWeight.w500,
                                  color: ProjectColors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Price : ${cardata['Price Per Day'].toString()}',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * .02,
                                  fontWeight: FontWeight.w500,
                                  color: ProjectColors.black),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }
          return const Text('Loading......');
        }));
  }
}
