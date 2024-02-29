import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final child;
  const EventCard({super.key, required this.child, required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: isPast
                ? Color.fromRGBO(167, 221, 255, 1)
                : Color.fromARGB(255, 241, 241, 241),
            borderRadius: BorderRadius.circular(12)),
        height: MediaQuery.of(context).size.height * .07,
        width: MediaQuery.of(context).size.width * .3,
        child: Center(
          child: Text(
            child.toString(),
            style: GoogleFonts.oswald(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
