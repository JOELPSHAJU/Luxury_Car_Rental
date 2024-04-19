import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/add_profile.dart';

import 'package:luxurycars/UserPanel/update_profile_detail.dart';
import 'package:luxurycars/main.dart';

class ProfileDetails extends StatefulWidget {
  final String user;
  const ProfileDetails({super.key, required this.user});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

datas(
    {required context,
    required fontstyle,
    required text,
    required label,
    required fontdatastyle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(
          label,
          style: fontstyle(context: context),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            text,
            style: fontdatastyle(context: context),
          ),
        ),
      ),
      Divider(
        color: const Color.fromARGB(255, 214, 214, 214),
      )
    ],
  );
}

String? email;
String? password;

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
    CollectionReference profileCollection =
        FirebaseFirestore.instance.collection('profile');
    try {
      final querySnapshot = await profileCollection.doc(email.toString()).get();
      if (querySnapshot.exists) {
        setState(() {
          docData = querySnapshot.data() as Map<String, dynamic>;
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
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * .018,
        color: Color.fromARGB(255, 173, 173, 173),
        fontWeight: FontWeight.w500);
  }

  fontdatastyle({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.height * .018,
        color: Color.fromARGB(255, 0, 0, 0),
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
      return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .25,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/new/cover.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * .27,
                  top: MediaQuery.of(context).size.height * .15,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ProjectColors.white, width: 4.2),
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                          image: AssetImage('assets/new/avatar.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person),
                Text(
                  email.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * .05,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => AddProfileDetails()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Icon(
                    Icons.edit,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .27,
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    docData!['fullname'],
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * .05,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              sizedb,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bio: ${docData!['bio']}',
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 82, 82, 82)),
                  ),
                ],
              ),
              sizedb,
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Map<String, String> details = {
                          'fullname': docData!['fullname'],
                          'age': docData!['age'],
                          'bio': docData!['bio'],
                          'gender': docData!['gender'],
                          'address': docData!['age'],
                          'pincode': docData!['pincode'],
                          'phone': docData!['phonenumber'],
                          'profile': docData!['profile'],
                          'Cover': docData!['Cover'],
                        };
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (ctx) => UpdateProfile(details: details)));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Edit Profile',
                            style: GoogleFonts.oswald(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.edit,
                              color: const Color.fromARGB(255, 126, 126, 126),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              sizedb,
              sizedb,
              datas(
                  label: 'Email',
                  context: context,
                  fontstyle: fontstyle,
                  text: email.toString(),
                  fontdatastyle: fontdatastyle),
              sizedb,
              datas(
                  label: 'Age',
                  context: context,
                  fontstyle: fontstyle,
                  text: '${docData!['age']}',
                  fontdatastyle: fontdatastyle),
              sizedb,
              datas(
                  label: 'Gender',
                  context: context,
                  fontstyle: fontstyle,
                  text: '${docData!['gender']}',
                  fontdatastyle: fontdatastyle),
              sizedb,
              datas(
                  label: 'Address',
                  context: context,
                  fontstyle: fontstyle,
                  text: '${docData!['address']}',
                  fontdatastyle: fontdatastyle),
              sizedb,
              datas(
                  label: 'Phone Number',
                  context: context,
                  fontstyle: fontstyle,
                  text: '${docData!['phonenumber']}',
                  fontdatastyle: fontdatastyle),
              sizedb,
              datas(
                  label: 'Zip Code',
                  context: context,
                  fontstyle: fontstyle,
                  text: '${docData!['pincode']}',
                  fontdatastyle: fontdatastyle),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              )
            ]),
          ));
    }
  }
}
