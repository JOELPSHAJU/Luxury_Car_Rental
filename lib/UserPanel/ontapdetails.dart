// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class OntapDetails extends StatefulWidget {
  final String engine;
  final String power;
  final String torque;
  final String transmission;
  final String gearbox;
  final String zero;
  final String fuelty;
  final String fueltank;
  final String seating;
  final String ground;
  final String category;

  const OntapDetails(
      {super.key,
      required this.engine,
      required this.power,
      required this.torque,
      required this.transmission,
      required this.gearbox,
      required this.zero,
      required this.fuelty,
      required this.fueltank,
      required this.seating,
      required this.ground,
      required this.category});

  @override
  State<OntapDetails> createState() => _OntapDetailsState();
}

class _OntapDetailsState extends State<OntapDetails> {
  late List<String> infodetails = [
    widget.category,
    widget.engine,
    widget.power + 'hp',
    widget.torque + ' nm',
    widget.transmission,
    widget.gearbox + ' speed',
    widget.zero + ' seconds',
    widget.fuelty,
    widget.fueltank + ' ltrs',
    widget.seating,
    widget.ground + ' mm'
  ];

  List<String> infotitle = [
    'Category : ',
    'Engine Capacity : ',
    'Maximum Power : ',
    'Maximum Torque : ',
    'Transmission Type : ',
    'Gearbox : ',
    'Zero To Hundred : ',
    'Fuel Type : ',
    'Fuel Tank Capacity : ',
    'Seating Capacity : ',
    'Ground Clearence : ',
  ];
  List<String> infoleadImages = [
    "assets/latest/category.png",
    'assets/bg/engine.png',
    'assets/bg/power.png',
    'assets/bg/torque.png',
    'assets/bg/transmission.png',
    'assets/new/gear.png',
    'assets/new/speedometer.png',
    'assets/bg/PUMP.png',
    'assets/bg/fueltank.png',
    'assets/bg/sea.png',
    'assets/bg/ground.png',
  ];
  textstyle2({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * .04,
        fontWeight: FontWeight.w300,
        color: ProjectColors.black);
  }

  textstyle3({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * .037,
        fontWeight: FontWeight.w500,
        color: ProjectColors.black);
  }

  textstyle1({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * .04,
        fontWeight: FontWeight.w500,
        color: Color.fromARGB(255, 0, 0, 0));
  }

  bool isexpanded = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          isexpanded == false
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .65,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: infoleadImages.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 10),
                                child: Text(
                                  infotitle[index],
                                  style: textstyle1(context: context),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 8.0),
                                  child: Text(
                                    infodetails[index],
                                    style: textstyle2(context: context),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                isexpanded = !isexpanded;
                              });
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                width: MediaQuery.of(context).size.width * .6,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: ProjectColors.black),
                                  color: ProjectColors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    'View Less',
                                    style: textstyle3(context: context),
                                  ),
                                ))),
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .23,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 154, 154, 154)
                                                .withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                width: MediaQuery.of(context).size.width * .6,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child:
                                          Image.asset('assets/bg/engine.png'),
                                    ),
                                    Text(
                                      'Engine',
                                      style: textstyle1(context: context),
                                    ),
                                    Text(
                                      widget.engine,
                                      style: textstyle2(context: context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 154, 154, 154)
                                                .withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                width: MediaQuery.of(context).size.width * .6,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child: Image.asset('assets/bg/power.png'),
                                    ),
                                    Text(
                                      'Maximum Power',
                                      style: textstyle1(context: context),
                                    ),
                                    Text(
                                      widget.power + ' hp',
                                      style: textstyle2(context: context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 154, 154, 154)
                                                .withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                height:
                                    MediaQuery.of(context).size.height * .18,
                                width: MediaQuery.of(context).size.width * .6,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      child:
                                          Image.asset('assets/bg/torque.png'),
                                    ),
                                    Text(
                                      'Maximum Torque ',
                                      style: textstyle1(context: context),
                                    ),
                                    Text(
                                      widget.torque + ' nm',
                                      style: textstyle2(context: context),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isexpanded = !isexpanded;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .07,
                            width: MediaQuery.of(context).size.width * .6,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: ProjectColors.white,
                            ),
                            child: Center(
                                child: Text(
                              'View All Specifications',
                              style: textstyle3(context: context),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
