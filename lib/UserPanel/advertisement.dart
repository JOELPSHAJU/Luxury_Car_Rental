import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';

class Advertisement extends StatefulWidget {
  Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    advertisementsReference =
        FirebaseFirestore.instance.collection('advertisements');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/homepageplaceholder.jpg'))),
      child: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              items: snapshot.data!.docs
                  .map((doc) => Container(
                        width:
                            MediaQuery.of(context).size.width * double.infinity,
                        child: Image.network(
                          doc.get(
                            'image',
                          ) as String,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: ProjectUtils().primarycolor,
              ),
            );
          }
        },
        stream: advertisementsReference.snapshots(),
      ),
    );
  }
}
