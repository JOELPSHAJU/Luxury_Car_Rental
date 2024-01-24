import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/AdminNavigationBar.dart';

class AdminHome extends StatelessWidget {
  AdminHome({super.key});

  final mediaquerywidth = .4;

  var MediaQueryfontsize;
  final textstyle =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);
  final containerDecoration = BoxDecoration(
      color: Color.fromARGB(133, 0, 0, 0),
      borderRadius: BorderRadius.circular(0),
      border: Border.all(color: Colors.white, width: 2));
  Widget container(
      {required icon,
      required void Function() function,
      required width,
      required textsize,
      required String text}) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            width: width,
            height: 110,
            decoration: containerDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  text,
                  style: textstyle,
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryfontsize = MediaQuery.of(context).size.width * .3;
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      drawer: AdminNavigationBar(),
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .99,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/bg/devon-janse-van-rensburg-4mh4JLuFies-unsplash.jpg'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    ));
  }
}
