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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: Text(
          'Rental Rules',
          style: GoogleFonts.signikaNegative(
              fontSize: MediaQuery.of(context).size.height * .023,
              color: ProjectColors.white,
              fontWeight: FontWeight.w500),
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
                                    color: Color.fromARGB(255, 223, 223, 223),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(0),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * .93,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '$a. ' + client['rule'],
                                      style: GoogleFonts.roboto(
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
