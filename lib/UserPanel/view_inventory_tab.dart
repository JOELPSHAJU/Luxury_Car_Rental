import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class ViewInventoryT extends StatefulWidget {
  final Map<String, dynamic> data;
  const ViewInventoryT({super.key, required this.data});

  @override
  State<ViewInventoryT> createState() => _ViewInventoryTState();
}

const h10 = SizedBox(
  height: 10,
);
int selectedIndex = 0;

class _ViewInventoryTState extends State<ViewInventoryT> {
  @override
  void initState() {
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          h10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedIndex != 0) {
                      selectedIndex = 0;
                    }
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(3)),
                      border: selectedIndex == 0
                          ? Border(
                              bottom: BorderSide(
                                  color: ProjectColors.primarycolor1, width: 5))
                          : Border.all(color: Colors.transparent)),
                  child: Center(
                    child: Text(
                      'Overview',
                      style: selectedIndex == 0
                          ? GoogleFonts.roboto(fontWeight: FontWeight.bold)
                          : GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: Container(
                  height: 40,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(3)),
                      border: selectedIndex == 1
                          ? Border(
                              bottom: BorderSide(
                                  color: ProjectColors.primarycolor1, width: 5))
                          : Border.all(color: Colors.transparent)),
                  child: Center(
                    child: Text(
                      'Specification',
                      style: selectedIndex == 1
                          ? GoogleFonts.roboto(fontWeight: FontWeight.bold)
                          : GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 88, 88, 88)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          h10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.data['Company'],
                      style: GoogleFonts.roboto(
                          color: const Color.fromARGB(255, 106, 106, 106),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.data['model'],
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  '₹${widget.data['PricePerDay']}/-',
                  style: GoogleFonts.roboto(
                      color: const Color.fromARGB(255, 53, 126, 55),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ],
          ),
          h10,
          Expanded(child: tabcontainer(selectedIndex: selectedIndex))
        ],
      ),
    );
  }

  tabcontainer({required int selectedIndex}) {
    if (selectedIndex == 0) {
      return TabResult1(widget: widget);
    }
    if (selectedIndex == 1) {
      return TabResult2(widget: widget);
    }
  }
}

class TabResult1 extends StatelessWidget {
  const TabResult1({
    super.key,
    required this.widget,
  });

  final ViewInventoryT widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.data['overview'],
              style: GoogleFonts.gowunBatang(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
            h10,
            h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RowSearchViewInventory(
                    image: 'assets/carTypes/engine.png',
                    last: 'hp',
                    Texts: widget.data['MaxPower']),
                RowSearchViewInventory(
                    image: 'assets/carTypes/turbo.png',
                    last: 'nm',
                    Texts: widget.data['MaxTorque']),
                RowSearchViewInventory(
                    image: 'assets/carTypes/seat.png',
                    last: 'Persons',
                    Texts: widget.data['Seating'])
              ],
            ),
            sizedboc,
            sizedboc,
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/new/company ad.jpg',
                      ),
                      fit: BoxFit.cover)),
              height: 80,
              width: MediaQuery.of(context).size.width,
            ),
            sizedboc,
            sizedboc,
          ],
        ),
      ),
    );
  }
}

class TabResult2 extends StatelessWidget {
  const TabResult2({
    super.key,
    required this.widget,
  });

  final ViewInventoryT widget;
  textstyle2({required context}) {
    return GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w300, color: ProjectColors.black);
  }

  textstyle1({required context}) {
    return GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 0, 0, 0));
  }

  @override
  Widget build(BuildContext context) {
    late List<String> infodetails = [
      widget.data['Category'],
      widget.data['Engine'],
      "${widget.data['MaxPower']}hp",
      "${widget.data['MaxTorque']}nm",
      widget.data['Transmission'],
      "${widget.data['Gearbox']}speed",
      "${widget.data['Zero']} seconds",
      widget.data['Fuel Type'],
      "${widget.data['Fuel Tank']}ltrs",
      "${widget.data['Seating']} person",
      "${widget.data['Ground Clearence']}mm"
    ];

    List<String> infotitle = [
      'Category : ',
      'Engine Capacity : ',
      'Maximum Power : ',
      'Maximum Torque : ',
      'Transmission Type : ',
      'Gearbox : ',
      'Zero To Hundred : ',
      'Fuel Type : ',
      'Fuel Tank Capacity : ',
      'Seating Capacity : ',
      'Ground Clearence : ',
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Technical Specification',
            style: GoogleFonts.roboto(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              TilesSpecification(
                  infotitle: infotitle[0],
                  infodetails: infodetails[0],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[1],
                  infodetails: infodetails[1],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[2],
                  infodetails: infodetails[2],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[3],
                  infodetails: infodetails[3],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[4],
                  infodetails: infodetails[4],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[5],
                  infodetails: infodetails[5],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[6],
                  infodetails: infodetails[6],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[7],
                  infodetails: infodetails[7],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[8],
                  infodetails: infodetails[8],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[9],
                  infodetails: infodetails[9],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              const Divider(),
              TilesSpecification(
                  infotitle: infotitle[10],
                  infodetails: infodetails[10],
                  textstyle1: textstyle1(context: context),
                  textstyle2: textstyle2(context: context)),
              h10
            ],
          ),
        ),
      ],
    );
  }
}

class TilesSpecification extends StatelessWidget {
  final String infotitle;
  final String infodetails;
  final TextStyle textstyle1;
  final TextStyle textstyle2;

  const TilesSpecification(
      {super.key,
      required this.infotitle,
      required this.infodetails,
      required this.textstyle1,
      required this.textstyle2});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 10),
          child: Text(
            infotitle,
            style: textstyle1,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 8.0),
            child: Text(
              infodetails,
              style: textstyle2,
            ),
          ),
        ),
      ],
    );
  }
}

class RowSearchViewInventory extends StatelessWidget {
  final String image;
  final String last;
  final String Texts;
  const RowSearchViewInventory(
      {super.key,
      required this.image,
      required this.last,
      required this.Texts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * .29,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            '$image',
            color: Colors.black,
            width: MediaQuery.of(context).size.width * .08,
          ),
          Text(
            '  ${Texts.toString().toUpperCase()} $last',
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color.fromARGB(255, 110, 110, 110),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
