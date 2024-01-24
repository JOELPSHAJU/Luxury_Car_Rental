import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';

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
                child: Image.asset(
              'assets/bg/null2.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * .3,
            ));
          }
        },
        stream: advertisementsReference.snapshots(),
      ),
    );
  }
}
