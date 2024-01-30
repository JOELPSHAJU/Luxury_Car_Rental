import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

class UpdateInventoryFields extends StatefulWidget {
  String id;
  UpdateInventoryFields({super.key, required this.id});

  @override
  State<UpdateInventoryFields> createState() => _UpdateInventoryFieldsState();
}

final enginedisplacement = TextEditingController();
final maxpower = TextEditingController();
final maxtorque = TextEditingController();
final priceperday = TextEditingController();
final overview = TextEditingController();
final modelname = TextEditingController();
final zerotohundred = TextEditingController();
final seatingcapacity = TextEditingController();
final numberplate = TextEditingController();
final fueltank = TextEditingController();
final groundclearence = TextEditingController();
final gearbox = TextEditingController();
//form key
final formkeyupdateinventory = GlobalKey<FormState>();

List<XFile>? _images;
List<String> firebaseimages = [];
List<String> _imageUrls = [];
String firebaseimage = '';

// ignore: non_constant_identifier_names
String MainImage = '';

const List<String> categorylist = <String>[
  'Sports',
  'Luxury',
  'Hybrid',
  'Fully Electric',
  'Coupe',
  'Convertible',
  'Sedan',
  'Hatchback',
  'SUV',
  'Crossover',
  'Pickup Truck',
  'Minivan',
  'Special'
];
//transmission dropdownbutton data
const List<String> Transmissionvalues = <String>[
  'Full Automatic',
  'Manual',
  'Automatic + Manual'
];
//drop down button fuel type
const List<String> fuelType = <String>['Petrol', 'Diesel', 'Electric'];

class _UpdateInventoryFieldsState extends State<UpdateInventoryFields> {
  Map<String, dynamic> carData = {};

