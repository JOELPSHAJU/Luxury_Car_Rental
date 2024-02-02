import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/add_profile_detail.dart';
import 'package:luxurycars/UserPanel/update_profile_detail.dart';
import 'package:luxurycars/main.dart';

class ProfileDetails extends StatefulWidget {
  final String user;
  const ProfileDetails({super.key, required this.user});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

String? email;

class _ProfileDetailsState extends State<ProfileDetails> {
  Map<String, dynamic>? docData;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    User? user = FirebaseAuth.instance.currentUser;

    email = user?.email;
  }

  String name = '';
  String age = '';
  String address = '';
  String emails = '';
  String pincode = '';
  String phone = '';
  String Cover = '';
  String profile = '';

  Future<void> fetchData() async {
    CollectionReference requestReplyCollection =
        FirebaseFirestore.instance.collection('profile');
    try {
      final querySnapshot = await requestReplyCollection
          .where('id', isEqualTo: widget.user)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        String id = docSnapshot.id;
        updateuseridprofile = id;

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

  fontstyle({required context}) {
    return GoogleFonts.signikaNegative(
        fontSize: MediaQuery.of(context).size.height * .02,
        color: Colors.grey,
        fontWeight: FontWeight.w500);
  }

  fontdatastyle({required context}) {
    return GoogleFonts.signikaNegative(
        fontSize: MediaQuery.of(context).size.height * .02,
        color: ProjectColors.primarycolor1,
        fontWeight: FontWeight.w500);
  }

  final sizedb = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    if (docData == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (docData!.isEmpty) {
      return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  'assets/new/cover.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            child: Center(
                child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                    width: 3, color: Color.fromARGB(255, 255, 255, 255)),
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                    image: AssetImage(
                      'assets/new/avatar.png',
                    ),
                    fit: BoxFit.cover),
              ),
            )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .09,
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * .6,
                          child: Addprofile());
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: ProjectColors.primarycolor1,
                      borderRadius: BorderRadius.circular(15)),
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      sizedboc,
                      sizedboc,
                      Text(
                        'ADD PROFILE DETAILS',
                        style: GoogleFonts.signikaNegative(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.white,
                            fontSize: MediaQuery.of(context).size.height * .02),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      name = docData!['fullname'];
      age = docData!['age'];
      address = docData!['address'];
      pincode = docData!['pincode'];
      phone = docData!['phonenumber'];
      emails = docData!['email'];
      profile = docData!['profile'];
      Cover = docData!['Cover'];
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
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
              child: Center(
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: ProjectColors.white, width: 4.2),
                      borderRadius: BorderRadius.circular(100),
                      image: docData != null &&
                              docData!['profile'] != null &&
                              docData!['profile'].isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage("${docData!['profile']}"),
                              fit: BoxFit.cover,
                            )
                          : const DecorationImage(
                              image: AssetImage('assets/new/avatar.png'),
                              fit: BoxFit.cover,
                            )),
                ),
              ),
            ),
            sizedb,
            sizedb,
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Personal details  ',
                      style: GoogleFonts.signikaNegative(
                          fontSize: MediaQuery.of(context).size.height * .023,
                          fontWeight: FontWeight.bold,
                          color: ProjectColors.primarycolor1),
                    ),
                  ],
                )),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Full Name : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['fullname']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ' Age : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['age']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ' Email : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['email']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ' Phone Number : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['phonenumber']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ' Address : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['address']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    ' Zip Code : ',
                    style: fontstyle(context: context),
                  ),
                  Text(
                    '${docData!['pincode']}',
                    style: fontdatastyle(context: context),
                  ),
                ],
              ),
            ),
            sizedb,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Map<String, String> data = {
                      "name": name,
                      "age": age,
                      "email": emails,
                      "phone": phone,
                      "address": address,
                      "pincode": pincode,
                      "cover": Cover,
                      "profile": profile
                    };
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * .6,
                              child: UpdateProfile(
                                details: data,
                              ));
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ProjectColors.primarycolor1,
                    ),
                    child: Center(
                      child: Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.white,
                            fontSize: MediaQuery.of(context).size.height * .02),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
