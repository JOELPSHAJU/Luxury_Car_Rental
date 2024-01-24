import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';
import 'package:luxurycars/Universaltools.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.primarycolor1,
        centerTitle: true,
        title: text(text: 'Settings'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: ProjectColors.black,
            )),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
