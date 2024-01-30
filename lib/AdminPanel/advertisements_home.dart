import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/add_advertisement.dart';

class AdvertisementGome extends StatefulWidget {
  const AdvertisementGome({super.key});

  @override
  State<AdvertisementGome> createState() => AdvertisementGomeState();
}

final textst = TextStyle(
    fontWeight: FontWeight.w500,
    color: const Color.fromARGB(255, 124, 124, 124));

class AdvertisementGomeState extends State<AdvertisementGome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 236, 236, 236),
        height: MediaQuery.of(context).size.height * .24,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection(
                'advertisements',
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
                      width: MediaQuery.of(context).size.width * .7,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => AddAdvertisement())));
                        },
                        child: Card(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          doc['image'],
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                  height:
                                      MediaQuery.of(context).size.height * .16,
                                  width: MediaQuery.of(context).size.width * .7,
                                ),
                              ),
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
