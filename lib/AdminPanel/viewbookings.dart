import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewBookings extends StatefulWidget {
  const ViewBookings({super.key});

  @override
  State<ViewBookings> createState() => _ViewBookingsState();
}

Widget textbookingpage({required text, required context}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * .015,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0)),
  );
}

class _ViewBookingsState extends State<ViewBookings> {
  @override
  Widget build(BuildContext context) {
    CollectionReference requestReplyCollection =
        FirebaseFirestore.instance.collection('requestreply');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'BOOKINGS',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: requestReplyCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String name = document.get('fullname');
                String pick = document.get('Pickupdate');
                String drop = document.get('Dropoffdate');
                String carbrand = document.get('company');
                String model = document.get('model');
                String category = document.get('category');
                String email = document.get('email');
                String phonenumber = document.get('phonenumber');
                String total = document.get('Totalamount');
                String image = document.get('Image');

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 214, 214, 214),
                    ),
                    height: MediaQuery.of(context).size.height * .24,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * .3,
                            child: Image.network(image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textbookingpage(
                                  text: 'Brand : ' + '$carbrand',
                                  context: context),
                              textbookingpage(
                                  text: 'Model Name : ' + '$model',
                                  context: context),
                              textbookingpage(
                                  text: 'Category : ' + '$category',
                                  context: context),
                              textbookingpage(
                                  text: 'Total Amount : ' + '$total',
                                  context: context),
                              textbookingpage(
                                  text:
                                      'PickUp Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(pick))}',
                                  context: context),
                              textbookingpage(
                                  text:
                                      'Dropoff Date : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(drop))}',
                                  context: context),
                              textbookingpage(
                                  text: 'Rentee Name : ' + '$name',
                                  context: context),
                              textbookingpage(
                                  text: 'Rentee PhoneNo : ' + '$phonenumber',
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
