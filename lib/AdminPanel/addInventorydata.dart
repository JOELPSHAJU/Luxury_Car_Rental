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

Widget text({required text, required context}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * .04,
        fontWeight: FontWeight.bold,
        color: ProjectColors.primarycolor1),
  );
}

//TEXTFORMFIELD FOR TAKING DATA FROM USER

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
  String MainImage = '';
  //initial of dropdownvalue
  String categorydropdownvalue = categorylist.first;
  String companydropdownvalue = ProjectUtils.companylist.first;
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
    _imageUrls.clear();
    MainImage = '';
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text(context: context, text: 'No Image Selected')));
      }
    } catch (e) {
      print('Some Error Happened ?');
    }
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
            icon: const Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: ProjectColors.white),
        backgroundColor: ProjectColors.primarycolor1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Inventory'.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * .02,
              color: ProjectColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
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
                sizedBox,
                _imageUrls.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * .25,
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
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              _imageUrls[index],
                                            ),
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
                sizedBox,
                MainImage.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(MainImage))),
                          ),
                        ],
                      )
                    : Container(),
                sizedBox,
                text(context: context, text: 'SELECT CATEGORY'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ProjectColors.primarycolor1),
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
                text(context: context, text: 'SELECT COMPANY'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ProjectColors.primarycolor1),
                    width: MediaQuery.of(context).size.width * .7,
                    initialSelection: ProjectUtils.companylist.first,
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
                sizedBox,
                text(context: context, text: 'SELECT FUEL TYPE'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ProjectColors.primarycolor1),
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
                text(context: context, text: 'SELECT TRANSMISSION TYPE'),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownMenu<String>(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ProjectColors.primarycolor1),
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
                    key: formkeyaddinventory,
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
                      decoration: BoxDecoration(
                          color: ProjectColors.primarycolor1,
                          borderRadius: BorderRadius.circular(100)),
                      width: MediaQuery.of(context).size.width * .9,
                      height: 55,
                      child: Center(
                        child: Text(
                          'ADD INVENTORY',
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
      'Image Urls': _imageUrls,
      'MainImage': MainImage
    });
    erasedata();
    snackbar();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const AdminHome()));
  }
}
