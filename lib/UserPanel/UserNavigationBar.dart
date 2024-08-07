// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

import 'package:luxurycars/UserPanel/Notifications.dart';
import 'package:luxurycars/UserPanel/privacy_policies.dart';

import 'package:luxurycars/UserPanel/profile_page.dart';
import 'package:luxurycars/UserPanel/rentalrulesuser.dart';
import 'package:luxurycars/authentication/Auth.dart';

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
    CollectionReference profileCollection =
        FirebaseFirestore.instance.collection('profile');
    try {
      // Directly access the document by its ID
      final docSnapshot = await profileCollection.doc(email).get();
      if (docSnapshot.exists) {
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
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: MediaQuery.of(context).size.height * .02))
                : const Text('Guest0123'),
            accountEmail: docData?['email'] != null
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text('${docData?['email']}',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: ProjectColors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * .02)),
                  )
                : const Text('Guest0123@gmail.com'),
            currentAccountPicture: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.black,
              child: ClipOval(
                child: docData?['profile'] != null
                    ? CachedNetworkImage(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: "${docData?['profile']}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(
                          color: Colors.black,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: 27,
                        ),
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
                      image: AssetImage('assets/new/cover.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 27,
              color: Colors.grey,
            ),
            title: Text('Profile',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const ProfiePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list_alt_rounded,
              size: 27,
              color: Colors.grey,
            ),
            title: Text('Rental Rules',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx2) => ViewRentalUser()));
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.notifications, size: 27, color: Colors.grey),
            title: Text(
              'Notifications',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: ProjectColors.black,
                  fontSize: MediaQuery.of(context).size.height * .02),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const Notifications()));
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip,
              color: Colors.grey,
              size: 27,
            ),
            title: Text('Privacy Policies',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
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
            leading:
                const Icon(Icons.exit_to_app, size: 27, color: Colors.grey),
            title: Text('Sign out',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: ProjectColors.black,
                    fontSize: MediaQuery.of(context).size.height * .02)),
            onTap: () {
              showSignOutAlert(context);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
          ),
          ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            title: Text('Ver 2.0',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: ProjectColors.gray,
                    fontSize: MediaQuery.of(context).size.height * .02)),
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
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                'Sign Out',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
              Text(
                textAlign: TextAlign.center,
                'Do you really want to sign out?',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * .02),
              ),
            ],
          ),
          titlePadding:
              EdgeInsets.only(top: 40, bottom: 30, right: 10, left: 10),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: Text('Cancel',
                    style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 109, 109, 109),
                        fontWeight: FontWeight.w500))),
            OutlinedButton(
              onPressed: () async {
                final sharedprefs = await SharedPreferences.getInstance();
                await sharedprefs.clear();
                Auth().signout();

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (ctx2) => const LoginPage()),
                    (route) => false);
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.poppins(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }
}
