import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luxurycars/main.dart';

class Userpic extends StatefulWidget {
  final String user;
  const Userpic({super.key, required this.user});

  @override
  State<Userpic> createState() => _UserpicState();
}

String? email;

class _UserpicState extends State<Userpic> {
  Map<String, dynamic>? docData;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    fetchData();

    User? user = FirebaseAuth.instance.currentUser;

    email = user?.email;
  }

  Future<void> fetchData() async {
    CollectionReference requestReplyCollection =
        FirebaseFirestore.instance.collection('profile');
    try {
      final querySnapshot = await requestReplyCollection
          .where('id', isEqualTo: widget.user)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final docSnapshot = querySnapshot.docs.first;
        String id = docSnapshot.id;
        updateuseridprofile = id;

        setState(() {
          docData = docSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        setState(() {
          docData = {};
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  fontstyle({required context}) {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height * .02,
        fontWeight: FontWeight.w500);
  }

  final sizedb = const SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    if (docData == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (docData!.isEmpty) {
      return const Center(
          child: Text(
        'Edit Profile to Add Details',
        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
      ));
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * double.infinity,
        height: MediaQuery.of(context).size.height * .28,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
        ),
        child: Center(
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 103, 103, 103),
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      );
    }
  }
}
