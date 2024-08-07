import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';
import 'package:luxurycars/UserPanel/profile_page.dart';

enum Gender { male, female }

Gender? selectedGender;

class UpdateProfileDetails extends StatefulWidget {
  final Map<String, String> details;
  UpdateProfileDetails({super.key, required this.details});

  @override
  State<UpdateProfileDetails> createState() => _UpdateProfileDetailsState();
}

class _UpdateProfileDetailsState extends State<UpdateProfileDetails> {
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

  // ignore: non_constant_identifier_names
  String ProfileImageUrl = '';

  String CoverImageUrl = '';

  String NewProfileImageUrl = '';

  String NewCoverImageUrl = '';

  @override
  Widget build(BuildContext context) {
    print(widget.details['id']);
    NewProfileImageUrl = widget.details['profile'].toString();
    NewCoverImageUrl = widget.details['Cover'].toString();
    _name.text = widget.details['fullname'].toString();

    _age.text = widget.details['age'].toString();
    bio.text = widget.details['bio'].toString();
    address.text = widget.details['address'].toString();
    _phonenumber.text = widget.details['phone'].toString();
    _pincode.text = widget.details['pincode'].toString();

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
          'UPDATE PROFILE DETAILS',
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
                    const Text(
                      'SELECT NEW PROFILE PICTURE',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NewProfileImageUrl.isNotEmpty
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(NewProfileImageUrl),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: const DecorationImage(
                                    image: const AssetImage(
                                        'assets/new/avatar.png'),
                                    fit: BoxFit.cover)),
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
                        : Container(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'SELECT NEW COVER PICTURE',
                    ),
                    IconButton(
                        onPressed: () {
                          coverimagepicker();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.add_a_photo_rounded,
                          color: ProjectColors.primarycolor1,
                          size: 25,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NewCoverImageUrl.isNotEmpty
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(NewCoverImageUrl),
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
                    CoverImageUrl.isNotEmpty
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                    image: NetworkImage(CoverImageUrl),
                                    fit: BoxFit.cover)),
                          )
                        : Container(),
                  ],
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
                        'UPDATE DETAILS',
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
    String id = widget.details['id'].toString();

    DatabaseMethods().UpdateProfile(
        widget.details['id'].toString(),
        _name.text,
        _age.text,
        bio.text,
        address.text,
        _pincode.text,
        _phonenumber.text,
        ProfileImageUrl,
        CoverImageUrl);
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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
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
      setState(() {});
      if (CoverImageUrl.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'No Image Selected',
        )));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }
}
