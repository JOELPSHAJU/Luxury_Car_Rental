import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCarData extends StatelessWidget {
  final String documentid;
  const AllCarData({super.key, required this.documentid});

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
            return Text('Category:${cardata['Category']}');
          }
          return const Text('Loading......');
        }));
  }
}
