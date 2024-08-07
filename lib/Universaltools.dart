// ignore: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectColors {
  static Color get primarycolor1 => const Color.fromARGB(255, 14, 122, 176);
  static Color get primarycolor2 => const Color.fromARGB(255, 57, 84, 188);

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
  final primarycolor = const Color.fromARGB(255, 18, 41, 221);
  final secondarycolor = const Color.fromARGB(255, 156, 120, 11);

  sucessmessage({required context, required text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 0, 189, 6),
      content: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 12, color: const Color.fromARGB(255, 255, 255, 255)),
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
        style: GoogleFonts.poppins(
            fontSize: 12, color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  warningMessage({required context, required text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color.fromARGB(255, 59, 167, 255),
      content: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 15, color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  button({
    required context,
    required text,
    required Color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: MediaQuery.of(context).size.width * .85,
            decoration: BoxDecoration(
                color: Color, borderRadius: BorderRadius.circular(5)),
            height: 58,
            child: Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  final textformfieldcolor = const Color.fromARGB(255, 14, 42, 65);
  textformfield(
      {required icon,
      required controller,
      required obsecure,
      required focusedcolor,
      required enabled,
      required label,
      required iconcolor}) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: TextFormField(
          cursorColor: Colors.black,
          cursorWidth: 1,
          style: GoogleFonts.signikaNegative(
            fontWeight: FontWeight.w500,
            color: ProjectColors.primarycolor2,
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
            hintText: label,
            hintStyle: GoogleFonts.signikaNegative(
                fontWeight: FontWeight.w300,
                color: const Color.fromARGB(255, 208, 208, 208)),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: ProjectColors.primarycolor2,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                gapPadding: 3,
                borderSide: BorderSide(width: 1, color: enabled),
                borderRadius: BorderRadius.circular(10)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromARGB(255, 255, 58, 44),
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: focusedcolor,
                ),
                borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(
              icon,
              size: 23,
              color: iconcolor,
            ),
          ),
          obscureText: obsecure,
        ),
      ),
    );
  }

  textformfieldaddnotification(
      {required icon,
      required controller,
      required obsecure,
      required focusedcolor,
      required enabled,
      required iconcolor}) {
    return SizedBox(
      child: TextFormField(
        maxLines: 4,
        minLines: 1,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.signikaNegative(
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 0, 0, 0),
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
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: ProjectUtils().textformfieldcolor,
              ),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              gapPadding: 4,
              borderSide: BorderSide(width: 1, color: enabled),
              borderRadius: BorderRadius.circular(5)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromARGB(255, 255, 58, 44),
              ),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: focusedcolor,
              ),
              borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(
            icon,
            size: 23,
            color: iconcolor,
          ),
        ),
        obscureText: obsecure,
      ),
    );
  }

  textformfieldaddoverview({
    required hint,
    required controller,
    required obsecure,
    required focusedcolor,
    required enabled,
  }) {
    return SizedBox(
      child: TextFormField(
        maxLines: 10,
        minLines: 1,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.signikaNegative(
          fontWeight: FontWeight.w500,
          color: const Color.fromARGB(255, 0, 0, 0),
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
          fillColor: Colors.white,
          filled: true,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          label: Text(hint),
          hintText: hint,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 65, 65, 65),
              fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: ProjectUtils().textformfieldcolor,
              ),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 255, 58, 44),
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: focusedcolor,
              ),
              borderRadius: BorderRadius.circular(5)),
        ),
        obscureText: obsecure,
      ),
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
          cursorColor: const Color.fromARGB(255, 37, 37, 37),
          cursorWidth: 2,
          style: GoogleFonts.signikaNegative(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 35, 35, 35),
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: hint,
            labelText: hint,
            hintStyle: const TextStyle(color: Color.fromARGB(255, 48, 48, 48)),
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 31, 51, 67)),
            filled: true,
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 225, 15, 0),
                ),
                borderRadius: BorderRadius.circular(5)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              width: 2,
              color: Colors.grey,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(5)),
          )),
    );
  }

  headingsmall({required context, required color, required text}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  final listcolor = const Color.fromARGB(255, 255, 255, 255);
  headingbig({required context, required text, required color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
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
    'Chevorlet',
    'Dodge',
    'Ferrari',
    'Ford',
    'Lamborghini',
    'Land Rover',
    'Mazda',
    'Mclaren',
    'Mercedes-Benz',
    'Nissan',
    'Porshe',
    'RollsRoyce',
    'Tesla',
    'Toyota'
  ];
}
