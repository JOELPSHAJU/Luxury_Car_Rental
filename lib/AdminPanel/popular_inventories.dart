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
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text(text: 'Category : ' + doc['Category']),
                            text(text: 'Price ₹' + doc['Price'] + '/-'),
                          ],
                        ),
                        leading: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * .2,
                          child: Image.network(
                            doc['Image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: text(text: doc['Company']),
                        tileColor: Color.fromARGB(255, 155, 60, 60),
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
