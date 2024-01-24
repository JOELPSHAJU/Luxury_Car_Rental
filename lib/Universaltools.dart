import 'package:flutter/material.dart';

class ProjectColors {
  static Color get primarycolor1 => const Color.fromARGB(255, 141, 152, 156);
  static Color get primarycolor2 => Color.fromARGB(255, 40, 0, 66);

  static Color get secondarycolor1 => Color.fromARGB(255, 54, 0, 101);
  static Color get secondarycolor2 => const Color.fromARGB(255, 65, 65, 65);

  static List<Color> get primaryG => [primarycolor2, primarycolor1];
  static List<Color> get lecondaryG => [secondarycolor1, secondarycolor2];

  static Color get black => const Color.fromARGB(255, 0, 0, 0);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Color get lightgrey => const Color.fromARGB(255, 221, 221, 221);
}

class ProjectSnakbar {
  snackbar({context, required text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 0, 189, 6),
      content: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: const Duration(seconds: 3),
    ));
  }
}
