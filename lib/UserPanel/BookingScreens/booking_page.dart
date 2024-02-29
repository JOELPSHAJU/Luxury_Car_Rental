import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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

  late String mainimage = widget.data['image'];
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
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * .035,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0))),
          ],
        ),
        Text(details,
            style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width * .035,
                fontWeight: FontWeight.w300,
                color: ProjectColors.black)),
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
  topicstyle({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * .04,
        color: ProjectColors.secondarycolor2,
        fontWeight: FontWeight.w600);
  }

  textstyle({required context}) {
    return GoogleFonts.poppins(
        fontSize: MediaQuery.of(context).size.width * .04,
        color: ProjectColors.secondarycolor2,
        fontWeight: FontWeight.w600);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: ProjectColors.primarycolor1,
        title: Text(
          'Book Your Inventory',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width * .045,
              color: Colors.white),
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
              size: 23,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
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
                              '$company\n$modelname',
                              style: textstyle(context: context),
                            ),
                            Row(
                              children: [
                                Text('Category : ',
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                .037,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                Text(
                                  category,
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .037,
                                      fontWeight: FontWeight.w500,
                                      color: const Color.fromARGB(
                                          255, 127, 127, 127)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      CachedNetworkImage(
                          placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: ProjectColors.primarycolor1,
                                ),
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageUrl: mainimage)
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
                              style: topicstyle(context: context),
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
                            row(
                                details: '$gearbox speed',
                                label: ' Gearbox : '),
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
                  style: topicstyle(context: context),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
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
                              labelStyle: GoogleFonts.gowunBatang(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
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
                              labelStyle: GoogleFonts.gowunBatang(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
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
                          style: topicstyle(context: context),
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
                              labelStyle: GoogleFonts.gowunBatang(),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(100)),
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
                              labelStyle: GoogleFonts.gowunBatang(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
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
                              labelStyle: GoogleFonts.gowunBatang(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Total Cost :  ₹${_totalCost.toStringAsFixed(2)}',
                        style: GoogleFonts.signikaNegative(
                            fontSize: MediaQuery.of(context).size.width * .045,
                            fontWeight: FontWeight.bold)),
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
                          backgroundColor: ProjectColors.primarycolor1),
                      onPressed: () {
                        if (formkeycheck.currentState!.validate()) {
                          uploadbookingdata();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (ctx) => ParticularInventory(
                                        id: docsid,
                                      )));
                          snackbar();
                        } else {
                          ProjectUtils().errormessage(
                              context: context, text: 'Please Fill The Fields');
                        }
                      },
                      child: Text('Request Rental',
                          style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * .05,
                              fontWeight: FontWeight.w500,
                              color: Colors.white))),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  snackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .4,
            height: MediaQuery.of(context).size.height * .1,
            child: LottieBuilder.asset('assets/animations/requestsent.json'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .03,
            child: const Center(
              child: Text(
                'Booking Request Sent',
                style: TextStyle(
                    color: Color.fromARGB(255, 46, 183, 0),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  uploadbookingdata() async {
    Map<String, dynamic> bookingdetails = {
      "Totalprice": _totalCost.toString(),
      "FullName": _namecontroller.text,
      "Email": _emailcontroller.text,
      "PhoneNumber": _phonenumbercontroller.text,
      "Image": mainimage,
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
