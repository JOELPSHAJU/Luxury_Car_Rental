import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/UserPanel/Notifications.dart';
import 'package:luxurycars/UserPanel/privacy_policies.dart';

import 'package:luxurycars/UserPanel/profile_page.dart';
import 'package:luxurycars/UserPanel/rentalrulesuser.dart';
import 'package:luxurycars/UserPanel/settings.dart';
import 'package:luxurycars/authentication/loginpage.dart';
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
                ? Text('${docData?['fullname']}')
                : const Text('Guest0123'),
            accountEmail: docData?['email'] != null
                ? Text('${docData?['email']}')
                : const Text('Guest0123@gmail.com'),
            currentAccountPicture: CircleAvatar(
              radius: 55,
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
            leading: const Icon(
              Icons.person,
              size: 30,
              color: Colors.grey,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const ProfiePage()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.list_alt_rounded,
              size: 30,
              color: Colors.grey,
            ),
            title: const Text('Rental Rules'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx2) => ViewRentalUser()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notification_important,
              size: 30,
              color: Colors.grey,
            ),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const Notifications()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.grey,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx2) => const SettingsPage()));
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .3,
          ),
          const Divider(
            thickness: 2,
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip,
              color: Colors.grey,
              size: 30,
            ),
            title: const Text('Privacy Policies'),
            onTap: () async {
              final sharedprefs = await SharedPreferences.getInstance();
              await sharedprefs.clear();
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const PrivacyPolicies()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.grey,
            ),
            title: const Text('Sign out'),
            onTap: () async {
              final sharedprefs = await SharedPreferences.getInstance();
              await sharedprefs.clear();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx2) => const LoginPage()),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
