import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class popularinventories extends StatefulWidget {
  popularinventories({super.key});

  @override
  State<popularinventories> createState() => _popularinventoriesState();
}

class _popularinventoriesState extends State<popularinventories> {
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    advertisementsReference =
        FirebaseFirestore.instance.collection('popular inventories');
  }

  title({required context}) {
    return GoogleFonts.gowunBatang(
        fontSize: MediaQuery.of(context).size.width * .04,
        fontWeight: FontWeight.bold,
        color: ProjectColors.primarycolor1);
  }

  text({required context}) {
    return GoogleFonts.gowunBatang(
        fontSize: MediaQuery.of(context).size.width * .037,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 84, 84, 84));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .44,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((doc) {
                return Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width * .1,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .42,
                        width: MediaQuery.of(context).size.width * .74,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 237, 237),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .05,
                      left: MediaQuery.of(context).size.width * .05,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .85,
                        child: CachedNetworkImage(
                          imageUrl: doc['Image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .25,
                      left: MediaQuery.of(context).size.width * .15,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .12,
                        width: MediaQuery.of(context).size.width * .63,
                        child: Column(
                          children: [
                            Text(
                              doc['Company'].toString().toUpperCase(),
                              style: GoogleFonts.oswald(),
                            ),
                            Text(
                              doc['Model Name'].toString().toUpperCase(),
                              style: GoogleFonts.oswald(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .05,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .04,
                              width: MediaQuery.of(context).size.width * .7,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) =>
                                          ParticularInventory(id: doc['Id'])));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    backgroundColor:
                                        ProjectColors.primarycolor1,
                                    elevation: 0),
                                child: Text(
                                  'BOOK NOW',
                                  style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .012,
                      left: MediaQuery.of(context).size.width * .55,
                      child: Text(
                        ' ₹ ${doc['Price']}/day',
                        style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w500,
                            color: ProjectColors.primarycolor1),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(
              child: Text(
                'Check Your Internet Connection',
                style: title(context: context),
              ),
            );
          }
        },
        stream: advertisementsReference.snapshots(),
      ),
    );
  }
}
