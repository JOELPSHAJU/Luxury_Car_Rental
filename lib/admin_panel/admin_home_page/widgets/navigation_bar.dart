import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/admin_panel/add_advertisement/add_advertisement.dart';
import 'package:luxurycars/admin_panel/add_inventory/addInventorydata.dart';
import 'package:luxurycars/admin_panel/add_notification/add_notification.dart';

import 'package:luxurycars/admin_panel/add_rental_rule/addRentalRules.dart';
import 'package:luxurycars/admin_panel/booking_request/bookingrequests.dart';
import 'package:luxurycars/admin_panel/delete_inventory/deleteInventory.dart';
import 'package:luxurycars/admin_panel/update_inventory/widgets/update_inventory.dart';
import 'package:luxurycars/admin_panel/view_bookings/viewbookings.dart';
import 'package:luxurycars/admin_panel/view_inventory/view_inventory.dart';
import 'package:luxurycars/admin_panel/view_popular_inventories/popular_inventories.dart';
import 'package:luxurycars/admin_panel/view_rental_rules/viewrentalrules.dart';
import 'package:luxurycars/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              size: 23,
              color: Colors.black,
            ),
            title: const Text(
              'Add Inventory',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.update_outlined,
              size: 23,
              color: Colors.black,
            ),
            title: const Text('Update Inventory',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const UpdateInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('Delete Inventory',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const DeleteInventory()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.view_carousel_outlined,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('View Inventory',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const ViewInventories()));
            },
          ),
          const Divider(thickness: 2, color: Colors.black),
          ListTile(
            leading: const Icon(
              Icons.rule_rounded,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('Add Rental Rules',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => AddRentalRules()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.rule_folder_outlined,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('View Rental Rules',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => ViewRental()));
            },
          ),
          const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark_border_outlined,
              size: 23,
              color: Colors.black,
            ),
            title: const Text('View Booking Requests',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const BookingRequest()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.book_rounded,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('View Bookings',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const ViewBookings()));
            },
          ),
          const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          ListTile(
            leading: const Icon(
              Icons.podcasts,
              size: 23,
              color: Colors.black,
            ),
            title: const Text('Popular Inventories',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const PopularInventories()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notification_add_outlined,
              size: 23,
              color: Colors.black,
            ),
            title: const Text('Add Notification',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => addnotification()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.newspaper,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('Add Advertisement',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx2) => const AddAdvertisement()));
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          const Divider(
            thickness: 2,
            color: Color.fromARGB(255, 91, 91, 91),
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
              size: 23,
            ),
            title: const Text('Sign out',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onTap: () async {
              final sharedprefs = await SharedPreferences.getInstance();
              await sharedprefs.clear();
              showSignOutAlert(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> showSignOutAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'Do you really want to sign out?',
            style: GoogleFonts.signikaNegative(
                fontWeight: FontWeight.w600,
                color: ProjectColors.black,
                fontSize: MediaQuery.of(context).size.height * .02),
          ),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel',
                    style: GoogleFonts.signikaNegative(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w600))),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx2) => const LoginPage()),
                    (route) => false);
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.signikaNegative(
                    color: ProjectColors.primarycolor1,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
