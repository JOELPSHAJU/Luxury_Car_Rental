import 'package:flutter/material.dart';

class InventoryUtils {
  dropdownmenu(
      {required context, required itemlist, required Function onselected()}) {
    return DropdownMenu<String>(
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      width: MediaQuery.of(context).size.width * .7,
      initialSelection: itemlist.first,
      menuHeight: 300,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
          fillColor: const Color.fromARGB(131, 255, 255, 255),
          filled: true),
      onSelected: (String? value) {
        onselected;
      },
      dropdownMenuEntries:
          itemlist.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }

  static const List<String> categorylist = <String>[
    'Sports',
    'Luxury',
    'Hybrid',
    'Fully Electric',
    'Coupe',
    'Convertible',
    'Sedan',
    'Hatchback',
    'SUV',
    'Crossover',
    'Pickup Truck',
    'Minivan',
    'Special'
  ];
  static const List<String> Transmissionvalues = <String>[
    'Full Automatic',
    'Manual',
    'Automatic + Manual'
  ];
  static const List<String> fuelType = <String>['Petrol', 'Diesel', 'Electric'];
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
