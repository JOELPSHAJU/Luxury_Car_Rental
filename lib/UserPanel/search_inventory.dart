// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/filter_pages.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class SearchInventory extends StatefulWidget {
  const SearchInventory({super.key});

  @override
  State<SearchInventory> createState() => _SearchInventoryState();
}

const String type = 'Category';

class _SearchInventoryState extends State<SearchInventory> {
  List<String> docIDs = [];
  @override
  void initState() {
    getclientstream();
    _searchcontroller.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchcontroller.text);
    searchResultList();
  }

  searchResultList() {
    var showresult = [];
    if (_searchcontroller.text != '') {
      for (var clientSnapShot in _allresults) {
        var modelname = clientSnapShot['Model Name'].toString().toLowerCase();
        var companyname = clientSnapShot['Company'].toString().toLowerCase();
        var categoryname = clientSnapShot['Category'].toString().toLowerCase();
        if (companyname.contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else if (modelname.contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else if (categoryname
            .contains(_searchcontroller.text.toLowerCase())) {
          showresult.add(clientSnapShot);
        } else {}
      }
    } else {
      showresult = List.from(_allresults);
    }
    setState(() {
      _resultlist = showresult;
    });
  }

  final TextEditingController _searchcontroller = TextEditingController();
  List _allresults = [];
  List _resultlist = [];
  getclientstream() async {
    var data = await FirebaseFirestore.instance
        .collection('cardetails')
        .orderBy(type)
        .get();
    setState(() {
      _allresults = data.docs;
    });
    searchResultList();
  }

  @override
  void didChangeDependencies() {
    getclientstream();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  final filternames = [
    'Category',
    'Price Per Day',
    'Transmission',
    'Fuel Type',
    'Model Name'
  ];
  final checktextstyle = const TextStyle(
      fontWeight: FontWeight.w400, color: Color.fromARGB(255, 110, 110, 110));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.filter_list,
              color: ProjectColors.primarycolor1,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const FilterPage()));
            },
          ),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * .9,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextFormField(
                  cursorColor: Colors.black,
                  cursorWidth: 1,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  controller: _searchcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Fill This Field !';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Search your inventory',
                    hintStyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 10),
                    border: InputBorder.none,
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  )),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _resultlist.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/animations/Animation - 1706182910823.json',
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Text(
                                'Oops,No Inventory Found!',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 81, 81, 81),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          final price = _resultlist[index]['Price Per Day']
                              .toString()
                              .toUpperCase();
                          return GestureDetector(
                            onTap: () {
                              final selectedDocument = _resultlist[index];
                              final documentID = selectedDocument.id;

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) =>
                                      ParticularInventory(id: documentID)));
                            },
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .18,
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 229, 229, 229),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 190, 216, 218)),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          .592,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .18,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 190, 216, 218),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(15))),
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          .43,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .18,
                                        child: CachedNetworkImage(
                                          imageUrl: _resultlist[index]
                                              ['MainImage'],
                                          placeholder: (context, url) {
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          .02,
                                      child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                _resultlist[index]['Model Name']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: GoogleFonts.poppins(
                                                  color: ProjectColors.black,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .045,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                _resultlist[index]['Company'],
                                                style: GoogleFonts.poppins(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .032,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                'Category : ${_resultlist[index]['Category']}',
                                                style: GoogleFonts.poppins(
                                                  color: const Color.fromARGB(
                                                      255, 132, 132, 132),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .032,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                '₹ ${_resultlist[index]['Price Per Day']}/day',
                                                style: GoogleFonts.poppins(
                                                  color: const Color.fromARGB(
                                                      255, 80, 169, 174),
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .035,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  ],
                                )),
                          );
                        },
                        itemCount: _resultlist.length,
                      ),
              ),
            ],
          ),
        ));
  }
}
