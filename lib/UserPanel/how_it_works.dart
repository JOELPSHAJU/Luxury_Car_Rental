import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class HowitWorks extends StatelessWidget {
  const HowitWorks({super.key});
  Widget howitworks({required textdata, required heading, required context}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.gowunBatang(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * .037,
                color: ProjectColors.primarycolor1),
          ),
          Text(
            textdata,
            style: GoogleFonts.gowunBatang(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * .037,
                color: const Color.fromARGB(255, 34, 34, 34)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color.fromARGB(255, 23, 30, 33),
      height: MediaQuery.of(context).size.height * 1.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sizedboc,
          sizedboc,
          sizedboc,
          sizedboc,
          Text('How It Works ?',
              style: GoogleFonts.roboto(
                  color: Color.fromARGB(255, 196, 196, 196),
                  fontSize: 23,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold)),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .47,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 49, 49, 49),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BorderedText(
                                  strokeWidth: 2,
                                  strokeColor:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  child: Text(
                                    '1',
                                    style: GoogleFonts.oswald(
                                        color: Colors.transparent,
                                        fontSize: 30),
                                  )),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Search & Find Your Preferred Vehicle',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  fontSize: 14),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Choose your desired vehicle from our various available options.',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .21,
                        child: Image.asset(
                          'assets/max/howitworks2.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 49, 49, 49),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BorderedText(
                                  strokeWidth: 2,
                                  strokeColor:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  child: Text(
                                    '3',
                                    style: GoogleFonts.oswald(
                                        color: Colors.transparent,
                                        fontSize: 30),
                                  )),
                            ),
                            sizedboc,
                            Text(
                              'Drive Your Vehicle',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  fontSize: 14),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Take your car for a spin and start your road trip with your loved ones.',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * .23,
                        child: Image.asset(
                          'assets/max/howitworks1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * .47,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * .23,
                        child: Image.asset(
                          'assets/max/howitworks4.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 49, 49, 49),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: BorderedText(
                                  strokeWidth: 2,
                                  strokeColor:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  child: Text(
                                    '2',
                                    style: GoogleFonts.oswald(
                                        color: Colors.transparent,
                                        fontSize: 30),
                                  )),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Pick Up Your Vehicle',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  fontSize: 14),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Take delivery of your car from the pickup point speccified in the order details.',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height * .21,
                        child: Image.asset(
                          'assets/max/howitworks3.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromARGB(255, 49, 49, 49),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: BorderedText(
                                  strokeWidth: 2,
                                  strokeColor:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  child: Text(
                                    '4',
                                    style: GoogleFonts.oswald(
                                        color: Colors.transparent,
                                        fontSize: 30),
                                  )),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Return Your Vechile',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 22, 154, 184),
                                  fontSize: 14),
                            ),
                            sizedboc,
                            Text(
                              textAlign: TextAlign.left,
                              'Get the vehicle to your prefered return location,and we will take it from there .',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
