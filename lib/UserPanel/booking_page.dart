import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxurycars/Database/FirebaseDatabaseHelper.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/viewontapInventory.dart';
import 'package:luxurycars/main.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const BookingPage({super.key, required this.data});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pickupDateController = TextEditingController();
  final TextEditingController _dropoffDateController = TextEditingController();
  late String modelname = widget.data['model'];
  late String company = widget.data['Company'];
  late String category = widget.data['Category'];
  late double priceperday = double.parse(widget.data['PricePerDay']);
  late String gearbox = widget.data['Gearbox'];
  late String engine = widget.data['Engine'];
  late String transmission = widget.data['Transmission'];
  late String fueltype = widget.data['Fuel Type'];
  late String fueltank = widget.data['Fuel Tank'];
  late String groundclearence = widget.data['Ground Clearence'];
  late String maxtorque = widget.data['MaxTorque'];
  late String maxpower = widget.data['MaxPower'];
  late String seating = widget.data['Seating'];
  late String zeroto = widget.data['Zero'];
  late String image = widget.data['image'];
  late String number = widget.data['numberplate'];
  late String docsid = widget.data['docsid'];

  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _pickupDate;
  DateTime? _dropoffDate;
  late final double _dailyRate = priceperday;
  double _totalCost = 0.0;

  void _calculateTotalCost() {
    if (_pickupDate != null && _dropoffDate != null) {
      final difference = _dropoffDate!.difference(_pickupDate!).inDays;
      _totalCost = difference * _dailyRate;
    } else {
      _totalCost = 0.0;
    }
    setState(() {
      _pickupDateController.text =
          _pickupDate != null ? _dateFormat.format(_pickupDate!) : '';
      _dropoffDateController.text =
          _dropoffDate != null ? _dateFormat.format(_dropoffDate!) : '';
    });
  }

  Widget row({
    required details,
    required label,
  }) {
    return Row(
      children: [
        Row(
          children: [
            const Icon(
              Icons.car_rental_outlined,
              color: const Color.fromARGB(255, 82, 82, 82),
            ),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 82, 82, 82)),
            ),
          ],
        ),
        Text(
          details,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 54, 54, 54)),
        ),
      ],
    );
  }

  // ignore: prefer_function_declarations_over_variables
  final validator = (value) {
    if (value == null || value.isEmpty) {
      return 'Please Fill This Field !';
    } else {
      return null;
    }
  };
  final formkeycheck = GlobalKey<FormState>();
  final topicstyle = TextStyle(
      fontSize: 20,
      color: ProjectColors.secondarycolor2,
      fontWeight: FontWeight.bold);
  final textstyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ProjectColors.secondarycolor2,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: ProjectColors.secondarycolor2,
        title: const Text(
          'Book Your Inventory',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) =>
                      ParticularInventory(id: widget.data['docsid'])));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' $company\n$modelname',
                            style: textstyle,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Category : ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 82, 82, 82)),
                              ),
                              Text(
                                category,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 82, 82, 82)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 90, width: 90, child: Image.network(image))
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Inventory Details',
                            style: topicstyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          row(
                              details: '₹ $priceperday/-',
                              label: ' Price Per Day : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(
                              details: '$maxpower hp',
                              label: ' Maximum Power : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(
                              details: '$maxtorque nm',
                              label: ' Maximum Torque : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(
                              details: '$fueltank ltrs',
                              label: ' Fuel Tank Capacity : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(details: '$fueltype ', label: ' Fuel Type : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(
                              details: '$transmission ',
                              label: ' Transmission : '),
                          const SizedBox(
                            height: 10,
                          ),
                          row(details: '$gearbox speed', label: ' Gearbox : '),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                'Booking Details',
                style: topicstyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: formkeycheck,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          validator: validator,
                          controller: _pickupDateController,
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            setState(() {
                              _pickupDate = pickedDate;
                            });
                            _calculateTotalCost();
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            labelText: 'Pickup Date',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          keyboardType: TextInputType.none,
                          validator: validator,
                          controller: _dropoffDateController,
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _pickupDate ?? DateTime.now(),
                              firstDate: _pickupDate ?? DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            setState(() {
                              _dropoffDate = pickedDate;
                            });
                            _calculateTotalCost();
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            labelText: 'Dropoff Date',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Personal Details',
                        style: topicstyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          validator: validator,
                          controller: _namecontroller,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          validator: validator,
                          controller: _phonenumbercontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          controller: _emailcontroller,
                          validator: validator,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0)),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 10),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total Cost:   ₹${_totalCost.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .03,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Center(
                  child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * .8,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ProjectColors.secondarycolor2),
                    onPressed: () {
                      if (formkeycheck.currentState!.validate()) {
                        uploadbookingdata();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => ParticularInventory(
                                  id: docsid,
                                )));
                        snackbar();
                      } else {}
                    },
                    child: const Text(
                      'Request Rental',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }

  snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 0, 189, 6),
      content: Text(
        'Booking Request Sent',
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      duration: Duration(seconds: 3),
    ));
  }

  uploadbookingdata() async {
    Map<String, dynamic> bookingdetails = {
      "Totalprice": _totalCost.toString(),
      "FullName": _namecontroller.text,
      "Email": _emailcontroller.text,
      "PhoneNumber": _phonenumbercontroller.text,
      "Image": image,
      "Company": company,
      "Category": category,
      "ModelName": modelname,
      "emailuser": usercurrent,
      "NumberPlate": number,
      "pickupdate": _pickupDate.toString(),
      "dropoffdate": _dropoffDate.toString()
    };
    DatabaseMethods().Addbookingdetails(bookingdetails);
  }
}
