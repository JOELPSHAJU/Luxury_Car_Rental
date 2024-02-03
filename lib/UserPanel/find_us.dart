import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class Findus extends StatelessWidget {
  const Findus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .42,
      width: double.infinity,
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Image.asset(
            'assets/latest/1704096877291.png',
            height: MediaQuery.of(context).size.height * .06,
            width: MediaQuery.of(context).size.width * .4,
          ),
          // Text(
          //   textAlign: TextAlign.center,
          //   'Go Drive is a statewide car rental \nservice that provides cars and vehicles \nof any size and make at an affordable \nand reasonable price',
          //   style: TextStyle(
          //       fontSize: MediaQuery.of(context).size.height * .018,
          //       fontWeight: FontWeight.w400,
          //       color: Colors.white),
          // ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Find Us',
            style: GoogleFonts.signikaNegative(
                fontSize: MediaQuery.of(context).size.width * .04,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 140, 140, 140)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.center,
            'Ettumanoor-Ernakulam Road,Vyttila\nErnakulam - Kerala\nNear Tony&Guy\nKerala 682019',
            style: GoogleFonts.gowunBatang(
                fontSize: MediaQuery.of(context).size.width * .037,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 197, 197, 197)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Contact Us',
            style: GoogleFonts.signikaNegative(
                fontSize: MediaQuery.of(context).size.width * .04,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 140, 140, 140)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textAlign: TextAlign.center,
            '+91 8590182736\njoelpshaju@gmail.com',
            style: GoogleFonts.gowunBatang(
                fontSize: MediaQuery.of(context).size.width * .037,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 197, 197, 197)),
          ),
          sizedboc,
        ],
      ),
    );
  }
}
