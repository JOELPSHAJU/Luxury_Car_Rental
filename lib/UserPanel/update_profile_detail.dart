import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';

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
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * .02,
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
    coverImageUrl = widget.details['Cover'].toString();
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
                      },
                      icon: const Icon(
                        Icons.add_a_photo_rounded,
                        size: 30,
                      )),
                ],
              ),
              Row(
                children: [
                  text(text: 'SELECT COVER PICTURE', context: context),
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
            content: text(text: 'No Image Selected', context: context)));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
