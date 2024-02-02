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
                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 4,
                      width: MediaQuery.of(context).size.width * .96,
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        ParticularInventory(id: doc['Id'])));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  height:
                                      MediaQuery.of(context).size.height * .25,
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: Center(
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                              color:
                                                  ProjectColors.primarycolor1,
                                            ),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                        imageUrl: doc['Image']),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${doc['Company']}  ${doc['Model Name']}",
                                  style: title(context: context),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Color.fromARGB(255, 84, 84, 84),
                                    ),
                                    Text(
                                      '  ₹' + doc['Price'] + '/day',
                                      style: text(context: context),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Color.fromARGB(255, 84, 84, 84),
                                    ),
                                    Text(
                                      '  Category : ' + doc['Category'],
                                      style: text(context: context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .04,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  ParticularInventory(
                                                      id: doc['Id'])));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            side: BorderSide(
                                                color: ProjectColors
                                                    .primarycolor1) // <-- Radius
                                            ),
                                        backgroundColor: Colors.transparent,
                                        elevation: 0),
                                    child: const Text(
                                      'Book Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 12, 12, 12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
