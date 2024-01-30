import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                        width: MediaQuery.of(context).size.width * .27,
                        height: MediaQuery.of(context).size.width * .27,
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
                                color: ProjectColors.primarycolor1),
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
                                color: ProjectColors.primarycolor1),
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
                                color: ProjectColors.primarycolor1),
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
