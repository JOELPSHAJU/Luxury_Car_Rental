import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        title: Text(
          'Popular Inventories',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ProjectColors.black),
        ),
        centerTitle: true,
        backgroundColor: ProjectColors.primarycolor1,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => AdminHome()));
            },
            icon: Icon(
              Icons.arrow_back,
              color: ProjectColors.black,
            )),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection(
              'popular inventories',
            )
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final doc = snapshot.data!.docs[index];
                String documentId = doc.id;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        text(text: 'Category : ' + doc['Category']),
                        text(text: 'Price ₹' + doc['Price'] + '/-'),
                        text(text: doc['Id'])
                      ],
                    ),
                    leading: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(doc['Image']),
                    ),
                    title: text(text: doc['Company']),
                    tileColor: const Color.fromARGB(255, 211, 211, 211),
                    trailing: IconButton(
                        onPressed: () {
                          DatabaseMethods()
                              .deletePopularInventories(documentId);
                          setState(() {});
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
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
    );
  }
}
