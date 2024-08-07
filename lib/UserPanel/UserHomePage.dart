import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/UserPanel/advertisement.dart';

import 'package:luxurycars/UserPanel/homepagepopularlistview.dart';
import 'package:luxurycars/UserPanel/how_it_works.dart';
import 'package:luxurycars/UserPanel/our_fleet.dart';

import 'package:luxurycars/UserPanel/whychooseus.dart';

class UserHomePageNew extends StatefulWidget {
  const UserHomePageNew({super.key});

  @override
  State<UserHomePageNew> createState() => _UserHomePageNewState();
}

const sizedboc = SizedBox(
  height: 10,
);

class _UserHomePageNewState extends State<UserHomePageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Advertisement()],
              ),
            ),
            Container(
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    sizedboc,
                    sizedboc,
                    Text('Popular',
                        style: GoogleFonts.roboto(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    sizedboc,
                    popularinventories(),
                  ],
                )),
            Container(
              height: 80,
              width: double.infinity,
              color: Color.fromARGB(255, 198, 210, 215),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('A Fleet That Meet Your Needs',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    'Take the oppertunity to travel with your dreams',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 54, 54, 54),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const OurFleet(),
            const Whychooseus(),
            const HowitWorks(),
          ],
        ),
      ),
    );
  }
}
