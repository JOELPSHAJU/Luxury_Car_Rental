import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class ComparisonCars extends StatefulWidget {
  final String? category1;
  final String? engine1;
  final String? modelname1;
  final String? company1;
  final String? maxpower1;
  final String? maxtorque1;
  final String? transmission1;
  final String? gearbox1;
  final String? zerotohndrd1;
  final String? fueltype1;
  final String? fuelcapacity1;
  final String? image1;
  final String? seatingCapacity1;
  final String? groundclearence1;
  final String? id1;
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
      maxpower2 = carSnapshot['Maximum Power'] + ' hp';
      maxtorque2 = carSnapshot['Maximum Torque'] + ' nm';
      transmission2 = carSnapshot['Transmission'];
      gearbox2 = carSnapshot['Gearbox'] + ' speed';
      zerotohndrd2 = carSnapshot['Zero To Hundred'] + ' seconds';
      fueltype2 = carSnapshot['Fuel Type'];
      fuelcapacity2 = carSnapshot['Fuel Tank Capacity'] + ' ltrs';
      image2 = carSnapshot['MainImage'];
      seatingCapacity2 = carSnapshot['Seating Capacity'] + ' persons';
      groundclearence2 = carSnapshot['Ground Clearence'] + 'mm';
    });
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

  final snackBar = SnackBar(
    backgroundColor: Colors.blue,
    behavior: SnackBarBehavior.floating,
    content: Center(
      child: Text(
        'Tap On The Car To Change The Car',
        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: Icon(
                Icons.info_outline,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        title: Text(
          'Compare Cars',
          style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
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
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .18,
                  width: MediaQuery.of(context).size.width * .5,
                  child: CachedNetworkImage(
                    imageUrl: widget.image1.toString(),
                    height: 50,
                  ),
                ),
                image2.isEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * .18,
                        width: MediaQuery.of(context).size.width * .5,
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
                                      children: List.generate(carNames.length,
                                          (index) {
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
                                                fontWeight: FontWeight.w600),
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
                        ))
                    : GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    children:
                                        List.generate(carNames.length, (index) {
                                      String fullName =
                                          '${companynames[index]} ${carNames[index]}';
                                      return ListTile(
                                        tileColor: index % 2 == 1
                                            ? Color.fromARGB(255, 243, 243, 243)
                                            : Colors.transparent,
                                        title: Text(
                                          fullName,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        onTap: () {
                                          fetchCarDetailss(documentIds[index]);

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
                        child: Container(
                          height: MediaQuery.of(context).size.height * .18,
                          width: MediaQuery.of(context).size.width * .5,
                          child: CachedNetworkImage(
                            imageUrl: image2,
                            height: 50,
                          ),
                        ),
                      )
              ],
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Company',
              car2: company2,
              car1: widget.company1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Model',
              car2: Modelname2,
              car1: widget.modelname1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Category',
              car2: category2,
              car1: widget.category1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Engine Displacement',
              car2: engine2,
              car1: widget.engine1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Maximum Power',
              car2: maxpower2,
              car1: widget.maxpower1.toString() + ' hp',
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Maximum Torque',
              car2: maxtorque2,
              car1: widget.maxtorque1.toString() + ' nm',
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Transmission',
              car2: transmission2,
              car1: widget.transmission1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Gearbox',
              car2: gearbox2,
              car1: widget.toString() + ' speed',
            ),
            ComparisonTile(
              endpoint: '',
              label: '0 - 100',
              car2: zerotohndrd2,
              car1: widget.zerotohndrd1.toString() + ' seconds',
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Fuel Type',
              car2: fueltype2,
              car1: widget.fueltype1.toString(),
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Fuel Tank Capacity',
              car2: fuelcapacity2,
              car1: widget.fuelcapacity1.toString() + ' ltrs',
            ),
            ComparisonTile(
              endpoint: '',
              label: 'Seating Capacity',
              car2: seatingCapacity2,
              car1: widget.seatingCapacity1.toString() + ' persons',
            ),
            ComparisonTile(
              endpoint: 'mm',
              label: 'Ground Clearence',
              car2: groundclearence2,
              car1: widget.groundclearence1.toString() + ' mm',
            ),
          ],
        ),
      ),
    );
  }
}

class ComparisonTile extends StatelessWidget {
  final String car1;
  final String label;
  final String endpoint;
  final String car2;
  const ComparisonTile(
      {super.key,
      required this.car1,
      required this.label,
      required this.car2,
      required this.endpoint});
  textlabel({
    required text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    );
  }

  textlabel1({
    required text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
          child: Container(
            width: double.infinity,
            height: 50,
            color: Color.fromARGB(255, 222, 224, 225),
            child: Center(
                child: textlabel(
              text: label,
            )),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .456,
                  child: Center(
                    child: textlabel1(text: car1),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
              child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  height: 50,
                  width: MediaQuery.of(context).size.width * .455,
                  child: car2.isNotEmpty
                      ? Center(
                          child: textlabel1(text: car2),
                        )
                      : Center()),
            )
          ],
        )
      ],
    );
  }
}
