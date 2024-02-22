import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class HowitWorks extends StatelessWidget {
  const HowitWorks({super.key});
  Widget howitworks({required textdata, required heading, required context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Image.asset(
              'assets/latest/howitworks.png',
              width: MediaQuery.of(context).size.width * .34,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'You are important to us\nWe belive in a personalised experience \nfor your ride.\nYou can always Contact Us if you need any help',
              style: GoogleFonts.gowunBatang(
                  fontWeight: FontWeight.w600,
                  color: ProjectColors.black,
                  fontSize: MediaQuery.of(context).size.width * .037),
              textAlign: TextAlign.center,
            )),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
              ),
              child: Container(
                color: Color.fromARGB(31, 36, 36, 36),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .50,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/latest/bmvhalf.png'),
                              fit: BoxFit.cover)),
                      width: MediaQuery.of(context).size.width * .48,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            howitworks(
                                textdata:
                                    'Search and find the suitable inventory for you',
                                heading: '1. Find Your Inventory',
                                context: context),
                            howitworks(
                                textdata:
                                    'Once you find it ,You can initiate the booking request by filling the necessary documents and send',
                                heading: '2. Initiate Booking Request',
                                context: context),
                            howitworks(
                                textdata:
                                    'You will recieve the confirmation once they accept the request',
                                heading: '3. Confirm Booking',
                                context: context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
