import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:luxurycars/AdminPanel/homepage_admin.dart';

import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

class DeleteInventory extends StatefulWidget {
  const DeleteInventory({super.key});

  @override
  State<DeleteInventory> createState() => _DeleteInventoryState();
}

textstyles({
  required context,
}) {
  return TextStyle(
      fontWeight: FontWeight.w500,
      color: ProjectColors.primarycolor1,
      fontSize: MediaQuery.of(context).size.height * .017);
}

class _DeleteInventoryState extends State<DeleteInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: ProjectColors.white,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          centerTitle: true,
          title: Text(
            'delete Inventory'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * .02,
                color: ProjectColors.white),
          ),
          backgroundColor: ProjectColors.primarycolor1,
        ),
        body: Container(
          color: Color.fromARGB(255, 228, 228, 228),
          child: Column(children: [
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('cardetails').get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final doc = snapshot.data!.docs[index];
                      String currentDocumentId = doc.id;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .18,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .27,
                                  height:
                                      MediaQuery.of(context).size.width * .27,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: doc['MainImage'],
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: ProjectColors.primarycolor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showAlertDialog(context, currentDocumentId);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .53,
                                    height:
                                        MediaQuery.of(context).size.height * .9,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['Company'] +
                                              ' ' +
                                              doc['Model Name'],
                                          style: textstyles(context: context),
                                        ),
                                        Text(
                                          'Category : ' + ' ' + doc['Category'],
                                          style: textstyles(context: context),
                                        ),
                                        Text(
                                          'Price/day : ' +
                                              ' ₹' +
                                              doc['Price Per Day'],
                                          style: textstyles(context: context),
                                        ),
                                        Text(
                                          'Fuel Type : ' +
                                              '' +
                                              doc['Fuel Type'],
                                          style: textstyles(context: context),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ))
          ]),
        ));
  }

  showAlertDialog(BuildContext context, String id) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      title: Text("Are You Sure ?", style: GoogleFonts.signikaNegative()),
      content: Text(
        "Do you really want to delete this Inventory? This process cannot be undone.",
        style: GoogleFonts.signikaNegative(),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 50,
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .29,
                    height: 35,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 0, 0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 0, 0)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 179, 0, 0))))),
                        onPressed: () {
                          DatabaseMethods().deleteCarInfo(id);

                          Navigator.of(context).pop();
                          setState(() {});

                          snackbar() {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                              content: Text('Inventory deleted Sucessfully'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        },
                        child: Text(
                          "DELETE".toUpperCase(),
                          style: GoogleFonts.signikaNegative(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * .03,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * .29,
                    height: 33,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 53, 113, 0)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 0, 156, 13)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 55, 55, 55))))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "CANCEL".toUpperCase(),
                          style: GoogleFonts.signikaNegative(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: MediaQuery.of(context).size.width * .03,
                          ),
                        )),
                  ),
                ),
              ]),
            )
          ],
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
