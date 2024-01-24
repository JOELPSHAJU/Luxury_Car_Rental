import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/Bookings.dart';
import 'package:luxurycars/UserPanel/Cart.dart';
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
  AddtoCart(),
  BookingsPage(),
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: ProjectColors.black),
            backgroundColor: ProjectColors.primarycolor1,
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
                  icon: Icon(Icons.notifications, color: ProjectColors.black))
            ],
          ),
          drawer: UserNavigation(),
          body: pages[_currentindex],
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              color: ProjectColors.primarycolor1,
              buttonBackgroundColor: ProjectColors.primarycolor1,
              onTap: (index) {
                setState(() {
                  _currentindex = index;
                });
              },
              animationDuration: const Duration(milliseconds: 300),
              items: [
                Icon(Icons.home, size: 30, color: ProjectColors.black),
                Icon(
                  Icons.search,
                  size: 30,
                  color: ProjectColors.black,
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: ProjectColors.black,
                ),
                Icon(Icons.book, size: 30, color: ProjectColors.black)
              ])),
    );
  }
}
