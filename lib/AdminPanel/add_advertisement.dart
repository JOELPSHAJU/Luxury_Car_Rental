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
        toolbarHeight: 40,
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          'ADD ADVERTISEMENTS',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .02,
              fontWeight: FontWeight.bold,
              color: ProjectColors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
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
              height: MediaQuery.of(context).size.height * .15,
              child: Column(
                children: [
                  sizedboc,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await pickImage();
                        final Map<String, dynamic> image = {"image": imageurl};
                        if (imageurl.isNotEmpty) {
                          DatabaseMethods().addAdvertismentforuser(image);
                        }

                        imageurl = '';
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SELECT IMAGE  ',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * .02,
                                fontWeight: FontWeight.bold,
                                color: ProjectColors.primarycolor1),
                          ),
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: ProjectColors.white,
                            weight: 3.4,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'It May Take Some Time To Upload The Image.',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .015,
                        color: ProjectColors.primarycolor1,
                        fontWeight: FontWeight.w400),
                  ),
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
                              color: Color.fromARGB(255, 255, 255, 255)),
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
                              sizedboc,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(text: 'Delete Advertisement'),
                                  IconButton(
                                      onPressed: () {
                                        deleteAdvertisement(docId);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Color.fromARGB(255, 230, 15, 0),
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
