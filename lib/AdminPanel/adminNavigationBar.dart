import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/UpdateInventory.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/AdminPanel/addRentalRules.dart';
import 'package:luxurycars/AdminPanel/add_advertisement.dart';
import 'package:luxurycars/AdminPanel/add_notification.dart';
import 'package:luxurycars/AdminPanel/bookingrequests.dart';
import 'package:luxurycars/AdminPanel/deleteInventory.dart';
import 'package:luxurycars/AdminPanel/popular_inventories.dart';
import 'package:luxurycars/AdminPanel/viewInventory.dart';
import 'package:luxurycars/AdminPanel/viewbookings.dart';
import 'package:luxurycars/AdminPanel/viewrentalrules.dart';
import 'package:luxurycars/authentication/Loginpage.dart';

class AdminNavigationBar extends StatelessWidget {
  const AdminNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'GO DRIVE LUXURY RENTAL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'Kochi,Kerala',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage(
                      'assets/latest/bmv.jpg',
                    ),
                    opacity: .5,
                    fit: BoxFit.fitWidth)),
          ),
          ListTile(
            leading: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
            title: const Text('Add Inventory'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.update_outlined,
              size: 30,
            ),
            title: const Text('Update Inventory'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const UpdateInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_outline_rounded,
              size: 30,
            ),
            title: const Text('Delete Inventory'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const DeleteInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.view_carousel_outlined,
              size: 30,
            ),
            title: const Text('View Inventory'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ViewInventories()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rule_rounded,
              size: 30,
            ),
            title: const Text('Add Rental Rules'),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddRentalRules()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rule_folder_outlined,
              size: 30,
            ),
            title: const Text('View Rental Rules'),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ViewRental()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark_border_outlined,
              size: 30,
            ),
            title: const Text('View Booking Requests'),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => BookingRequest()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.book_rounded,
              size: 30,
            ),
            title: const Text('View Bookings'),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx2) => ViewBookings()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.podcasts,
              size: 30,
            ),
            title: const Text('Popular Inventories'),
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => PopularInventories()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notification_add_outlined,
              size: 30,
            ),
            title: const Text('Add Notification'),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => addnotification()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              size: 30,
            ),
            title: const Text('Add Advertisement'),
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => AddAdvertisement()));
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          const Divider(
            thickness: 3,
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 30,
            ),
            title: const Text('Sign out'),
            onTap: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx2) => const LoginScreen()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
