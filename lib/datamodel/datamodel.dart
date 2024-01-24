import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Carmodel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String company;

  @HiveField(2)
  final String transmission;

  @HiveField(3)
  final String fuelType;

  @HiveField(4)
  final String modelName;

  @HiveField(5)
  final String engineDisplacement;

  @HiveField(6)
  final String maximumPower;

  @HiveField(7)
  final String maximumTorque;

  @HiveField(8)
  final String zeroToHundred;

  @HiveField(9)
  final String seatingCapacity;

  @HiveField(10)
  final String numberPlate;

  @HiveField(11)
  final String fuelTankCapacity;

  @HiveField(12)
  final String groundClearence;

  @HiveField(13)
  final String gearbox;

  @HiveField(14)
  final String pricePerDay;

  @HiveField(15)
  final String overview;

  @HiveField(16)
  final String category;

  @HiveField(17)
  final List<String> imageUrls;

  Carmodel(
      {required this.id,
      required this.category,
      required this.company,
      required this.engineDisplacement,
      required this.fuelTankCapacity,
      required this.fuelType,
      required this.gearbox,
      required this.groundClearence,
      required this.imageUrls,
      required this.maximumPower,
      required this.maximumTorque,
      required this.modelName,
      required this.numberPlate,
      required this.overview,
      required this.pricePerDay,
      required this.seatingCapacity,
      required this.transmission,
      required this.zeroToHundred});
}
