import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/AdminNavigationBar.dart';
import 'package:luxurycars/AdminPanel/advertisements_home.dart';

import 'package:luxurycars/AdminPanel/gridview_admin_home.dart';

import 'package:luxurycars/Universaltools.dart';

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
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      drawer: const AdminNavigationBar(),
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .99,
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
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: ProjectUtils().headingsmall(
                        context: context,
                        text: 'Popular Inventories',
                        color: ProjectColors.primarycolor1),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * .3,
                      width: MediaQuery.of(context).size.width,
                      child: const Gridview_admin()),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: ProjectUtils().headingsmall(
                        context: context,
                        text: 'Advertisements',
                        color: ProjectColors.primarycolor1),
                  ),
                  Expanded(child: AdvertisementGome()),
                  ProjectUtils().sizedbox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'GO ',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .03,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'DRIVE',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .03,
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
