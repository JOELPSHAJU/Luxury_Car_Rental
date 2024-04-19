import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class ComparisonCars extends StatefulWidget {
  final String category1;
  final String engine1;
  final String modelname1;
  final String company1;
  final String maxpower1;
  final String maxtorque1;
  final String transmission1;
  final String gearbox1;
  final String zerotohndrd1;
  final String fueltype1;
  final String fuelcapacity1;
  final String image1;
  final String seatingCapacity1;
  final String groundclearence1;
  final String id1;
  const ComparisonCars(
      {super.key,
      required this.company1,
      required this.modelname1,
      required this.image1,
      required this.category1,
      required this.engine1,
      required this.maxpower1,
      required this.maxtorque1,
      required this.transmission1,
      required this.gearbox1,
      required this.zerotohndrd1,
      required this.fueltype1,
      required this.fuelcapacity1,
      required this.seatingCapacity1,
      required this.groundclearence1,
      required this.id1});

  @override
  State<ComparisonCars> createState() => _ComparisonCarsState();
}

class _ComparisonCarsState extends State<ComparisonCars> {
  List<dynamic> carNames = [];
  List<dynamic> carimages = [];
  List<dynamic> companynames = [];
  List<String> documentIds = [];

  late String company2 = '';
  late String Modelname2 = '';
  late String category2 = '';
  late String engine2 = '';
  late String maxpower2 = '';
  late String maxtorque2 = '';
  late String transmission2 = '';
  late String gearbox2 = '';
  late String zerotohndrd2 = '';
  late String fueltype2 = '';
  late String fuelcapacity2 = '';
  late String image2 = '';
  late String seatingCapacity2 = '';
  late String groundclearence2 = '';
  final color = Color.fromARGB(255, 240, 240, 240);

  @override
  void initState() {
    super.initState();
    fetchCarDetails();
  }

  Future<void> fetchCarDetails() async {
    QuerySnapshot carDetailsSnapshot =
        await FirebaseFirestore.instance.collection('cardetails').get();
    setState(() {
      carimages = carDetailsSnapshot.docs
          .where((doc) => doc.id != widget.id1)
          .map((doc) => doc['MainImage'])
          .toList();
      companynames = carDetailsSnapshot.docs
          .where((doc) => doc.id != widget.id1)
          .map((doc) => doc['Company'])
          .toList();
      carNames = carDetailsSnapshot.docs
          .where((doc) => doc.id != widget.id1)
          .map((doc) => doc['Model Name'])
          .toList();
      documentIds = carDetailsSnapshot.docs
          .where((doc) => doc.id != widget.id1)
          .map((doc) => doc.id)
          .toList();
    });
  }

  Future<void> fetchCarDetailss(String docId) async {
    DocumentSnapshot carSnapshot = await FirebaseFirestore.instance
        .collection('cardetails')
        .doc(docId)
        .get();

    setState(() {
      company2 = carSnapshot['Company'];
      Modelname2 = carSnapshot['Model Name'];
      category2 = carSnapshot['Category'];
      engine2 = carSnapshot['Engine Displacement'];
      maxpower2 = carSnapshot['Maximum Power'];
      maxtorque2 = carSnapshot['Maximum Torque'];
      transmission2 = carSnapshot['Transmission'];
      gearbox2 = carSnapshot['Gearbox'];
      zerotohndrd2 = carSnapshot['Zero To Hundred'];
      fueltype2 = carSnapshot['Fuel Type'];
      fuelcapacity2 = carSnapshot['Fuel Tank Capacity'];
      image2 = carSnapshot['MainImage'];
      seatingCapacity2 = carSnapshot['Seating Capacity'];
      groundclearence2 = carSnapshot['Ground Clearence'];
    });
  }

