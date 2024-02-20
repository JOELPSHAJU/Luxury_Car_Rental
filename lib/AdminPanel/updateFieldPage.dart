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
            fillColor: const Color.fromARGB(107, 255, 255, 255),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                borderRadius: BorderRadius.circular(100)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
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

  final List<String> _imageUrls = [];

  Future<void> pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images != null) {
        setState(() {
          _images = images;
        });
        await uploadImages();
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
      mainimg = await referenceDirImagtoupload.getDownloadURL();
      setState(() {});
      if (mainimg.isEmpty) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: text(text: 'No Image Selected')));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
  }

//THE CODE BELOW WILL UPLOAD THE IMAGES AND RETURN THE URLS OF IMAGES AS STRING

//THE CODE BELOW WILL UPLOAD THE DATA TO FIREBASE
  updatedata() async {
    if (mainimg.isEmpty) {
      mainimg = MainImage;
    }
    if (_imageUrls.isEmpty) {
      for (int i = 0; i < imagessaved.length; i++) {
        _imageUrls.add(imagessaved[i].toString());
      }
    }
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
        mainimg,
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
  // ignore: non_constant_identifier_names
  String MainImage = '';
  String mainimg = '';

  List<dynamic> imagessaved = [];
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
          toolbarHeight: 40,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 23,
              )),
          iconTheme: IconThemeData(color: ProjectColors.white),
          backgroundColor: ProjectColors.primarycolor1,
          centerTitle: true,
          title: Text(
            'update Inventory'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * .023,
                color: ProjectColors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
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
                      imagessaved = images;
                      MainImage = data['MainImage'];
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
                    }
                  }

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox,
                          sizedBox,
                          Center(
                            child: SizedBox(
                              child: ProjectUtils().headingsmall(
                                  context: context,
                                  color: ProjectColors.primarycolor1,
                                  text: 'SAVED INVENTORY IMAGES'),
                            ),
                          ),
                          imagessaved.isNotEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        imagessaved[index]
                                                            .toString(),
                                                      ),
                                                      fit: BoxFit.cover)),
                                            )),
                                      );
                                    },
                                    itemCount: imagessaved.length,
                                  ),
                                )
                              : Container(),
                          sizedBox,
                          Center(
                            child: SizedBox(
                              child: ProjectUtils().headingsmall(
                                  context: context,
                                  color: ProjectColors.primarycolor1,
                                  text: 'SAVED MAIN IMAGE'),
                            ),
                          ),
                          MainImage.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(MainImage),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                )
                              : Container(),
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
                                  child: Row(
                                    children: [
                                      ProjectUtils().headingsmall(
                                          context: context,
                                          color: ProjectColors.primarycolor1,
                                          text: 'SELECT IMAGES OF INVENTORY '),
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
                          sizedBox,
                          _imageUrls.isNotEmpty
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          _imageUrls[index]),
                                                      fit: BoxFit.cover)),
                                            )),
                                      );
                                    },
                                    itemCount: _imageUrls.length,
                                  ),
                                )
                              : Container(),
                          sizedBox,
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
                          mainimg.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(mainimg),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                )
                              : Container(),
                          sizedBox,
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
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true),
                              onSelected: (String? value) {
                                setState(() {
                                  companydropdownvalue = value!;
                                });
                              },
                              dropdownMenuEntries: ProjectUtils.companylist
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
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.primarycolor1),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: fueltypedropdownvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ProjectColors.primarycolor1),
                              width: MediaQuery.of(context).size.width * .7,
                              initialSelection: transmissiondropdownvalue,
                              inputDecorationTheme: InputDecorationTheme(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
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
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: modelname,
                                        keyboardtype: TextInputType.name,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Model Name'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: enginedisplacement,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Engine Displacement'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: maxpower,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Maximum Power (hp)'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: maxtorque,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Maximum Torque (nm)'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: gearbox,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Gearbox'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: zerotohundred,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: '0-100 (seconds)'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: seatingcapacity,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Seating Capacity'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: numberplate,
                                        keyboardtype: TextInputType.name,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Number Plate'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: fueltank,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Fuel Tank Capacity (ltrs)'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: groundclearence,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Ground Clearence'),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddoverview(
                                      hint: 'Overview',
                                      controller: overview,
                                      obsecure: false,
                                      focusedcolor: ProjectColors.primarycolor1,
                                      enabled: Colors.grey,
                                    ),
                                    ProjectUtils().sizedbox10,
                                    ProjectUtils().textformfieldaddinventory(
                                        context: context,
                                        controller: priceperday,
                                        keyboardtype: TextInputType.number,
                                        focusedcolor:
                                            ProjectColors.primarycolor1,
                                        enabled: Colors.grey,
                                        hint: 'Price Per Day'),
                                    ProjectUtils().sizedbox10,
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
                                        builder: (ctx) => const AdminHome()));
                              } else {}
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: ProjectColors.primarycolor1),
                                width: MediaQuery.of(context).size.width,
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
                          sizedBox
                        ],
                      ));
                }),
          ),
        ));
  }
}
