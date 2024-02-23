import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';

// ignore: must_be_immutable
class ViewRentalUser extends StatelessWidget {
  ViewRentalUser({super.key});
  int a = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'Rental Rules',
          style: GoogleFonts.signikaNegative(
              fontSize: MediaQuery.of(context).size.height * .019,
              color: ProjectColors.white,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ProjectColors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 239, 239, 239),
        child: Row(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('rentalrules')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Row> clientwidgets = [];
                  if (snapshot.hasData) {
                    final clients = snapshot.data?.docs.reversed.toList();
                    for (var client in clients!) {
                      final clientwidget = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 154, 154, 154)
                                                .withOpacity(0.4),
                                        spreadRadius: 4,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color: ProjectUtils().listcolor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$a. ' + client['rule'],
                                      style: GoogleFonts.signikaNegative(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .018,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      );
                      clientwidgets.add(clientwidget);
                      a++;
                    }
                  }
                  return Expanded(
                      child: ListView(
                    children: clientwidgets,
                  ));
                })
          ],
        ),
      ),
    );
  }
}
