import 'package:flutter/material.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/BookingScreens/bookings_done.dart';
import 'package:luxurycars/UserPanel/BookingScreens/orders_done.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          toolbarHeight: 8,
          bottom: TabBar(
            unselectedLabelColor: const Color.fromARGB(255, 100, 100, 100),
            labelColor: ProjectColors.primarycolor1,
            indicatorColor: ProjectColors.primarycolor1,
            tabs: <Widget>[
              Tab(
                text: 'BOOKINGS',
              ),
              Tab(
                text: 'ORDERS',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[BookingsDone(), OrdersDone()],
        ),
      ),
    );
  }
}
