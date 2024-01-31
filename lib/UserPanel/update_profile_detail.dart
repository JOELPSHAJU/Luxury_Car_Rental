import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/profile_page.dart';

import 'package:luxurycars/main.dart';

class UpdateProfile extends StatefulWidget {
  final Map<String, String> details;
  UpdateProfile({super.key, required this.details});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

Widget text({required text, required context}) {
  return Text(
    text,
    style: GoogleFonts.signikaNegative(
        fontSize: MediaQuery.of(context).size.height * .018,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0)),
  );
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _age = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phonenumber = TextEditingController();

  final TextEditingController _pincode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;
  String pofileImageUrl = '';
  String coverImageUrl = '';
  @override
  Widget build(BuildContext context) {
    _name.text = widget.details['name'].toString();
    _age.text = widget.details['age'].toString();
    _email.text = widget.details['email'].toString();
    _phonenumber.text = widget.details['phone'].toString();
    _address.text = widget.details['address'].toString();
    _pincode.text = widget.details['pincode'].toString();
    pofileImageUrl = widget.details['profile'].toString();
    coverImageUrl = widget.details['cover'].toString();
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    'ENTER PROFILE DETAILS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * .02,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  text(text: 'SELECT PROFILE PICTURE', context: context),
                  IconButton(
                      onPressed: () {
                        imagepicker();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        color: ProjectColors.primarycolor1,
                        size: 25,
                      )),
                ],
              ),
              pofileImageUrl.isNotEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(
                                pofileImageUrl,
                              ),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: const AssetImage('assets/new/avatar.png'),
                              fit: BoxFit.cover)),
                    ),
              Row(
                children: [
                  text(text: 'SELECT COVER PICTURE', context: context),
                  IconButton(
                      onPressed: () {
                        coverimagepicker();
                      },
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        color: ProjectColors.primarycolor1,
                        size: 25,
                      )),
                ],
              ),
              coverImageUrl.isNotEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(coverImageUrl),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: const AssetImage('assets/new/cover.jpg'),
                              fit: BoxFit.cover)),
                    ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _name,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Full Name'),
                    ProjectUtils().sizedbox10,
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _address,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Address'),
                    ProjectUtils().sizedbox10,
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _age,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Age'),
                    ProjectUtils().sizedbox10,
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _email,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Email Address'),
                    ProjectUtils().sizedbox10,
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _phonenumber,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Phone Number'),
                    ProjectUtils().sizedbox10,
                    ProjectUtils().textformfieldaddinventory(
                        context: context,
                        controller: _pincode,
                        keyboardtype: TextInputType.name,
                        focusedcolor: ProjectColors.primarycolor1,
                        enabled: Colors.grey,
                        hint: 'Pin Code'),
                    ProjectUtils().sizedbox10,
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              text(
                  text: 'It May Take Some Time To Upload The Image',
                  context: context),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    updateprofile(
                        _name.text,
                        _age.text,
                        _email.text,
                        _phonenumber.text,
                        _address.text,
                        _pincode.text,
                        email.toString(),
                        pofileImageUrl,
                        coverImageUrl);
                    setState(() {});
                    _name.clear();
                    _address.clear();
                    _age.clear();
                    _email.clear();
                    _phonenumber.clear();
                    _pincode.clear();

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => ProfiePage()));
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: ProjectColors.primarycolor1,
                  ),
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Center(
                    child: Text(
                      'UPDATE DETAILS',
                      style: GoogleFonts.signikaNegative(
                          fontWeight: FontWeight.bold,
                          color: ProjectColors.white,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateprofile(
      String name,
      String age,
      String email,
      String phoneNumber,
      String address,
      String pincode,
      String id,
      String profile,
      String cover) {
    return FirebaseFirestore.instance
        .collection("profile")
        .doc(updateuseridprofile)
        .update({
      'address': address,
      'age': age,
      'email': email,
      'fullname': name,
      'id': id,
      'phonenumber': phoneNumber,
      'pincode': pincode,
      'Cover': cover,
      'profile': profile
    });
  }

  imagepicker() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('Profilepic');
    Reference referenceDirImagtoupload = referenceDirImage.child(filename);
    try {
      await referenceDirImagtoupload.putFile(File(file.path));
      pofileImageUrl = await referenceDirImagtoupload.getDownloadURL();
      if (pofileImageUrl.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            // ignore: use_build_context_synchronously
            .showSnackBar(SnackBar(
                // ignore: use_build_context_synchronously
                content: text(text: 'No Image Selected', context: context)));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }

  coverimagepicker() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('CoverPic');
    Reference referenceDirImagtoupload = referenceDirImage.child(filename);
    try {
      await referenceDirImagtoupload.putFile(File(file.path));
      coverImageUrl = await referenceDirImagtoupload.getDownloadURL();
      if (coverImageUrl.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // ignore: use_build_context_synchronously
            content: text(text: 'No Image Selected', context: context)));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
