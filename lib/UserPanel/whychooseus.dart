import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

class whychooseus extends StatelessWidget {
  const whychooseus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Why choose our service ?',
              style: GoogleFonts.signikaNegative(
                  fontSize: MediaQuery.of(context).size.width * .05,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "At Go Drive, our expert staff offers lots of benefits and advantages to our clients.With us, you'll recieve a class-leading car rental service from local experts.",
                textAlign: TextAlign.center,
                style: GoogleFonts.gowunBatang(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: const Color.fromARGB(255, 108, 108, 108),
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/bg/modulus.png',
            width: MediaQuery.of(context).size.width * .1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              textAlign: TextAlign.center,
              'Low Prices',
              style: GoogleFonts.signikaNegative(
                  fontSize: MediaQuery.of(context).size.width * .05,
                  color: ProjectColors.primarycolor1,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                textAlign: TextAlign.center,
                'Go Drive provides top-class services at an affordable price.',
                style: GoogleFonts.gowunBatang(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/bg/person.png',
            width: MediaQuery.of(context).size.width * .2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              textAlign: TextAlign.center,
              'Experienced Staff',
              style: GoogleFonts.signikaNegative(
                  fontSize: MediaQuery.of(context).size.width * .05,
                  color: ProjectColors.primarycolor1,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                textAlign: TextAlign.center,
                'We hire best experts in everything\n concerning car rental.',
                style: GoogleFonts.gowunBatang(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/bg/message.png',
            width: MediaQuery.of(context).size.width * .2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              textAlign: TextAlign.center,
              'Reliable support',
              style: GoogleFonts.signikaNegative(
                  fontSize: MediaQuery.of(context).size.width * .05,
                  color: ProjectColors.primarycolor1,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                textAlign: TextAlign.center,
                'Our team guarantee reliable support in addition\n to the offered services.',
                style: GoogleFonts.gowunBatang(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/bg/location.png',
            width: MediaQuery.of(context).size.width * .17,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
              textAlign: TextAlign.center,
              'Convienient Location',
              style: GoogleFonts.signikaNegative(
                  fontSize: MediaQuery.of(context).size.width * .05,
                  color: ProjectColors.primarycolor1,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                textAlign: TextAlign.center,
                'You can find our car rental officess throughout kerala',
                style: GoogleFonts.gowunBatang(
                    fontSize: MediaQuery.of(context).size.width * .04,
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
