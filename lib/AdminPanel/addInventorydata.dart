import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Universaltools.dart';

class AddInventory extends StatefulWidget {
  const AddInventory({super.key});

  @override
  State<AddInventory> createState() => _AddInventoryState();
}

Widget text({required text}) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0)),
  );
}

//TEXTFORMFIELD FOR TAKING DATA FROM USER
Widget textformfield(
    {required hint, required controller, required keyboardtype}) {
  return Column(children: [
    const SizedBox(
      height: 10,
    ),
    SizedBox(
      width: 300,
      child: TextFormField(
          keyboardType: keyboardtype,
          controller: controller,
          cursorColor: const Color.fromARGB(255, 0, 0, 0),
          style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Fill This Field !';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text(hint),
            labelStyle: const TextStyle(
                color: Color.fromARGB(159, 0, 0, 0),
                fontWeight: FontWeight.bold),
            filled: true,
            fillColor: Color.fromARGB(255, 214, 214, 214),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                borderRadius: BorderRadius.circular(0)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
          )),
    )
  ]);
}

//TEXTCONTROLLERS LISTED BELOW
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

//PICK IMAGE AND UPLOAD IMAGES CODE ARE GIVEN BELOW

class _AddInventoryState extends State<AddInventory> {
  List<XFile>? _images;

  final List<String> _imageUrls = [];

  Future<void> pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images != null) {
        setState(() {
          _images = images;
        });
      }
    } catch (e) {}
  }

  Future<void> uploadImages() async {
    for (var image in _images!) {
      final ref =
          FirebaseStorage.instance.ref().child('CarImages/${image.name}');
      final uploadTask = ref.putFile(File(image.path));

      await uploadTask.whenComplete(() async {
        final url = await ref.getDownloadURL();
        _imageUrls.add(url);
      });
    }
  }

  final sizedBox = const SizedBox(
    height: 10,
  );

  //form key
  final formkeyaddinventory = GlobalKey<FormState>();
  //category list for dropdownbutton
  static const List<String> categorylist = <String>[
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
  static const List<String> Transmissionvalues = <String>[
    'Full Automatic',
    'Manual',
    'Automatic + Manual'
  ];
//drop down button fuel type
  static const List<String> fuelType = <String>['Petrol', 'Diesel', 'Electric'];
//drop down button company data
  static const List<String> companylist = <String>[
    'Aston Martin',
    'Audi',
    'Bently',
    'Buggatti',
    'BMW',
    'Ferrari',
    'Ford',
    'Lamborghini',
    'Land Rover',
    'Mazda',
    'Mclaren',
    'Mercedes-Benz',
    'Porshe',
    'RollsRoyce',
    'Tesla',
    'Toyota'
  ];
  //initial of dropdownvalue
  String categorydropdownvalue = categorylist.first;
  String companydropdownvalue = companylist.first;
  String fueltypedropdownvalue = fuelType.first;
  String transmissiondropdownvalue = Transmissionvalues.first;
  erasedata() {
    enginedisplacement.clear();
    modelname.clear();
    maxpower.clear();
    maxtorque.clear();
    zerotohundred.clear();
    fueltank.clear();
    seatingcapacity.clear();
    numberplate.clear();
    groundclearence.clear();
    gearbox.clear();
    overview.clear();
    priceperday.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
            icon: const Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: ProjectColors.black),
        backgroundColor: ProjectColors.primarycolor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Inventory'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ProjectColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBox,
                SizedBox(
                  width: MediaQuery.of(context).size.width * double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          pickImages();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ProjectColors.gray,
                              borderRadius: BorderRadius.circular(50)),
                          height: 100,
                          width: 100,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: ProjectColors.black,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                sizedBox,
                sizedBox,
                text(text: 'SELECT CATEGORY'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    width: MediaQuery.of(context).size.width * .7,
                    initialSelection: categorylist.first,
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
                sizedBox,
                text(text: 'SELECT COMPANY'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    width: MediaQuery.of(context).size.width * .7,
                    initialSelection: companylist.first,
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
                    dropdownMenuEntries: companylist
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                sizedBox,
                text(text: 'SELECT FUEL TYPE'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    width: MediaQuery.of(context).size.width * .7,
                    initialSelection: fuelType.first,
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
                    dropdownMenuEntries:
                        fuelType.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                sizedBox,
                text(text: 'SELECT TRANSMISSION TYPE'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    width: MediaQuery.of(context).size.width * .7,
                    initialSelection: Transmissionvalues.first,
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
                sizedBox,
                const Divider(
                  thickness: 2,
                ),
                Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: formkeyaddinventory,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox,
                          textformfield(
                              hint: 'Model Name',
                              controller: modelname,
                              keyboardtype: TextInputType.name),
                          sizedBox,
                          textformfield(
                              hint: 'Engine Displacement (cc)',
                              controller: enginedisplacement,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Maximum Power (hp)',
                              controller: maxpower,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Maximum Torque (nm)',
                              controller: maxtorque,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: '0 - 100 (seconds)',
                              controller: zerotohundred,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Seating Capacity',
                              controller: seatingcapacity,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Number Plate',
                              controller: numberplate,
                              keyboardtype: TextInputType.text),
                          sizedBox,
                          textformfield(
                              hint: 'Fuel Tank Capacity (ltrs)',
                              controller: fueltank,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Ground Clearence',
                              controller: groundclearence,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Gearbox',
                              controller: gearbox,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          textformfield(
                              hint: 'Overview',
                              controller: overview,
                              keyboardtype: TextInputType.text),
                          sizedBox,
                          textformfield(
                              hint: 'Priceperday',
                              controller: priceperday,
                              keyboardtype: TextInputType.number),
                          sizedBox,
                          sizedBox
                        ],
                      ),
                    )),
                InkWell(
                  onTap: () {
                    if (formkeyaddinventory.currentState!.validate()) {
                      saveData();
                    } else {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      decoration:
                          BoxDecoration(color: ProjectColors.primarycolor1),
                      width: MediaQuery.of(context).size.width * .72,
                      height: 55,
                      child: Center(
                        child: Text(
                          'ADD INVENTORY',
                          style: TextStyle(
                              color: ProjectColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }

  snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text('Inventory Added Sucessfully'),
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> saveData() async {
    await uploadImages();

    await FirebaseFirestore.instance.collection('cardetails').add({
      'Category': categorydropdownvalue,
      'Company': companydropdownvalue,
      'Transmission': transmissiondropdownvalue,
      'Fuel Type': fueltypedropdownvalue,
      'Model Name': modelname.text,
      'Engine Displacement': enginedisplacement.text,
      'Maximum Power': maxpower.text,
      'Maximum Torque': maxtorque.text,
      'Zero To Hundred': zerotohundred.text,
      'Seating Capacity': seatingcapacity.text,
      'Number Plate': numberplate.text,
      'Fuel Tank Capacity': fueltank.text,
      'Ground Clearence': groundclearence.text,
      'Gearbox': gearbox.text,
      'Price Per Day': priceperday.text,
      'Overview': overview.text,
      'Image Urls': _imageUrls
    });
    erasedata();
    snackbar();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => AdminHome()));
  }
}