  textlabel({required context, required text, required colors}) {
    return Container(
      color: colors,
      height: MediaQuery.of(context).size.height * .07,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width * .04),
        ),
      ),
    );
  }

  textlabel1({required context, required text, required colors}) {
    return Container(
      color: colors,
      height: MediaQuery.of(context).size.height * .07,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * .04),
        ),
      ),
    );
  }

  textlabel2({required context, required text, required colors}) {
    return image2.isNotEmpty
        ? Container(
            color: colors,
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.width * .04),
              ),
            ),
          )
        : Container(
            color: colors,
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Compare Cars',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: ProjectColors.primarycolor1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * .18,
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Column(
                                            children: List.generate(
                                                carNames.length, (index) {
                                              String fullName =
                                                  '${companynames[index]} ${carNames[index]}';
                                              return ListTile(
                                                tileColor: index % 2 == 1
                                                    ? Color.fromARGB(
                                                        255, 243, 243, 243)
                                                    : Colors.transparent,
                                                title: Text(
                                                  fullName,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                onTap: () {
                                                  fetchCarDetailss(
                                                      documentIds[index]);

                                                  Navigator.pop(context);
                                                },
                                              );
                                            }),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/max/car replace_prev_ui (1).png',
                                      height: 50,
                                    ),
                                    Text('Select Car')
                                  ],
                                )),
                              )),
                          textlabel(
                              context: context, colors: color, text: 'Company'),
                          textlabel(
                              context: context,
                              colors: Colors.transparent,
                              text: 'Model'),
                          textlabel(
                              context: context,
                              colors: color,
                              text: 'Category'),
                          textlabel(
                              colors: Colors.transparent,
                              context: context,
                              text: 'Engine Displacement'),
                          textlabel(
                              context: context,
                              colors: color,
                              text: 'Maximum Power'),
                          textlabel(
                              context: context,
                              colors: Colors.transparent,
                              text: 'Maximum Torque'),
                          textlabel(
                              context: context,
                              colors: color,
                              text: 'Transmission'),
                          textlabel(
                              context: context,
                              colors: Colors.transparent,
                              text: 'Gearbox'),
                          textlabel(
                              context: context, colors: color, text: '0 - 100'),
                          textlabel(
                              context: context,
                              colors: Colors.transparent,
                              text: 'Fuel Type'),
                          textlabel(
                              colors: color,
                              context: context,
                              text: 'Fuel Tank Capacity'),
                          textlabel(
                              context: context,
                              colors: Colors.transparent,
                              text: 'Seating Capacity'),
                          textlabel(
                              context: context,
                              colors: color,
                              text: 'Ground Clearence')
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .18,
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(imageUrl: widget.image1),
                          ),
                          textlabel1(
                              context: context,
                              colors: color,
                              text: widget.company1),
                          textlabel1(
                              context: context,
                              colors: Colors.transparent,
                              text: widget.modelname1),
                          textlabel1(
                              context: context,
                              colors: color,
                              text: widget.category1),
                          textlabel1(
                              context: context,
                              colors: Colors.transparent,
                              text: widget.engine1),
                          textlabel1(
                              colors: color,
                              context: context,
                              text: widget.maxpower1 + ' hp'),
                          textlabel1(
                              colors: Colors.transparent,
                              context: context,
                              text: widget.maxtorque1 + ' nm'),
                          textlabel1(
                              colors: color,
                              context: context,
                              text: widget.transmission1),
                          textlabel1(
                              colors: Colors.transparent,
                              context: context,
                              text: widget.gearbox1 + ' speed'),
                          textlabel1(
                              colors: color,
                              context: context,
                              text: widget.zerotohndrd1 + ' seconds'),
                          textlabel1(
                              context: context,
                              colors: Colors.transparent,
                              text: widget.fueltype1),
                          textlabel1(
                              colors: color,
                              context: context,
                              text: widget.fuelcapacity1 + ' ltrs'),
                          textlabel1(
                              colors: Colors.transparent,
                              context: context,
                              text: widget.seatingCapacity1 + ' person'),
                          textlabel1(
                              colors: color,
                              context: context,
                              text: widget.groundclearence1 + ' mm')
                        ],
                      ),
                    ),
                    image2.isNotEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .18,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .18,
                                    width:
                                        MediaQuery.of(context).size.width * .7,
                                    child: CachedNetworkImage(imageUrl: image2),
                                  ),
                                ),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: company2),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: Modelname2),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: category2),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: engine2),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: maxpower2 + ' hp'),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: maxtorque2 + ' nm'),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: transmission2),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: gearbox2 + ' speed'),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: zerotohndrd2 + ' seconds'),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: fueltype2),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: fuelcapacity2 + ' ltrs'),
                                textlabel2(
                                    context: context,
                                    colors: Colors.transparent,
                                    text: seatingCapacity2 + ' person'),
                                textlabel2(
                                    context: context,
                                    colors: color,
                                    text: groundclearence2 + ' nm')
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
