import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class Sucessful extends StatelessWidget {
  final data;
  const Sucessful({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 154, 154, 154).withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                      )),
                  Center(
                      child: Text(
                    "Order Sucessful",
                    style: GoogleFonts.oswald(
                        fontSize: 20, color: Color.fromARGB(255, 34, 183, 18)),
                  )),
                  sizedboc,
                  CachedNetworkImage(
                    imageUrl: data['Image'],
                    placeholder: (context, url) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  Text(
                    '${data['company']} ${data['model']}',
                    style: GoogleFonts.oswald(
                        fontSize: 13,
                        color: ProjectColors.primarycolor1,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    'Category ',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${data['category']}',
                    style: GoogleFonts.gowunBatang(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Divider(),
                  Text(
                    'Pickup Date',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Pickupdate']))}',
                    style: GoogleFonts.gowunBatang(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    'Dropoff Date',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${DateFormat('dd-MM-yyyy').format(DateTime.parse(data['Dropoffdate']))}',
                    style: GoogleFonts.gowunBatang(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    'Amount To Be Paid',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '₹ ${data['Totalamount']}/-',
                    style: GoogleFonts.gowunBatang(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(
                    'Pickup Location',
                    style: GoogleFonts.signikaNegative(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Go Drive\nEttumanoor-Ernakulam Road,Vyttila\nNear Tony&Guy 682019',
                    style: GoogleFonts.gowunBatang(
                        fontSize: 13,
                        color: ProjectColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '- GO DRIVE -',
                          style: GoogleFonts.oswald(),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
