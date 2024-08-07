import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/admin_panel/add_advertisement/add_advertisement.dart';
import 'package:luxurycars/admin_panel/admin_home_page/widgets/advertisements_home.dart';
import 'package:luxurycars/admin_panel/admin_home_page/widgets/gridview_admin_home.dart';
import 'package:luxurycars/admin_panel/admin_home_page/widgets/navigation_bar.dart';
import 'package:luxurycars/admin_panel/view_popular_inventories/popular_inventories.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final mediaquerywidth = .4;

  // ignore: prefer_typing_uninitialized_variables
  var MediaQueryfontsize;

  final textstyle = const TextStyle(
      color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  final containerDecoration = BoxDecoration(
      color: const Color.fromARGB(133, 0, 0, 0),
      borderRadius: BorderRadius.circular(0),
      border: Border.all(color: Colors.white, width: 2));

  Widget container(
      {required icon,
      required void Function() function,
      required width,
      required textsize,
      required String text}) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: width,
            height: 110,
            decoration: containerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  text,
                  style: textstyle,
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryfontsize = MediaQuery.of(context).size.width * .3;
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(146, 0, 0, 0),
        elevation: 0,
      ),
      drawer: const AdminNavigationBar(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
          child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .26,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/bg/admin_home_front.jpg',
                            ),
                            fit: BoxFit.cover)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .32,
                            child: Text(
                              ''' " A Satisfied Customer Is The Best Business Strategy "\n\n- Michael LeBoeuf -''',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.height * .016,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 20),
                          child: Text(
                            'Popular Inventories',
                            style: GoogleFonts.roboto(
                                fontSize:
                                    MediaQuery.of(context).size.width * .05,
                                color: const Color.fromARGB(255, 138, 138, 138),
                                fontWeight: FontWeight.bold),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (s) => const PopularInventories()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: ProjectUtils().headingsmall(
                              context: context,
                              text: 'View More',
                              color: ProjectColors.primarycolor1),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      child: const Gridview_admin()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Advertisements',
                            style: GoogleFonts.roboto(
                                color: const Color.fromARGB(255, 138, 138, 138),
                                fontSize:
                                    MediaQuery.of(context).size.width * .05,
                                fontWeight: FontWeight.bold),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (s) => const AddAdvertisement()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: ProjectUtils().headingsmall(
                              context: context,
                              text: 'View More',
                              color: ProjectColors.primarycolor1),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: AdvertisementGome()),
                  ProjectUtils().sizedbox20,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GO ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'DRIVE',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ProjectUtils().sizedbox20,
                ],
              ))),
    ));
  }
}
