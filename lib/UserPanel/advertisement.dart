import 'package:cached_network_image/cached_network_image.dart';
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
      child: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              items: snapshot.data!.docs
                  .map((doc) => SizedBox(
                        width:
                            MediaQuery.of(context).size.width * double.infinity,
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            color: ProjectColors.primarycolor1,
                          )),
                          errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.grey,
                              size: 30),
                          imageUrl: doc.get(
                            'image',
                          ) as String,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                reverse: true,
                autoPlayInterval: const Duration(seconds: 7),
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
