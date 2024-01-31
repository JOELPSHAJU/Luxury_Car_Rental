import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectColors {
  static Color get primarycolor1 => const Color.fromARGB(255, 36, 127, 160);
  static Color get primarycolor2 => const Color.fromARGB(255, 40, 0, 66);

  static Color get secondarycolor1 => const Color.fromARGB(255, 54, 0, 101);
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

class ProjectUtils {
  final primarycolor = Color.fromARGB(255, 18, 41, 221);
  final secondarycolor = const Color.fromARGB(255, 156, 120, 11);

  sucessmessage({required context, required text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 0, 189, 6),
      content: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  errormessage({required context, required text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 189, 0, 0),
      content: Text(
        text,
        style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  button({
    required context,
    required text,
    required Color,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(color: Color, borderRadius: BorderRadius.circular(100)),
      height: MediaQuery.of(context).size.height * .07,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.signikaNegative(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height * 0.03,
              color: Colors.white),
        ),
      ),
    );
  }

  final textformfieldcolor = Color.fromARGB(255, 14, 42, 65);
  textformfield(
      {required icon,
      required controller,
      required obsecure,
      required focusedcolor,
      required enabled,
      required iconcolor}) {
    return TextFormField(
      cursorColor: ProjectUtils().textformfieldcolor,
      cursorWidth: 3,
      style: GoogleFonts.signikaNegative(
        fontWeight: FontWeight.w500,
        color: ProjectUtils().textformfieldcolor,
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Fill This Field !';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: ProjectUtils().textformfieldcolor,
            ),
            borderRadius: BorderRadius.circular(100)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: enabled),
            borderRadius: BorderRadius.circular(100)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Color.fromARGB(255, 225, 15, 0),
            ),
            borderRadius: BorderRadius.circular(100)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: focusedcolor,
            ),
            borderRadius: BorderRadius.circular(100)),
        prefixIcon: Icon(
          icon,
          size: 23,
          color: iconcolor,
        ),
      ),
      obscureText: obsecure,
    );
  }

  textformfieldaddinventory(
      {required controller,
      required keyboardtype,
      required focusedcolor,
      required enabled,
      required context,
      required hint}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      child: TextFormField(
          cursorColor: ProjectUtils().textformfieldcolor,
          cursorWidth: 3,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ProjectUtils().textformfieldcolor,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Fill This Field !';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            label: Text(hint),
            labelStyle: GoogleFonts.signikaNegative(
                color: Color.fromARGB(159, 0, 0, 0),
                fontWeight: FontWeight.bold),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(100)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 225, 15, 0),
                ),
                borderRadius: BorderRadius.circular(100)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: ProjectColors.primarycolor1,
                ),
                borderRadius: BorderRadius.circular(100)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          )),
    );
  }

  headingsmall({required context, required color, required text}) {
    return Text(
      text,
      style: GoogleFonts.gowunBatang(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.019,
      ),
    );
  }

  final listcolor = Color.fromARGB(255, 255, 255, 255);
  headingbig({required context, required text, required color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.039,
          fontFamily: 'fonts/Righteous-Regular.ttf',
          color: color),
    );
  }

  final sizedbox10 = const SizedBox(
    height: 10,
  );
  final sizedbox20 = const SizedBox(
    height: 20,
  );
  static const List<String> companylist = <String>[
    'Aston Martin',
    'Audi',
    'Bently',
    'Buggatti',
    'BMW',
    'Ferrari',
    'Ford',
    'Lamborghini',
    'Land Rover',
    'Mazda',
    'Mclaren',
    'Mercedes-Benz',
    'Porshe',
    'RollsRoyce',
    'Tesla',
    'Toyota'
  ];
}
