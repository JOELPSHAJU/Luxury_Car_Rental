import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/popular_inventories.dart';

import 'package:luxurycars/Universaltools.dart';

class Gridview_admin extends StatefulWidget {
  const Gridview_admin({super.key});

  @override
  State<Gridview_admin> createState() => _Gridview_adminState();
}

final textst = TextStyle(
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(255, 124, 124, 124));

class _Gridview_adminState extends State<Gridview_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 236, 236, 236),
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                'popular inventories',
              )
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  String documentId = doc.id;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .48,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => PopularInventories())));
                        },
                        child: Card(
                          color: Color.fromARGB(255, 255, 255, 255),
                          // Use a Card for better visual separation
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  width:
                                      MediaQuery.of(context).size.width * .47,
                                  child: Image.network(
                                    doc['Image'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height:
                                      8), // Add spacing between image and text
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProjectUtils().headingsmall(
                                        context: context,
                                        color: ProjectColors.primarycolor1,
                                        text: '${doc['Company']}'),
                                    Text(
                                      'Category: ' + doc['Category'],
                                      style: textst,
                                    ),
                                    Text(
                                      'Price ₹' + doc['Price'] + '/-',
                                      style: textst,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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