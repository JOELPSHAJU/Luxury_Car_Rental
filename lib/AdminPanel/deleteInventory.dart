import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      fontSize: MediaQuery.of(context).size.height * .02);
}

class _DeleteInventoryState extends State<DeleteInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: ProjectColors.black,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
          ),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          centerTitle: true,
          title: Text(
            'delete Inventory'.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ProjectColors.black),
          ),
          backgroundColor: ProjectColors.primarycolor1,
        ),
        body: Column(children: [
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
                        height: MediaQuery.of(context).size.height * .19,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 209, 209, 209),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .35,
                                height: MediaQuery.of(context).size.height * .9,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(doc['Image Urls'][0]),
                                        fit: BoxFit.cover)),
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
                                        'Fuel Type : ' + '' + doc['Fuel Type'],
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
        ]));
  }

  showAlertDialog(BuildContext context, String id) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      title: const Text("Are You Sure ?"),
      content: const Text(
          "Do you really want to delete this Inventory? This process cannot be undone."),
      actions: [
        Row(
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'fonts/Righteous-Regular.ttf',
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
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontFamily: 'fonts/Righteous-Regular.ttf',
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
