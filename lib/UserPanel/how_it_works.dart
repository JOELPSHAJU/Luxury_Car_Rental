import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

class HowitWorks extends StatelessWidget {
  const HowitWorks({super.key});
  Widget howitworks({required textdata, required heading, required Context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: GoogleFonts.gowunBatang(
                fontWeight: FontWeight.bold,
                color: ProjectColors.primarycolor1),
          ),
          Text(
            textdata,
            style: GoogleFonts.gowunBatang(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 34, 34, 34)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Image.asset(
              'assets/bg/howitworks.png',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * .02,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'You are important to us\nWe belive in a personalised experience \nfor your ride.\nYou can always Contact Us if you need any help',
              style: GoogleFonts.gowunBatang(
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.black,
                  fontSize: MediaQuery.of(context).size.height * .018),
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
                color: Color.fromARGB(255, 212, 217, 217),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .50,
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/latest/bmvhalf.png'),
                              fit: BoxFit.fitHeight)),
                      width: MediaQuery.of(context).size.width * .48,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .50,
                      width: MediaQuery.of(context).size.width * .48,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          howitworks(
                              textdata:
                                  'Search and find the suitable inventory for you',
                              heading: '1. Find Your Inventory',
                              Context: context),
                          howitworks(
                              textdata:
                                  'Once you find it ,You can initiate the booking request by filling the necessary documents and send',
                              heading: '2. Initiate Booking Request',
                              Context: context),
                          howitworks(
                              textdata:
                                  'You will recieve the confirmation once they accept the request',
                              heading: '3. Confirm Booking',
                              Context: context),
                        ],
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
