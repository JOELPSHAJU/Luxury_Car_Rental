import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/booking_page.dart';
import 'package:luxurycars/UserPanel/ontapdetails.dart';
import 'package:luxurycars/UserPanel/rentalrulesuser.dart';

// ignore: must_be_immutable
class ParticularInventory extends StatelessWidget {
  String id;
  ParticularInventory({super.key, required this.id});

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
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 94, 94, 94)),
        ),
        Text(
          '$data $addons',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0)),
        )
      ],
    );
  }

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Center(
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(id)
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
                    String docsid = id;
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

                    String overview = data['Overview'];
                    String price = data['Price Per Day'];
                    String seatingcapacity = data['Seating Capacity'];
                    String transmission = data['Transmission'];
                    String zerotohundred = data['Zero To Hundred'];
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            height: MediaQuery.of(context).size.height * 0.29,
                            width: double.infinity,
                            child: FractionallySizedBox(
                              heightFactor: 95.0,
                              child: CarouselSlider(
                                items: images.map((url) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
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
                          Container(
                            height: 62,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$company \n$modelname',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .022,
                                        fontWeight: FontWeight.bold,
                                        color: ProjectColors.secondarycolor2),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Map<String, dynamic> car = {
                                          "Id": docsid,
                                          "Image": images[0],
                                          "Company": company,
                                          "Category": category,
                                          "Model Name": modelname,
                                          "Priceperday": price,
                                          "email": email
                                        };
                                        DatabaseMethods().addtocart(car);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.green,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  'Inventory Added To Cart',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )));
                                      },
                                      icon: Icon(
                                        Icons.shopping_cart,
                                        size: 30,
                                        color: ProjectColors.secondarycolor2,
                                      ))
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .99,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Overview',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .025,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              ProjectColors.secondarycolor2)),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    child: Text(
                                      overview,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 211, 211, 211),
                              ),
                              width: MediaQuery.of(context).size.width * .99,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, left: 5, bottom: 5),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color.fromARGB(
                                                255, 158, 74, 74),
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  'assets/max/logo.png',
                                                ),
                                                fit: BoxFit.cover)),
                                        child: const Center(),
                                        height: 55,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .42),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      height: 70,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'GO DRIVE LUXURY RENTALS',
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .017,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: ProjectColors
                                                        .secondarycolor2,
                                                  ),
                                                  Text('5.0',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .016,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              ViewRentalUser()));
                                                },
                                                child: const Text(
                                                  'Rental Rules',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 128, 22, 14)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                Text(
                                  'Technical Specification',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .025,
                                      fontWeight: FontWeight.bold,
                                      color: ProjectColors.secondarycolor2),
                                ),
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
                          const Divider(
                            thickness: 3,
                          ),
                          Center(
                            child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width * .99,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'from',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '₹' + '$price',
                                                    style: const TextStyle(
                                                        fontSize: 29,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Text(
                                                    ' / day',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .49,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Map<String, dynamic> car = {
                                                  'Company': company,
                                                  'Category': category,
                                                  'PricePerDay': price,
                                                  'Gearbox': gearbox,
                                                  'Engine': engine,
                                                  'Transmission': transmission,
                                                  'Fuel Type': fueltype,
                                                  'Fuel Tank': fueltank,
                                                  'Ground Clearence':
                                                      groundclearence,
                                                  'MaxTorque': maxtorque,
                                                  'MaxPower': maxpower,
                                                  'Seating': seatingcapacity,
                                                  'Zero': zerotohundred,
                                                  'image': images[0],
                                                  'model': modelname,
                                                  'numberplate': numberplate,
                                                  'docsid': id
                                                };
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                BookingPage(
                                                                  data: car,
                                                                )));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: ProjectColors
                                                      .secondarycolor2),
                                              child: const Text(
                                                'Book Now',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Text('Document does not exist');
                  }
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
