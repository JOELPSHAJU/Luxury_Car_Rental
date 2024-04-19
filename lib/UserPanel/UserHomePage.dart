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
            sizedboc,
            sizedboc,
            Text('A Fleet That Meet Your Needs',
                style: GoogleFonts.roboto(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            Text(
              'Take the oppertunity to travel with your dreams',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 125, 125, 125),
                  fontWeight: FontWeight.w500),
            ),
            const OurFleet(),
            sizedboc,
            sizedboc,
            Text('Popular',
                style: GoogleFonts.roboto(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            sizedboc,
            sizedboc,
            Container(child: popularinventories()),
            sizedboc,
            sizedboc,
            sizedboc,
            sizedboc,
            const Whychooseus(),
            sizedboc,
            sizedboc,
            sizedboc,
            sizedboc,
            Text('How It Works ?',
                style: GoogleFonts.roboto(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            sizedboc,
            sizedboc,
            const HowitWorks(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            )
          ],
        ),
      ),
    );
  }
}
