import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/BookingScreens/Bookings.dart';
import 'package:luxurycars/UserPanel/favourate.dart';
import 'package:luxurycars/UserPanel/Notifications.dart';

import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/UserNavigationBar.dart';

import 'package:luxurycars/UserPanel/search_inventory.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

int _currentindex = 0;

List pages = [
  const UserHomePageNew(),
  const SearchInventory(),
  const AddtoCart(),
  const BookingsPage(),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            bottomOpacity: 2,
            surfaceTintColor: Colors.white,
            iconTheme: IconThemeData(color: ProjectColors.primarycolor1),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset(
              'assets/logolettters.png',
              width: 130,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const Notifications()));
                  },
                  icon: Icon(Icons.notifications,
                      color: ProjectColors.primarycolor1))
            ],
          ),
          drawer: const UserNavigation(),
          body: pages[_currentindex],
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.symmetric(
                    horizontal: BorderSide(width: 1, color: Colors.grey))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GNav(
                  gap: 8,
                  color: ProjectColors.primarycolor1,
                  tabBackgroundColor: ProjectColors.primarycolor1,
                  activeColor: Colors.white,
                  padding: const EdgeInsets.all(10),
                  onTabChange: (value) {
                    setState(() {
                      _currentindex = value;
                    });
                  },
                  tabs: const [
                    GButton(
                      icon: Icons.home_outlined,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.favorite,
                      text: 'Favourites',
                    ),
                    GButton(
                      icon: Icons.bookmark_add_outlined,
                      text: 'Bookings',
                    ),
                  ]),
            ),
          )),
    );
  }
}
