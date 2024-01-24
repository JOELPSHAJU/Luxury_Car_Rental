import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
                  sizedboc,
                  sizedboc,
                  Text(
                    'ADD PROFILE DETAILS',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height * .02),
                  ),
                ],
              ),
              Row(
                children: [
                  text(text: 'SELECT PROFILE PICTURE'),
                  IconButton(
                      onPressed: () {
                        imagepicker();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                        size: 30,
                      )),
                ],
              ),
              Row(
                children: [
                  text(text: 'SELECT COVER PICTURE'),
                  IconButton(
                      onPressed: () {
                        coverimagepicker();
                      },
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                        size: 30,
                      )),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textformfield(
                        hint: 'Full Name',
                        controller: _name,
                        keyboardtype: TextInputType.name),
                    textformfield(
                        hint: 'Address',
                        controller: _address,
                        keyboardtype: TextInputType.name),
                    textformfield(
                        hint: 'Age',
                        controller: _age,
                        keyboardtype: TextInputType.name),
                    textformfield(
                        hint: "Email",
                        controller: _email,
                        keyboardtype: TextInputType.name),
                    textformfield(
                        hint: 'Phone Number',
                        controller: _phonenumber,
                        keyboardtype: TextInputType.name),
                    textformfield(
                        hint: 'Pin Code',
                        controller: _pincode,
                        keyboardtype: TextInputType.name),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
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
                      MaterialPageRoute(builder: (ctx2) => ProfiePage()),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  height: MediaQuery.of(context).size.height * .07,
                  color: ProjectColors.primarycolor1,
                  child: Center(
                    child: Text(
                      'ADD DETAILS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ProjectColors.black,
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
      if (ProfileImageUrl.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: text(text: 'No Image Selected')));
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
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: text(text: 'No Image Selected')));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
