import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luxurycars/Universaltools.dart';

class ViewBookings extends StatefulWidget {
  const ViewBookings({Key? key}) : super(key: key);

  @override
  State<ViewBookings> createState() => _ViewBookingsState();
}

Widget textbookingpage({required text, required context}) {
  return Text(
    text,
    maxLines: 1,
    style: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ProjectColors.black,
    ),
  );
}

class _ViewBookingsState extends State<ViewBookings> {
  @override
  Widget build(BuildContext context) {
    CollectionReference requestReplyCollection =
        FirebaseFirestore.instance.collection('requestreply');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 23,
            color: Colors.white,
          ),
        ),
        title: Text(
          'BOOKINGS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * .023,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 228, 228, 228),
        child: StreamBuilder<QuerySnapshot>(
          stream: requestReplyCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Image.asset(
                        'assets/carTypes/placeholder4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'No Bookings Found!',
                      style: GoogleFonts.signikaNegative(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                String name = document.get('fullname') ?? '';
                String pick = document.get('Pickupdate') ?? '';
                String drop = document.get('Dropoffdate') ?? '';
                String carbrand = document.get('company') ?? '';
                String model = document.get('model') ?? '';
                String category = document.get('category') ?? '';
                String email = document.get('email') ?? '';
                String phonenumber = document.get('phonenumber') ?? '';
                String total = document.get('Totalamount') ?? '';
                String image = document.get('Image') ?? '';

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: MediaQuery.of(context).size.height * .2,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * .4,
                              width: MediaQuery.of(context).size.width * .48,
                              child: CachedNetworkImage(
                                imageUrl: image,
                                placeholder: (context, url) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: textbookingpage(
                                      text: '$carbrand',
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: textbookingpage(
                                      text: '$model',
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: textbookingpage(
                                      text: '$total',
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: textbookingpage(
                                      text:
                                          'from : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(pick))}',
                                      context: context,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: textbookingpage(
                                      text:
                                          'to : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(drop))}',
                                      context: context,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
