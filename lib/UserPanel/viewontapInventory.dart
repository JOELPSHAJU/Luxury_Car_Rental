import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/BookingScreens/booking_page.dart';
import 'package:luxurycars/UserPanel/cartfromUser.dart';
import 'package:luxurycars/UserPanel/comparison_cars.dart';
import 'package:luxurycars/UserPanel/favourate.dart';

import 'package:luxurycars/UserPanel/ontap_view_images.dart';
import 'package:luxurycars/UserPanel/view_inventory_tab.dart';

// ignore: must_be_immutable
class ParticularInventory extends StatefulWidget {
  String id;
  ParticularInventory({super.key, required this.id, cart});

  @override
  State<ParticularInventory> createState() => _ParticularInventoryState();
}

class _ParticularInventoryState extends State<ParticularInventory> {
  final String collectionName = 'cardetails';
  bool favfound = false;
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
  Map<String, dynamic> datamap = {};
  late String? email = user?.email;

  final onpresscolor = ProjectColors.primarycolor1;

  bool onpress = false;

  Future<void> checkIfDocumentExists(String docId, String email) async {
    try {
      // Get a reference to the "favourites" collection
      CollectionReference favourites =
          FirebaseFirestore.instance.collection('favourites');

      // Query the collection for a document that matches both conditions
      QuerySnapshot querySnapshot = await favourites
          .where('Id', isEqualTo: docId)
          .where('email', isEqualTo: email)
          .get();

      // Check if any documents were found
      setState(() {
        favfound = querySnapshot.docs.isNotEmpty;
      });
    } catch (e) {
      print("Error checking document: $e");
      setState(() {
        favfound = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfDocumentExists(widget.id, email.toString());
  }

  bool dataUpdated = false;

  void _navigateAndRefresh() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddtoCartUser()),
    );

    if (result != null && result == true) {
      // Refresh the UI
      setState(() {
        dataUpdated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(favfound);
    Map<String, dynamic> BookingPageDetails = {};
    print(email);
    Map<String, dynamic> addToCartDetails = {};
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromARGB(255, 42, 42, 42)),
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
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                if (favfound) {
                  _navigateAndRefresh();
                } else {
                  await DatabaseMethods().addtocart(addToCartDetails);
                }
                checkIfDocumentExists(widget.id, email.toString());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 42, 42, 42),
                    ),
                    height: 40,
                    width: 40,
                    child: Center(
                        child: favfound == true
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite,
                                color: const Color.fromARGB(255, 199, 199, 199),
                              ))),
              ),
            )
          ],
          toolbarHeight: 55,
        ),
        body: Center(
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
                  String displayimage = data['DisplayImage'];
                  String overview = data['Overview'];
                  String price = data['Price Per Day'];
                  String seatingcapacity = data['Seating Capacity'];
                  String transmission = data['Transmission'];
                  String zerotohundred = data['Zero To Hundred'];

                  addToCartDetails = {
                    "Id": docsid,
                    "Image": mainimage,
                    "Company": company,
                    "Category": category,
                    "Model Name": modelname,
                    "Priceperday": price,
                    "email": email,
                    "Maxpower": maxpower,
                    "FuelType": fueltype,
                    "SeatingCapacity": seatingcapacity
                  };

                  //acess the data to a map to forward it to booking page

                  BookingPageDetails = {
                    'Company': company,
                    'Category': category,
                    'PricePerDay': price,
                    'Gearbox': gearbox,
                    'Engine': engine,
                    'overview': overview,
                    'id': widget.id,
                    'Transmission': transmission,
                    'Fuel Type': fueltype,
                    'Fuel Tank': fueltank,
                    'Ground Clearence': groundclearence,
                    'MaxTorque': maxtorque,
                    'MaxPower': maxpower,
                    'Seating': seatingcapacity,
                    'Zero': zerotohundred,
                    'image': displayimage,
                    'model': modelname,
                    'numberplate': numberplate,
                    'docsid': widget.id
                  };
                  datamap = {
                    'Company': company,
                    'Category': category,
                    'PricePerDay': price,
                    'Gearbox': gearbox,
                    'Engine': engine,
                    'overview': overview,
                    'id': widget.id,
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
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        View_Ontap_Images(images: images),
                        Expanded(
                          child: ViewInventoryT(
                            data: BookingPageDetails,
                          ),
                        )
                      ],
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
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .08,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => ComparisonCars(
                          company1: datamap['Company'],
                          modelname1: datamap['model'],
                          image1: datamap['image'],
                          category1: datamap['Category'],
                          engine1: datamap['Engine'],
                          maxpower1: datamap['MaxPower'],
                          maxtorque1: datamap['MaxTorque'],
                          transmission1: datamap['Transmission'],
                          gearbox1: datamap['Gearbox'],
                          zerotohndrd1: datamap['Zero'],
                          fueltype1: datamap['Fuel Type'],
                          fuelcapacity1: datamap['Fuel Tank'],
                          seatingCapacity1: datamap['Seating'],
                          groundclearence1: datamap['Ground Clearence'],
                          id1: widget.id)));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Center(
                    child: ProjectUtils().headingsmall(
                        context: context,
                        color: ProjectColors.black,
                        text: 'Compare'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => BookingPage(
                            data: BookingPageDetails,
                          )));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width * .5,
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
      ),
    );
  }
}
