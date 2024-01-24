import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingsPage extends StatefulWidget {
  @override
  _BookingsPageState createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  Future<List<DocumentSnapshot>> _getDocuments(String email) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('requestreply');

    try {
      QuerySnapshot querySnapshot =
          await usersRef.where('email', isEqualTo: email).get();
      return querySnapshot.docs;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<String>> getDocumentIds(String email) async {
    try {
      List<DocumentSnapshot> documents = await _getDocuments(email);
      List<String> documentIds = documents.map((doc) => doc.id).toList();
      return documentIds;
    } catch (e) {
      print(e);
      return [];
    }
  }

  User? user = FirebaseAuth.instance.currentUser;

  late String? email = user?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: FutureBuilder<List<DocumentSnapshot>>(
          future: _getDocuments(email.toString()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!;

              if (documents.isEmpty) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bg/hh.png',
                      width: MediaQuery.of(context).size.height * .23,
                    ),
                    Text(
                      'No Bookings Found !',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .04,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 81, 81, 81)),
                    )
                  ],
                ));
              }
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> data =
                      documents[index].data() as Map<String, dynamic>;
                  final docid = (documents[index].id);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 225, 225, 225),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 130,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage('${data['Image']}'),
                                        fit: BoxFit.contain)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status : ' + '${data['Confirmation']}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .019,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    '${data['company']}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .019,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Category : ${data['category']}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .017,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Total Amount : ${data['Totalamount']}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .017,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Pickup Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Pickupdate']))}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .017,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Dropoff Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Dropoffdate']))}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .017,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
