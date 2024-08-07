// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:luxurycars/Universaltools.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 30, 69),
        title: Text(
          'Notification',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ProjectColors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: ProjectColors.white,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notification')
                  .snapshots(),
              builder: (context, snapshot) {
                List<Row> clientwidgets = [];

                if (snapshot.hasData) {
                  final clients = snapshot.data?.docs.reversed.toList();
                  if (clients!.isEmpty) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/bg/note.png',
                          width: MediaQuery.of(context).size.height * .1,
                        ),
                        Text(
                          'No New Notifications!',
                          style: GoogleFonts.signikaNegative(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 81, 81, 81)),
                        )
                      ],
                    ));
                  }
                  for (var client in clients) {
                    final clientwidget = Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 197, 198, 197),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    topRight: Radius.circular(10)),
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                              width: MediaQuery.of(context).size.width * .9,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      client['note'],
                                      style: GoogleFonts.roboto(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .02,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${DateFormat("dd/MM/yyyy hh:mm a").format(DateTime.parse(client['date']))}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    );
                    clientwidgets.add(clientwidget);
                  }
                }
                return Expanded(
                    child: ListView(
                  children: clientwidgets,
                ));
              })
        ],
      ),
    );
  }
}
