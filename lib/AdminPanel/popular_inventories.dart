import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';

import 'package:luxurycars/AdminPanel/homepage_admin.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';

class PopularInventories extends StatefulWidget {
  const PopularInventories({super.key});

  @override
  State<PopularInventories> createState() => _PopularInventoriesState();
}

class _PopularInventoriesState extends State<PopularInventories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Text(
          'Popular Inventories',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * .023,
              color: ProjectColors.white),
        ),
        centerTitle: true,
        backgroundColor: ProjectColors.primarycolor1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 23,
              color: ProjectColors.white,
            )),
      ),
      body: Container(
        color: const Color.fromARGB(255, 238, 238, 238),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('popular inventories')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> docs = snapshot.data!.docs;

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .5,
                          child: Image.asset(
                            'assets/carTypes/placeholder3.png',
                            fit: BoxFit.cover,
                          )),
                      Text(
                        'No Popular Inventories Found!',
                        style: GoogleFonts.signikaNegative(
                            fontSize: MediaQuery.of(context).size.width * .04,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                key: UniqueKey(), // Use a unique key for the ListView
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  String documentId = doc.id;
                  return Dismissible(
                    key: Key(documentId),
                    onDismissed: (direction) {
                      DatabaseMethods().deletePopularInventories(documentId);
                      setState(() {
                        docs.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Deleting ${doc['Company']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.delete, color: Colors.white),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .25,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    CachedNetworkImage(imageUrl: doc['Image']),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  text(
                                      context: context,
                                      text: 'Category : ' + doc['Category']),
                                  text(
                                      context: context,
                                      text: 'Price ₹' + doc['Price'] + '/-'),
                                ],
                              ),
                              Divider(),
                              text(
                                  text: 'Swipe To Any Side Delete',
                                  context: context)
                            ],
                          )),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
