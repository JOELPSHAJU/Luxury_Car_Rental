import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class popularinventories extends StatefulWidget {
  popularinventories({super.key});

  @override
  State<popularinventories> createState() => _popularinventoriesState();
}

class _popularinventoriesState extends State<popularinventories> {
  List<String> carimges = [
    'assets/bg/PicsArt_01-11-12.11.10.png',
    'assets/latest/bmw home.jpg',
    'assets/latest/5842602.jpg',
  ];
  late CollectionReference advertisementsReference;

  @override
  void initState() {
    super.initState();
    advertisementsReference =
        FirebaseFirestore.instance.collection('popular inventories');
  }

  title({required context}) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * .02,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 84, 84, 84));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .29,
                    width: MediaQuery.of(context).size.width * .96,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: MediaQuery.of(context).size.height * .25,
                              width: MediaQuery.of(context).size.width * .96,
                              child: Image.network(doc['Image'])),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                doc['Company'],
                                style: title(context: context),
                              ),
                              Text(
                                '₹' + doc['Price'] + '/day',
                                style: title(context: context),
                              ),
                            ],
                          ),
                        ),
                      ],
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
