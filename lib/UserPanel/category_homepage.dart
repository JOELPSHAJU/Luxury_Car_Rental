import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/specificbrand.dart'; // Import CarouselSlider package

class Categories extends StatelessWidget {
  Categories({Key? key});

  List<String> category = [
    'Sports',
    'Luxury',
    'Hybrid',
    'Fully Electric',
    'Coupe',
    'Convertible',
    'Sedan',
    'Hatchback',
    'SUV',
    'Crossover',
    'Pickup Truck',
    'Minivan',
    'Special'
  ];
  List<String> categoryimages = [
    'assets/categories/sports.png',
    'assets/categories/luxury.png',
    'assets/categories/hybrid.png',
    'assets/categories/electric.png',
    'assets/categories/coupe.png',
    'assets/categories/convertible.png',
    'assets/categories/sedan.png',
    'assets/categories/hatchback.png',
    'assets/categories/suv.png',
    'assets/categories/crossover.png',
    'assets/categories/pickuptruck.png',
    'assets/categories/minivan.png',
    'assets/categories/special.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .23,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedboc,
                sizedboc,
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset(
                    'assets/latest/categories.png',
                    width: MediaQuery.of(context).size.width * .3,
                  ),
                ),
                sizedboc,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .14,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) =>
                                  SpecificBrand(name: category[index])));
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 154, 154, 154)
                                        .withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(1, 3),
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width * .24,
                              child: Column(
                                children: [
                                  Image.asset(categoryimages[index]),
                                  Text(
                                    category[index],
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
