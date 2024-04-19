import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/profile_page.dart';


enum Gender { male, female }

Gender? selectedGender;

class AddProfileDetails extends StatefulWidget {
  AddProfileDetails({super.key});

  @override
  State<AddProfileDetails> createState() => _AddProfileDetailsState();
}

class _AddProfileDetailsState extends State<AddProfileDetails> {
  Gender? selectedGender;

  late String genderText;

  final TextEditingController _name = TextEditingController();

  final TextEditingController _age = TextEditingController();

  final TextEditingController bio = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController _phonenumber = TextEditingController();

  final TextEditingController _pincode = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isCheckedfemale = false;                                  
  bool isCheckedmale = false;

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;

  String ProfileImageUrl = '';

  String CoverImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back, 
            color: Colors.white,
          ),
        ),
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          'ADD PROFILE DETAILS',
          style: GoogleFonts.signikaNegative(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 231, 231, 231),
              fontSize: MediaQuery.of(context).size.width * .05),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                       'SELECT PROFILE PICTURE',
                    ),
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
                                image:
                                    const AssetImage('assets/new/avatar.png'),
                                fit: BoxFit.cover)),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    'SELECT COVER PICTURE',
                    ),
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
                    children: [
                      ProjectUtils().textformfieldaddinventory(
                          context: context,
                          controller: _name,
                          keyboardtype: TextInputType.name,
                          focusedcolor: ProjectColors.primarycolor1,
                          enabled: Colors.grey,
                          hint: 'Full Name'),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                               'Select Gender',
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: Gender.male,
                                groupValue: selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              const Text('Male'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: Gender.female,
                                groupValue: selectedGender,
                                onChanged: (Gender? value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              const Text('Female'),
                            ],
                          ),
                        ],
                      ),
                      ProjectUtils().sizedbox10,
                      ProjectUtils().textformfieldaddinventory(
                          context: context,
                          controller: bio,
                          keyboardtype: TextInputType.name,
                          focusedcolor: ProjectColors.primarycolor1,
                          enabled: Colors.grey,
                          hint: 'Add bio'),
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
                          controller: _phonenumber,
                          keyboardtype: TextInputType.name,
                          focusedcolor: ProjectColors.primarycolor1,
                          enabled: Colors.grey,
                          hint: 'Phone Number'),
                      ProjectUtils().sizedbox10,
                      ProjectUtils().textformfieldaddinventory(
                          context: context,
                          controller: address,
                          keyboardtype: TextInputType.name,
                          focusedcolor: ProjectColors.primarycolor1,
                          enabled: Colors.grey,
                          hint: 'Address'),
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
                    if (selectedGender != null) {
                      genderText =
                          selectedGender == Gender.male ? 'Male' : 'Female';
                    } else {
                      ProjectUtils().errormessage(
                          context: context, text: 'Please Select Gender!');
                    }
                    if (ProfileImageUrl.isEmpty || CoverImageUrl.isEmpty) {
                      ProjectUtils().errormessage(
                          context: context, text: 'Please Select A Image!');
                    }
                    if (_formKey.currentState!.validate()) {
                      uploaddata();
                      setState(() {});
                      _name.clear();
                      address.clear();
                      bio.clear();
                      _age.clear();

                      _phonenumber.clear();
                      _pincode.clear();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (ctx2) => const ProfiePage()),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ProjectColors.primarycolor1,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ProjectColors.white, width: 2),
                    ),
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .06,
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
      ),
    );
  }

  uploaddata() {
    Map<String, dynamic> profile = {
      "fullname": _name.text,
      "age": _age.text,
      "bio": bio.text,
      "gender": genderText,
      "phonenumber": _phonenumber.text,
      "pincode": _pincode.text,
      "address": address.text,
      "profile": ProfileImageUrl,
      "Cover": CoverImageUrl
    };
    DatabaseMethods().addprofiledetails(profile, email.toString());
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
            content:Text(
        'No Image Selected',
        )));
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
            content: Text(
         'No Image Selected',
        )));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
