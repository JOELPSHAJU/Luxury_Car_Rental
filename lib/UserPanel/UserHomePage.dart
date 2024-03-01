import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/UserPanel/advertisement.dart';
import 'package:luxurycars/UserPanel/find_us.dart';
import 'package:luxurycars/UserPanel/homepagepopularlistview.dart';
import 'package:luxurycars/UserPanel/how_it_works.dart';
import 'package:luxurycars/UserPanel/specificbrand.dart';
import 'package:luxurycars/UserPanel/whychooseus.dart';

class UserHomePageNew extends StatefulWidget {
  const UserHomePageNew({super.key});

  @override
  State<UserHomePageNew> createState() => _UserHomePageNewState();
}

int _currentindex = 0;

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
  'assets/brands/sports.jpg',
  'assets/brands/luxury.jpg',
  'assets/brands/hybrid.jpg',
  'assets/brands/electric.jpg',
  'assets/brands/coupe.jpg',
  'assets/brands/Convertible.jpg',
  'assets/brands/sedan.jpg',
  'assets/brands/hatchback.jpg',
  'assets/brands/suv.jpeg',
  'assets/brands/crossover.jpg',
  'assets/brands/pickuptruck.jpg',
  'assets/brands/minivan.jpg',
  'assets/brands/special.jpg',
];

final sizedboc = const SizedBox(
  height: 10,
);

class _UserHomePageNewState extends State<UserHomePageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      extendBody: true,
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //MAIN CONTAINER STARTS HERE
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Advertisement(),
                    sizedboc, sizedboc, sizedboc,
                    //FIRST CARDS FOR THE BRANDS
                    Center(
                      child: Image.asset(
                        'assets/latest/categories.png',
                        width: MediaQuery.of(context).size.width * .3,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .25,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(0, 208, 208, 208),
                          ),
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (c) => SpecificBrand(
                                          name: category[index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            86, 180, 180, 180),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    width:
                                        MediaQuery.of(context).size.width * .42,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    categoryimages[index],
                                                  ),
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15))),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .17,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        sizedboc,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              category[index]
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.oswald(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .042,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: category.length,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              sizedboc, sizedboc, sizedboc,
              const HowitWorks(),

              sizedboc,
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Container(
                child: Column(
                  children: [
                    sizedboc,
                    Image.asset(
                      'assets/latest/popular.png',
                      width: MediaQuery.of(context).size.width * .26,
                    ),
                    sizedboc,
                    sizedboc,
                    popularinventories(),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              sizedboc,
              const Whychooseus(),
              const Findus(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
