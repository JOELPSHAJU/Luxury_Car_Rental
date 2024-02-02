// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

import 'package:luxurycars/UserPanel/profile_page.dart';

class Addprofile extends StatefulWidget {
  Addprofile({super.key});

  @override
  State<Addprofile> createState() => _AddprofileState();
}

class _AddprofileState extends State<Addprofile> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final TextEditingController _age = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _phonenumber = TextEditingController();

  final TextEditingController _pincode = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  String ProfileImageUrl = '';
  String CoverImageUrl = '';
  late String? email = user?.email;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.red,
                        weight: 3.3,
                      ))
                ],
              ),
              Text(
                'ADD PROFILE DETAILS',
                style: GoogleFonts.signikaNegative(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * .05),
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  text(context: context, text: 'SELECT PROFILE PICTURE'),
                  IconButton(
                      onPressed: () {
                        imagepicker();
                      },
                      icon: Icon(
                        Icons.add_a_photo_rounded,
                        color: ProjectColors.primarycolor1,
                        size: 25,
                      )),
                ],
              ),
              ProfileImageUrl.isNotEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(ProfileImageUrl),
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
                  text(context: context, text: 'SELECT COVER PICTURE'),
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
              ProfileImageUrl.isNotEmpty
                  ? Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: NetworkImage(CoverImageUrl),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: const DecorationImage(
                              image: AssetImage('assets/new/cover.jpg'),
                              fit: BoxFit.cover)),
                    ),
              sizedboc,
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
              GestureDetector(
                onTap: () {
                  if (ProfileImageUrl.isEmpty || CoverImageUrl.isEmpty) {
                    ProjectUtils().errormessage(
                        context: context, text: 'Please Select A Image!');
                  }
                  if (_formKey.currentState!.validate()) {
                    uploaddata();
                    setState(() {});
                    _name.clear();
                    _address.clear();
                    _age.clear();
                    _email.clear();
                    _phonenumber.clear();
                    _pincode.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (ctx2) => const ProfiePage()),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ProjectColors.primarycolor1,
                  ),
                  width: MediaQuery.of(context).size.width * .7,
                  height: MediaQuery.of(context).size.height * .07,
                  child: Center(
                    child: Text(
                      'ADD DETAILS',
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
        ),
      ),
    );
  }

  uploaddata() {
    Map<String, dynamic> profile = {
      "fullname": _name.text,
      "address": _address.text,
      "age": _age.text,
      "email": _email.text,
      "phonenumber": _phonenumber.text,
      "pincode": _pincode.text,
      "id": email.toString(),
      "profile": ProfileImageUrl,
      "Cover": CoverImageUrl
    };
    DatabaseMethods().addprofiledetails(profile);
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
      ProfileImageUrl = await referenceDirImagtoupload.getDownloadURL();
      setState(() {});
      if (ProfileImageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text(context: context, text: 'No Image Selected')));
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
      CoverImageUrl = await referenceDirImagtoupload.getDownloadURL();
      if (CoverImageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text(context: context, text: 'No Image Selected')));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