  void _getCarDetails() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('cardetails')
        .doc(widget.id)
        .get();
    if (snapshot.exists) {
      setState(() {
        carData = snapshot.data() as Map<String, dynamic>;
        if (firebaseimages.isEmpty) {
          final List<dynamic> firebseimg = carData['Image Urls'];
          for (int i = 0; i < firebseimg.length; i++) {
            firebaseimages.add(firebseimg[i].toString());
          }
        }
      });
    } else {}
  }

  late String categorydropdownvalue = categorylist.first;
  late String companydropdownvalue = ProjectUtils.companylist.first;
  late String fueltypedropdownvalue = fuelType.first;
  late String transmissiondropdownvalue = Transmissionvalues.first;

  @override
  Widget build(BuildContext context) {
    enginedisplacement.text = carData['Engine Displacement'];
    maxpower.text = carData['Maximum Power'];
    maxtorque.text = carData['Maximum Torque'];
    priceperday.text = carData['Price Per Day'];
    overview.text = carData['Overview'];
    modelname.text = carData['Model Name'];
    zerotohundred.text = carData['Zero To Hundred'];
    seatingcapacity.text = carData['Seating Capacity'];
    numberplate.text = carData['Number Plate'];
    fueltank.text = carData['Fuel Tank Capacity'];
    groundclearence.text = carData['Ground Clearence'];
    gearbox.text = carData['Gearbox'];
    firebaseimage = carData['MainImage'];
    final List<dynamic> firebseimg = carData['Image Urls'];
    for (int i = 0; i < firebseimg.length; i++) {
      firebaseimages.add(firebseimg[i].toString());
    }

    return carData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    firebaseimages.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * .27,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    firebaseimages[index],
                                                  ),
                                                  fit: BoxFit.cover)),
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          final docRef = FirebaseFirestore
                                              .instance
                                              .collection('car_details')
                                              .doc(widget.id);
                                          await docRef.update(
                                              {'Image Urls'[index]: null});
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                );
                              },
                              itemCount: firebaseimages.length,
                            ),
                          )
                        : Container(),
                    ProjectUtils().sizedbox10,
                    firebaseimage.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(firebaseimage),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      width:
                          MediaQuery.of(context).size.width * double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              pickImages();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProjectUtils().headingsmall(
                                    context: context,
                                    color: ProjectColors.primarycolor1,
                                    text: 'SELECT IMAGES  '),
                                Icon(
                                  Icons.add_a_photo,
                                  color: ProjectColors.primarycolor1,
                                  size: 27,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    _imageUrls.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * .25,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      width: MediaQuery.of(context).size.width *
                                          .6,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                _imageUrls[index],
                                              ),
                                              fit: BoxFit.cover)),
                                    ));
                              },
                              itemCount: _imageUrls.length,
                            ),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProjectUtils().headingsmall(
                            context: context,
                            color: ProjectColors.primarycolor1,
                            text: 'MAIN IMAGE'),
                        IconButton(
                            onPressed: () {
                              imagepicker();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 27,
                              color: ProjectColors.primarycolor1,
                            )),
                      ],
                    ),
                    text(text: 'SELECT CATEGORY'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<String>(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.primarycolor1),
                        width: MediaQuery.of(context).size.width * .7,
                        initialSelection: categorydropdownvalue,
                        menuHeight: 300,
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            fillColor: const Color.fromARGB(131, 255, 255, 255),
                            filled: true),
                        onSelected: (String? value) {
                          setState(() {
                            categorydropdownvalue = value!;
                          });
                        },
                        dropdownMenuEntries: categorylist
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    text(text: 'SELECT COMPANY'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<String>(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.primarycolor1),
                        width: MediaQuery.of(context).size.width * .7,
                        initialSelection: companydropdownvalue,
                        menuHeight: 300,
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            fillColor: const Color.fromARGB(131, 255, 255, 255),
                            filled: true),
                        onSelected: (String? value) {
                          setState(() {
                            companydropdownvalue = value!;
                          });
                        },
                        dropdownMenuEntries: ProjectUtils.companylist
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    text(text: 'SELECT FUEL TYPE'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<String>(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.primarycolor1),
                        width: MediaQuery.of(context).size.width * .7,
                        initialSelection: fueltypedropdownvalue,
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            fillColor: const Color.fromARGB(131, 255, 255, 255),
                            filled: true),
                        onSelected: (String? value) {
                          setState(() {
                            fueltypedropdownvalue = value!;
                          });
                        },
                        dropdownMenuEntries: fuelType
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    text(text: 'SELECT TRANSMISSION TYPE'),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<String>(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ProjectColors.primarycolor1),
                        width: MediaQuery.of(context).size.width * .7,
                        initialSelection: transmissiondropdownvalue,
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            fillColor: const Color.fromARGB(131, 255, 255, 255),
                            filled: true),
                        onSelected: (String? value) {
                          setState(() {
                            transmissiondropdownvalue = value!;
                          });
                        },
                        dropdownMenuEntries:
                            Transmissionvalues.map<DropdownMenuEntry<String>>(
                                (String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    Form(
                        key: formkeyupdateinventory,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProjectUtils().sizedbox20,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: modelname,
                                  keyboardtype: TextInputType.name,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Model  Name'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: enginedisplacement,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Engine Displacement'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: maxpower,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Maximum Power '),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: maxtorque,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Maximum Torque'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: zerotohundred,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: '0-100'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: seatingcapacity,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Seating Capacity'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: numberplate,
                                  keyboardtype: TextInputType.name,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Registration Plate Number'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: fueltank,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Fuel Tank Capacity (ltrs)'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: groundclearence,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Ground Clearence'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: gearbox,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Gearbox'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: overview,
                                  keyboardtype: TextInputType.name,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Overview'),
                              ProjectUtils().sizedbox10,
                              ProjectUtils().textformfieldaddinventory(
                                  context: context,
                                  controller: priceperday,
                                  keyboardtype: TextInputType.number,
                                  focusedcolor: ProjectColors.primarycolor1,
                                  enabled: Colors.grey,
                                  hint: 'Price Per Day'),
                              ProjectUtils().sizedbox10,
                              InkWell(
                                onTap: () {
                                  if (formkeyupdateinventory.currentState!
                                      .validate()) {
                                    savedata();
                                  } else {}
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ProjectColors.primarycolor1,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    width:
                                        MediaQuery.of(context).size.width * .9,
                                    height: 55,
                                    child: Center(
                                      child: Text(
                                        'UPDATE INVENTORY',
                                        style: TextStyle(
                                            color: ProjectColors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> pickImages() async {
    firebaseimages.clear(); // Clear the list before adding new images
    _imageUrls.clear();
    try {
      final images = await ImagePicker().pickMultiImage();

      setState(() {
        _images = images;
      });
      await uploadImages();
    } catch (e) {
      // Handle the exception
    }
  }

  Future<void> uploadImages() async {
    for (var image in _images!) {
      final ref =
          FirebaseStorage.instance.ref().child('CarImages/${image.name}');
      final uploadTask = ref.putFile(File(image.path));

      await uploadTask.whenComplete(() async {
        ProjectUtils().sucessmessage(
            context: context, text: 'Image Uploaded Sucessfully');
        _imageUrls.add(await ref.getDownloadURL());
      });
    }
    setState(() {});
  }

  imagepicker() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('carMain');
    Reference referenceDirImagtoupload = referenceDirImage.child(filename);
    try {
      await referenceDirImagtoupload.putFile(File(file.path));
      MainImage = await referenceDirImagtoupload.getDownloadURL();
      setState(() {});
      if (MainImage.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No Image Selected')));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }

  savedata() {
    if (MainImage.isEmpty) {
      MainImage = firebaseimage;
    }
    if (_imageUrls.isEmpty) {
      _imageUrls = firebaseimages;
    }

    DatabaseMethods().UpdateInventory(
        widget.id,
        modelname.text,
        companydropdownvalue,
        categorydropdownvalue,
        enginedisplacement.text,
        maxpower.text,
        maxtorque.text,
        transmissiondropdownvalue,
        fueltank.text,
        fueltypedropdownvalue,
        groundclearence.text,
        gearbox.text,
        priceperday.text,
        overview.text,
        zerotohundred.text,
        seatingcapacity.text,
        MainImage,
        numberplate.text,
        _imageUrls);
    _imageUrls.clear();
    MainImage = '';
    ProjectUtils().sucessmessage(
        context: context, text: 'Inventory Updated Successfully');
    Navigator.of(context).pop();
  }
}
