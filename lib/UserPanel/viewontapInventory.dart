import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/BookingScreens/booking_page.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/comparison_cars.dart';
import 'package:luxurycars/UserPanel/ontap_view_images.dart';
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
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                DatabaseMethods().addtocart(addToCartDetails);
                setState(() {});
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
                        child: Icon(
                      Icons.favorite,
                      color: Colors.red,
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          View_Ontap_Images(images: images),
                          const Divider(
                            color: Color.fromARGB(255, 220, 220, 220),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .08,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('$company $modelname',
                                          style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .047,
                                              color:
                                                  ProjectColors.secondarycolor2,
                                              fontWeight: FontWeight.w600)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text('from ',
                                                style: GoogleFonts.oswald(
                                                    color: Colors.grey)),
                                            Text('₹ ${data['Price Per Day']}',
                                                style: GoogleFonts.oswald(
                                                    fontWeight: FontWeight.w600,
                                                    color: ProjectColors
                                                        .primarycolor1,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .05)),
                                            Text(
                                              ' /day',
                                              style: GoogleFonts.oswald(
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    height: MediaQuery.of(context).size.height *
                                        .08,
                                    child: Image.asset(
                                      'assets/new/images.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Color.fromARGB(255, 209, 209, 209),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .99,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Overview',
                                          style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .045,
                                              fontWeight: FontWeight.w600,
                                              color: ProjectColors
                                                  .secondarycolor2)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (comparison) =>
                                                      ComparisonCars(
                                                          image1: mainimage,
                                                          company1: company,
                                                          modelname1: modelname,
                                                          category1: category,
                                                          engine1: engine,
                                                          maxpower1: maxpower,
                                                          maxtorque1: maxtorque,
                                                          transmission1:
                                                              transmission,
                                                          gearbox1: gearbox,
                                                          zerotohndrd1:
                                                              zerotohundred,
                                                          fueltype1: fueltype,
                                                          fuelcapacity1:
                                                              fueltank,
                                                          seatingCapacity1:
                                                              seatingcapacity,
                                                          groundclearence1:
                                                              groundclearence,
                                                          id1: docsid)));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: ProjectColors
                                                      .primarycolor1,
                                                  width: 2)),
                                          child: const Center(
                                            child: Text('Compare'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  sizedboc,
                                  const Divider(
                                    thickness: 1,
                                    color: Color.fromARGB(255, 141, 141, 141),
                                  ),
                                  sizedboc,
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
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .045,
                                        fontWeight: FontWeight.w600,
                                        color: ProjectColors.secondarycolor2)),
                              ],
                            ),
                          ),
                          const Divider(),
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
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .08,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 2),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      behavior: SnackBarBehavior.floating,
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                        child: Center(
                          child: LottieBuilder.asset(
                            'assets/animations/cartadded.json',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )));
                },
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Center(
                    child: ProjectUtils().headingsmall(
                        context: context,
                        color: ProjectColors.primarycolor1,
                        text: 'Add to Favourites'),
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
