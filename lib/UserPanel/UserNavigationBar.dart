import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/Notifications.dart';
import 'package:luxurycars/UserPanel/privacy_policies.dart';

import 'package:luxurycars/UserPanel/profile_page.dart';
import 'package:luxurycars/UserPanel/rentalrulesuser.dart';

import 'package:luxurycars/authentication/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNavigation extends StatefulWidget {
  const UserNavigation({super.key});

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  Map<String, dynamic>? docData;
  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    CollectionReference requestReplyCollection =
        FirebaseFirestore.instance.collection('profile');
    try {
      final querySnapshot =
          await requestReplyCollection.where('id', isEqualTo: email).get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;

        setState(() {
          docData = docSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          docData = {};
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: docData?['fullname'] != null
                ? Text('${docData?['fullname']}',
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.w700,
                        color: ProjectColors.white,
                        fontSize: MediaQuery.of(context).size.height * .02))
                : const Text('Guest0123'),
            accountEmail: docData?['email'] != null
                ? Text('${docData?['email']}',
                    style: GoogleFonts.signikaNegative(
                        fontWeight: FontWeight.w700,
                        color: ProjectColors.white,
                        fontSize: MediaQuery.of(context).size.height * .02))
                : const Text('Guest0123@gmail.com'),
            currentAccountPicture: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: docData?['profile'] != null
                    ? Image.network(
                        "${docData?['profile']}",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    : Image.asset(
                        'assets/new/avatar.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            decoration: BoxDecoration(
              image: docData != null &&
                      docData!['Cover'] != null &&
                      docData!['Cover'].isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage("${docData!['Cover']}"),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: const AssetImage('assets/new/cover.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 30,
              color: ProjectColors.primarycolor1,
            ),
            title: Text('Profile',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const ProfiePage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.list_alt_rounded,
              size: 30,
              color: ProjectColors.primarycolor1,
            ),
            title: Text('Rental Rules',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx2) => ViewRentalUser()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notification_important,
                size: 30, color: ProjectColors.primarycolor1),
            title: Text(
              'Notifications',
              style: GoogleFonts.signikaNegative(
                  fontWeight: FontWeight.bold,
                  color: ProjectColors.black,
                  fontSize: MediaQuery.of(context).size.height * .02),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const Notifications()));
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .39,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip,
              color: ProjectColors.primarycolor1,
              size: 30,
            ),
            title: Text('Privacy Policies',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const PrivacyPolicies()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,
                size: 30, color: ProjectColors.primarycolor1),
            title: Text('Sign out',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.bold,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
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
          title: Text(
            'Do you really want to sign out?',
            style: GoogleFonts.signikaNegative(
                fontWeight: FontWeight.bold,
                color: ProjectColors.primarycolor1,
                fontSize: MediaQuery.of(context).size.height * .02),
          ),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 109, 109, 109),
                        fontWeight: FontWeight.bold))),
            OutlinedButton(
              onPressed: () async {
                final sharedprefs = await SharedPreferences.getInstance();
                await sharedprefs.clear();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx2) => const LoginPage()),
                    (route) => false);
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.signikaNegative(
                    color: ProjectColors.primarycolor1,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
