import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

class UpdateInventoryFields extends StatefulWidget {
  final String id;
  const UpdateInventoryFields({super.key, required this.id});

  @override
  State<UpdateInventoryFields> createState() => _UpdateInventoryFieldsState();
}

Widget text({required text}) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 4, 4, 4)),
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
          cursorColor: const Color.fromARGB(255, 2, 2, 2),
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
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            filled: true,
            fillColor: const Color.fromARGB(107, 105, 105, 105),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
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

class _UpdateInventoryFieldsState extends State<UpdateInventoryFields> {
  //PICK IMAGE AND UPLOAD IMAGES CODE ARE GIVEN BELOW
  List<XFile>? _images;

  List<String> _imageUrls = [];

  Future<void> pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images != null) {
        setState(() {
          _images = images;
        });
      }
    } catch (e) {
      print(e);
    }
  }

//THE CODE BELOW WILL UPLOAD THE IMAGES AND RETURN THE URLS OF IMAGES AS STRING
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

//THE CODE BELOW WILL UPLOAD THE DATA TO FIREBASE
  updatedata() async {
    await DatabaseMethods().UpdateInventory(
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
        numberplate.text,
        _imageUrls);
    modelname.clear();
    enginedisplacement.clear();
    maxpower.clear();
    maxtorque.clear();
    fueltank.clear();
    groundclearence.clear();
    gearbox.clear();
    priceperday.clear();
    overview.clear();
    zerotohundred.clear();
    seatingcapacity.clear();
    numberplate.clear();
  }

  final sizedBox = const SizedBox(
    height: 10,
  );

  //FORM KEY
  final formkeyaddinventory = GlobalKey<FormState>();
  //CATEGORY LIST FOR DROPDOWN BUTTON
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
  static const List<String> FuelType = <String>['Petrol', 'Diesel', 'Electric'];
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

  String categorydropdownvalue = '';
  String companydropdownvalue = '';
  String fueltypedropdownvalue = '';
  String transmissiondropdownvalue = '';

  String categoryinitialvalue = '';
  String companyinitialvalue = '';
  String fueltypeinitialvalue = '';
  String transmissioninitialvalue = '';

  @override
  void initState() {
    super.initState();
    _fetchInitialValue();
  }

  Future<void> _fetchInitialValue() async {
    final docRef =
        FirebaseFirestore.instance.collection('cardetails').doc(widget.id);
    final data = await docRef.get();

    setState(() {
      categoryinitialvalue = data['Category'];
      companyinitialvalue = data['Company'];
      fueltypeinitialvalue = data['Fuel Type'];
      transmissioninitialvalue = data['Transmission'];
    });
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
          centerTitle: true,
          title: Text(
            'update Inventory'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: ProjectColors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: ProjectColors.lightgrey,
            ),
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('cardetails')
                    .doc(widget.id)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error fetching data: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
                        snapshot.data!;
                    if (docSnapshot.exists) {
                      Map<String, dynamic> data = docSnapshot.data()!;

                      String company = data['Company'];
                      companydropdownvalue = company;
                      String category = data['Category'];
                      categorydropdownvalue = category;
                      String modelnames = data['Model Name'];
                      modelname.text = modelnames;
                      String engine = data['Engine Displacement'];
                      enginedisplacement.text = engine;
                      String fueltanks = data['Fuel Tank Capacity'];
                      fueltank.text = fueltanks;
                      String fueltype = data['Fuel Type'];
                      fueltypedropdownvalue = fueltype;
                      String gearboxs = data['Gearbox'];
                      gearbox.text = gearboxs;
                      String groundclearences = data['Ground Clearence'];
                      groundclearence.text = groundclearences;
                      List<dynamic> images = data['Image Urls'];

                      String numberplates = data['Number Plate'];
                      numberplate.text = numberplates;
                      String maxpowers = data['Maximum Power'];
                      maxpower.text = maxpowers;
                      String maxtorques = data['Maximum Torque'];
                      maxtorque.text = maxtorques;
                      String overviews = data['Overview'];
                      overview.text = overviews;
                      String prices = data['Price Per Day'];
                      priceperday.text = prices.toString();
                      String seatingcapacitys = data['Seating Capacity'];
                      seatingcapacity.text = seatingcapacitys;
                      String transmissions = data['Transmission'];
                      transmissiondropdownvalue = transmissions;
                      String zerotohundreds = data['Zero To Hundred'];
                      zerotohundred.text = zerotohundreds;
                      for (int i = 0; i < images.length; i++) {
                        _imageUrls.add(images[i]);
                      }
                    }
                  }

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox,
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    pickImages();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 201, 201, 201),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 100,
                                    width: 100,
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Color.fromARGB(255, 2, 2, 2),
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
                              menuHeight: 300,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: categoryinitialvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(119, 128, 128, 128),
                                  filled: true),
                              onSelected: (String? value) {
                                setState(() {
                                  categorydropdownvalue = value!;
                                });
                              },
                              dropdownMenuEntries: categorylist
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
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
                              menuHeight: 300,
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: companyinitialvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(119, 128, 128, 128),
                                  filled: true),
                              onSelected: (String? value) {
                                setState(() {
                                  companydropdownvalue = value!;
                                });
                              },
                              dropdownMenuEntries: companylist
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
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
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: fueltypeinitialvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(119, 128, 128, 128),
                                  filled: true),
                              onSelected: (String? value) {
                                setState(() {
                                  fueltypedropdownvalue = value!;
                                });
                              },
                              dropdownMenuEntries:
                                  FuelType.map<DropdownMenuEntry<String>>(
                                      (String value) {
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
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: transmissioninitialvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(119, 128, 128, 128),
                                  filled: true),
                              onSelected: (String? value) {
                                setState(() {
                                  transmissiondropdownvalue = value!;
                                });
                              },
                              dropdownMenuEntries: Transmissionvalues.map<
                                  DropdownMenuEntry<String>>((String value) {
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
                              if (formkeyaddinventory.currentState!
                                  .validate()) {
                                updatedata();
                                snackbar() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.green,
                                    content:
                                        Text('Inventory Updated Sucessfully'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (ctx) => AdminHome()));
                              } else {}
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ProjectColors.primarycolor1),
                                width: MediaQuery.of(context).size.width * .72,
                                height: 55,
                                child: Center(
                                  child: Text(
                                    'UPDATE INVENTORY',
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
                      ));
                }),
          ),
        ));
  }
}
