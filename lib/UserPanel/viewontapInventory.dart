import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/booking_page.dart';
import 'package:luxurycars/UserPanel/ontapdetails.dart';

// ignore: must_be_immutable
class ParticularInventory extends StatefulWidget {
  String id;
  ParticularInventory({super.key, required this.id, cart});

  @override
  State<ParticularInventory> createState() => _ParticularInventoryState();
}

class _ParticularInventoryState extends State<ParticularInventory> {
  final String collectionName = 'cardetails';

  Widget details({required label, required data, required addons}) {
    return Row(
      children: [
        const Icon(
          Icons.circle_rounded,
          size: 15,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        Text(
          '  $label : ',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 94, 94, 94)),
        ),
        Text(
          '$data $addons',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 0, 0, 0)),
        )
      ],
    );
  }

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;

  final onpresscolor = ProjectColors.primarycolor1;

  bool onpress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        leading: Center(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ProjectColors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        toolbarHeight: 39,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/new/fa9a2abfad578ca9b66fb2841a675270.jpg'),
                opacity: .2)),
        child: Center(
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection(collectionName)
                .doc(widget.id)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error fetching data: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.done) {
                DocumentSnapshot<Map<String, dynamic>> docSnapshot =
                    snapshot.data!;
                if (docSnapshot.exists) {
                  Map<String, dynamic> data = docSnapshot.data()!;
                  String docsid = widget.id;
                  String company = data['Company'];
                  String category = data['Category'];
                  String modelname = data['Model Name'];
                  String numberplate = data['Number Plate'];
                  String engine = data['Engine Displacement'];
                  String fueltank = data['Fuel Tank Capacity'];
                  String fueltype = data['Fuel Type'];
                  String gearbox = data['Gearbox'];
                  String groundclearence = data['Ground Clearence'];
                  List<dynamic> images = data['Image Urls'];
                  String maxpower = data['Maximum Power'];
                  String maxtorque = data['Maximum Torque'];
                  String mainimage = data['MainImage'];
                  String overview = data['Overview'];
                  String price = data['Price Per Day'];
                  String seatingcapacity = data['Seating Capacity'];
                  String transmission = data['Transmission'];
                  String zerotohundred = data['Zero To Hundred'];
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            height: MediaQuery.of(context).size.height * 0.29,
                            width: double.infinity,
                            child: FractionallySizedBox(
                              heightFactor: 95.0,
                              child: CarouselSlider(
                                items: images.map((url) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: CachedNetworkImage(
                                      imageUrl: url,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(
                                          color: ProjectColors.primarycolor1,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  autoPlay: true,
                                  aspectRatio: 19 / 12,
                                  enableInfiniteScroll: true,
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          SizedBox(
                            height: 62,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('$company \n$modelname',
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .045,
                                          color: ProjectColors.secondarycolor2,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'from',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .037,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // ignore: prefer_adjacent_string_concatenation, unnecessary_string_interpolations
                                          Text('₹' + '$price',
                                              style: GoogleFonts.outfit(
                                                  color: ProjectColors
                                                      .primarycolor1,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .06,
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            ' / day',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .037,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .2,
                                height: MediaQuery.of(context).size.height * .1,
                                child: Image.asset(
                                  'assets/new/images.png',
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .99,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Overview',
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .045,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              ProjectColors.secondarycolor2)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Text(overview,
                                        style: GoogleFonts.gowunBatang(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .037,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/new/company ad.jpg',
                                      ),
                                      fit: BoxFit.cover)),
                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Technical Specification',
                                    style: GoogleFonts.signikaNegative(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .045,
                                        fontWeight: FontWeight.w600,
                                        color: ProjectColors.secondarycolor2)),
                              ],
                            ),
                          ),
                          OntapDetails(
                              engine: engine,
                              power: maxpower,
                              torque: maxtorque,
                              transmission: transmission,
                              gearbox: gearbox,
                              zero: zerotohundred,
                              fuelty: fueltype,
                              fueltank: fueltank,
                              seating: seatingcapacity,
                              ground: groundclearence,
                              category: category),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .08,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> car = {
                                      "Id": docsid,
                                      "Image": mainimage,
                                      "Company": company,
                                      "Category": category,
                                      "Model Name": modelname,
                                      "Priceperday": price,
                                      "email": email,
                                    };
                                    DatabaseMethods().addtocart(car);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            duration:
                                                const Duration(seconds: 2),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 255, 255, 255),
                                            behavior: SnackBarBehavior.floating,
                                            content: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .1,
                                              child: Center(
                                                child: LottieBuilder.asset(
                                                  'assets/animations/cartadded.json',
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            )));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: Center(
                                      child: ProjectUtils().headingsmall(
                                          context: context,
                                          color: ProjectColors.primarycolor1,
                                          text: 'Add to Cart'),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Map<String, dynamic> car = {
                                      'Company': company,
                                      'Category': category,
                                      'PricePerDay': price,
                                      'Gearbox': gearbox,
                                      'Engine': engine,
                                      'Transmission': transmission,
                                      'Fuel Type': fueltype,
                                      'Fuel Tank': fueltank,
                                      'Ground Clearence': groundclearence,
                                      'MaxTorque': maxtorque,
                                      'MaxPower': maxpower,
                                      'Seating': seatingcapacity,
                                      'Zero': zerotohundred,
                                      'image': mainimage,
                                      'model': modelname,
                                      'numberplate': numberplate,
                                      'docsid': widget.id
                                    };
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (ctx) => BookingPage(
                                                  data: car,
                                                )));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .08,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    color: ProjectColors.primarycolor1,
                                    child: Center(
                                      child: ProjectUtils().headingsmall(
                                          context: context,
                                          color: Colors.white,
                                          text: 'Book Now'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Text('Document does not exist');
                }
              }

              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
