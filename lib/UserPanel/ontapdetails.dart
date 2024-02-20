// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';

class OntapDetails extends StatelessWidget {
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

  textstyle2({required context}) {
    return GoogleFonts.signikaNegative(
        fontSize: MediaQuery.of(context).size.width * .037,
        fontWeight: FontWeight.w600,
        color: ProjectColors.primarycolor1);
  }

  textstyle1({required context}) {
    return GoogleFonts.signikaNegative(
        fontSize: MediaQuery.of(context).size.width * .045,
        fontWeight: FontWeight.w600,
        color: const Color.fromARGB(255, 143, 143, 143));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .23,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/engine.png'),
                    ),
                    Text(
                      'Engine',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      engine + ' hp',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/power.png'),
                    ),
                    Text(
                      'Maximum Power',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      power + ' cc',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/torque.png'),
                    ),
                    Text(
                      'Maximum Torque ',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      torque + ' nm',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/transmission.png'),
                    ),
                    Text(
                      'Transmission',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      transmission,
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/new/gear.png'),
                    ),
                    Text(
                      'Gearbox',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      gearbox + ' speed',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.6, color: Colors.grey),
                ),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/new/speedometer.png'),
                    ),
                    Text(
                      '0 - 100',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      zero + ' sec',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/fueltank.png'),
                    ),
                    Text(
                      'Fuel Tank',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      fueltank + ' ltrs',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/PUMP.png'),
                    ),
                    Text(
                      'Fuel Type',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      fuelty,
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/sea.png'),
                    ),
                    Text(
                      'Seating Capacity',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      seating,
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset('assets/bg/ground.png'),
                    ),
                    Text(
                      'Ground Clearence',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      ground + ' mm',
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.6, color: Colors.grey)),
                height: MediaQuery.of(context).size.height * .18,
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset(
                        'assets/latest/category.png',
                      ),
                    ),
                    Text(
                      'Category',
                      style: textstyle1(context: context),
                    ),
                    Text(
                      category,
                      style: textstyle2(context: context),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
