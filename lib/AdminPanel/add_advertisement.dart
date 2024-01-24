import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class AddAdvertisement extends StatefulWidget {
  AddAdvertisement({super.key});

  @override
  State<AddAdvertisement> createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    advertisementsReference =
        FirebaseFirestore.instance.collection('advertisements');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.lightgrey,
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          'ADD ADVERTISEMENTS',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ProjectColors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .18,
              child: Column(
                children: [
                  sizedboc,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          text(text: 'SELECT IMAGE  '),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Tap Button to Upload'.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * .02),
                        ),
                        GestureDetector(
                          onTap: () {
                            final Map<String, dynamic> image = {
                              "image": imageurl
                            };
                            DatabaseMethods().addAdvertismentforuser(image);
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .05,
                            width: MediaQuery.of(context).size.width * .4,
                            color: ProjectColors.primarycolor1,
                            child: Center(
                                child: Text(
                              'UPLOAD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .023),
                            )),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: advertisementsReference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final imagePaths = snapshot.data!.docs
                      .map((doc) => doc.get('image') as String)
                      .toList();

                  return ListView.builder(
                    itemCount: imagePaths.length,
                    itemBuilder: (context, index) {
                      final imagePath = imagePaths[index];
                      final doc = snapshot.data!.docs[index];
                      final docId = doc.id;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .28,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 255, 247, 247)),
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * .2,
                                width: MediaQuery.of(context).size.width *
                                    double.infinity,
                                child: Image.network(
                                  imagePath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(text: 'Delete Advertisement'),
                                  IconButton(
                                      onPressed: () {
                                        deleteAdvertisement(docId);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteAdvertisement(String docId) async {
    try {
      await advertisementsReference.doc(docId).delete();
    } catch (error) {}
  }

  late String imageurl = '';

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageurl = await uploadImage(image);
      setState(() {});
    }
  }

  Future<String> uploadImage(var image) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('Advertisements/${image.name}');
    final UploadTask uploadTask = ref.putFile(File(image.path));

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return imageurl = downloadUrl;
  }
}
