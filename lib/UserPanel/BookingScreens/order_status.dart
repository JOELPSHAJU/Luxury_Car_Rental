import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/BookingScreens/timelinetile.dart';

class OrderStatus extends StatelessWidget {
  final Map<String, dynamic> data;
  const OrderStatus({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: ProjectColors.primarycolor1,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            'Order Status',
            style: GoogleFonts.oswald(color: Colors.white),
          )),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: data['Image'],
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Text(
            ' ${data['Company']} ',
            style: GoogleFonts.oswald(
                fontSize: MediaQuery.of(context).size.width * .05),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  MyTimeLineTile(
                    isLast: false,
                    isPast: true,
                    isfirst: true,
                    child: 'Booking Request Sent',
                  ),
                  MyTimeLineTile(
                    isLast: false,
                    isPast: false,
                    isfirst: false,
                    child: 'Admin Approved',
                  ),
                  MyTimeLineTile(
                    isLast: true,
                    isPast: false,
                    isfirst: false,
                    child: 'Booking Sucessful',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
