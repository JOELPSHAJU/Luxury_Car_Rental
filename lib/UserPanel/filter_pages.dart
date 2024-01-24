// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  fontstyle({required context}) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * .02,
        fontWeight: FontWeight.w500);
  }

  final sizedb = const SizedBox(
    height: 10,
  );
  //transmission dropdownbutton data
  static const List<String> filterdropdown = <String>[
    'Manual Transmission',
    'Automatic Transmission',
    'Automatic+Manual',
    'Price<50000',
    'Price<30000',
    'Fuel : Diesel',
    'Fuel : Petrol',
    'Fuel : Electric'
  ];
  String transmissiondropdownvalue = filterdropdown.first;

  Future<List<DocumentSnapshot>> _getDocuments(String name) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('cardetails');

    if (name == filterdropdown[0]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Transmission', isEqualTo: 'Manual')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[1]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Transmission', isEqualTo: 'Full Automatic')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[2]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Transmission', isEqualTo: 'Automatic + Manual')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[3]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Price Per Day', isLessThan: '50000')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[4]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Price Per Day', isLessThan: '30000')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[5]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Fuel Type', isEqualTo: 'Diesel')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[6]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Fuel Type', isEqualTo: 'Petrol')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else if (name == filterdropdown[7]) {
      try {
        QuerySnapshot querySnapshot = await usersRef
            .where('Fuel Type', isEqualTo: 'Electric')
            // Add this line to filter by Transmission
            .get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    } else {
      try {
        QuerySnapshot querySnapshot =
            await usersRef.where('Company', isEqualTo: 'rr').get();
        return querySnapshot.docs;
      } catch (e) {
        print(e);
        return [];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ProjectColors.primarycolor1,
          title: text(text: 'Find Your Inventory'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 75,
                color: ProjectColors.primarycolor1,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.filter_list),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          menuHeight: 250,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          width: MediaQuery.of(context).size.width * .7,
                          initialSelection: filterdropdown.first,
                          inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              fillColor:
                                  const Color.fromARGB(131, 255, 255, 255),
                              filled: true),
                          onSelected: (String? value) {
                            setState(() {
                              transmissiondropdownvalue = value!;
                            });
                          },
                          dropdownMenuEntries: filterdropdown
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: _getDocuments(transmissiondropdownvalue),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> documents = snapshot.data!;
                      if (documents.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/bg/Screenshot 2024-01-11 193510-PhotoRoom.png-PhotoRoom.png',
                              width: MediaQuery.of(context).size.width * .5,
                            ),
                            Text(
                              'Oops,No Inventory Found For This Brand!',
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 81, 81, 81)),
                            )
                          ],
                        ));
                      }

                      return Container(
                        color: Colors.white,
                        width:
                            MediaQuery.of(context).size.width * double.infinity,
                        height: MediaQuery.of(context).size.height * .99,
                        child: ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = documents[index];
                            String documentId = document.id;
                            Map<String, dynamic> data =
                                documents[index].data() as Map<String, dynamic>;

                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => ParticularInventory(
                                          id: documentId,
                                        )));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: 164,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 225, 225, 225),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data['Image Urls'][0]),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data['Company']}\n${data['Model Name']}',
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Category : ${data['Category']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Price : ${data['Priceperday']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Fuel Type : ${data['Fuel Type']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
