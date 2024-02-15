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

List<String> carcategorye = [
  'Buggatti',
  'BMw M3',
  'BMW M4',
];

List<String> carimg = [
  'assets/brands/astonmartin (3).png',
  'assets/brands/audi (2).png',
  'assets/brands/brntly.png',
  'assets/brands/buggatti (2).png',
  'assets/brands/bmv.png',
  'assets/brands/ferrari (2).png',
  'assets/brands/ford (2).png',
  'assets/brands/lambo.png',
  'assets/brands/landrover (2).png',
  'assets/brands/mazda (2).png',
  'assets/brands/mclarenn.png',
  'assets/brands/merc.png',
  'assets/brands/posrshe.png',
  'assets/brands/rolls.png',
  'assets/brands/teslaa.png',
  'assets/brands/toyota (2).png'
];
List<String> carcategory = [
  'Aston Martin',
  'Audi',
  'Bently',
  'Buggatti',
  'BMW',
  'Ferrari',
  'Ford',
  'Lamborghini',
  'Land Rover',
  'Mazda',
  'Mclaren',
  'Mercedes-Benz',
  'Porshe',
  'RollsRoyce',
  'Tesla',
  'Toyota'
];
final sizedboc = const SizedBox(
  height: 10,
);

class _UserHomePageNewState extends State<UserHomePageNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/new/white.jpg',
                ),
                fit: BoxFit.cover,
                opacity: .2)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //MAIN CONTAINER STARTS HERE
              Container(
                width: MediaQuery.of(context).size.width * double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Advertisement(),
                    sizedboc, sizedboc, sizedboc,
                    //FIRST CARDS FOR THE BRANDS
                    Center(
                      child: Image.asset(
                        'assets/bg/brands.png',
                        width: MediaQuery.of(context).size.height * .16,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(0, 208, 208, 208),
                          ),
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    sizedboc,
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        SpecificBrand(
                                                          name: carcategory[
                                                              index],
                                                        )));
                                          },
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      carimg[index],
                                                    ),
                                                    fit: BoxFit.contain)),
                                          ),
                                        )),
                                    Row(
                                      children: [
                                        Text(carcategory[index],
                                            style: GoogleFonts.gowunBatang(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .037,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: carcategory.length,
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
              sizedboc,
              Image.asset(
                'assets/bg/popular.png',
                width: MediaQuery.of(context).size.height * .18,
              ),
              sizedboc, sizedboc,
              popularinventories(),
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
