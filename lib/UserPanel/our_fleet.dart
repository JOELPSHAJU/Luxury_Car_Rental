import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

class OurFleet extends StatelessWidget {
  const OurFleet({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CarTile(
              size: size,
              title: 'City Car',
              subtitle:
                  'These range from compact and fuel-efficient city to eco-friendly model',
              image: 'assets/latest/citycar.png'),
          CarTile(
              size: size,
              title: 'Electric',
              subtitle:
                  'Discover our models of electric,hybrid or plug-in vehicles',
              image: 'assets/latest/electric.png'),
          CarTile(
              size: size,
              title: 'Prestige',
              subtitle:
                  'You can choose from a wide range of luxury vehicles made by legendary manufactures',
              image: 'assets/latest/luxury.png'),
          CarTile(
              size: size,
              title: 'Van & Truck',
              subtitle:
                  "You're looking for a SUV for your business or leisure trip? ",
              image: 'assets/latest/minivan.png'),
        ],
      ),
    );
  }
}

class CarTile extends StatelessWidget {
  const CarTile({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    required this.image,
  });
  final String title;
  final String subtitle;
  final String image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * .7,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 87, 87, 87)),
                ),
              ],
            ),
            Image.asset(image)
          ],
        ),
      ),
    );
  }
}
