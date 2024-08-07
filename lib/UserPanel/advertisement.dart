import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';

class Advertisement extends StatelessWidget {
  Advertisement({Key? key}) : super(key: key);

  final CollectionReference advertisementsReference =
      FirebaseFirestore.instance.collection('advertisements');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: advertisementsReference.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                color: ProjectUtils().primarycolor,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return CarouselSlider.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index, realIndex) {
              final doc = snapshot.data!.docs[index];
              final imageUrl = doc.get('image') as String;
              return CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: ProjectColors.primarycolor1,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.grey,
                  size: 30,
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              reverse: true,
              autoPlayInterval: const Duration(seconds: 7),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: const Center(
              child: Text('Internet Connection Interupted'),
            ),
          );
        }
      },
    );
  }
}
