import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({super.key});

  @override
  State<BookingRequest> createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  Widget textonc({required client, required context, required label}) {
    return Row(
      children: [
        Text(
          '$label',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .019,
              color: const Color.fromARGB(255, 91, 91, 91),
              fontWeight: FontWeight.bold),
        ),
        Text(
          // ignore: prefer_interpolation_to_compose_strings
          ' ' + client,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .02,
              color: const Color.fromARGB(255, 10, 19, 34),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  buttonstyle({required color}) {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      backgroundColor: color,
    );
  }

  final buttontextstyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'BOOKING  REQUEST',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('booking details')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<Row> clientwidgets = [];
                  if (snapshot.hasData) {
                    final clients = snapshot.data?.docs.reversed.toList();
                    if (clients == null || clients.isEmpty) {
                      return Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/bg/hh.png',
                            width: MediaQuery.of(context).size.height * .29,
                          ),
                          Text(
                            'No Requests Found!',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * .04,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 81, 81, 81)),
                          )
                        ],
                      ));
                    }
                    for (var client in clients!) {
                      final clientwidget = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 211, 211, 211),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                width: MediaQuery.of(context).size.width * .9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        client['Company'] +
                                            ' ' +
                                            client['ModelName'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .026,
                                            color: const Color.fromARGB(
                                                255, 42, 42, 42)),
                                      ),
                                      textonc(
                                          client: DateFormat('dd-MM-yyyy')
                                              .format(DateTime.parse(
                                                  client['pickupdate'])),
                                          context: context,
                                          label: 'Pickup Date :'),
                                      textonc(
                                          client: DateFormat('dd-MM-yyyy')
                                              .format(DateTime.parse(
                                                  client['dropoffdate'])),
                                          context: context,
                                          label: 'Drop Off Date :'),
                                      textonc(
                                          client: client['NumberPlate'],
                                          context: context,
                                          label: 'Number Plate :'),
                                      textonc(
                                          client: client['FullName'],
                                          context: context,
                                          label: 'Full Name :'),
                                      textonc(
                                          client: client['Totalprice'],
                                          context: context,
                                          label: 'Total Price :'),
                                      const Divider(
                                        thickness: 2,
                                        color: Color.fromARGB(255, 74, 74, 74),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              final Map<String, dynamic>
                                                  addreply = {
                                                "Confirmation": 'SUCESSFUL',
                                                "Pickupdate":
                                                    client['pickupdate'],
                                                "Dropoffdate":
                                                    client['dropoffdate'],
                                                "Totalamount":
                                                    client['Totalprice'],
                                                "fullname": client['FullName'],
                                                "Phoneno":
                                                    client['PhoneNumber'],
                                                "Image": client['Image'],
                                                "company": client['Company'],
                                                "category": client['Category'],
                                                "email": client['emailuser'],
                                                "model": client['ModelName'],
                                                "phonenumber":
                                                    client['PhoneNumber']
                                              };
                                              DatabaseMethods()
                                                  .addtorequestreply(addreply);
                                              DatabaseMethods()
                                                  .deleterequest(client.id);
                                              setState(() {});
                                            },
                                            style: buttonstyle(
                                                color: Colors.green),
                                            child: Text(
                                              'ACCEPT',
                                              style: buttontextstyle,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              final Map<String, dynamic>
                                                  addreply = {
                                                "Confirmation": 'FAILED',
                                                "Pickupdate":
                                                    client['pickupdate'],
                                                "Dropoffdate":
                                                    client['dropoffdate'],
                                                "Totalamount":
                                                    client['Totalprice'],
                                                "fullname": client['FullName'],
                                                "email": client['emailuser'],
                                                "Phoneno":
                                                    client['PhoneNumber'],
                                                "Image": client['Image'],
                                                "company": client['Company'],
                                                "category": client['Category'],
                                                "model": client['ModelName'],
                                                "phonenumber":
                                                    client['PhoneNumber']
                                              };
                                              DatabaseMethods()
                                                  .addtorequestreply(addreply);
                                              DatabaseMethods()
                                                  .deleterequest(client.id);
                                              setState(() {});
                                            },
                                            style:
                                                buttonstyle(color: Colors.red),
                                            child: Text(
                                              'DECLINE',
                                              style: buttontextstyle,
                                            ),
                                          )
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
      ),
    );
  }
}
