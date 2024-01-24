// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:luxurycars/AdminPanel/addInventorydata.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/filter_pages.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class SearchInventory extends StatefulWidget {
  const SearchInventory({super.key});

  @override
  State<SearchInventory> createState() => _SearchInventoryState();
}

final decorationTextFormField = InputDecoration(
  fillColor: const Color.fromARGB(255, 227, 227, 227),
  label: const Row(
    children: [
      Icon(
        Icons.search,
        color: Colors.grey,
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        'Search Your Inventory',
        style: TextStyle(fontWeight: FontWeight.w400),
      )
    ],
  ),
  hintText: 'Search Your Inventory',
  hintStyle: const TextStyle(
      fontWeight: FontWeight.w400, color: Color.fromARGB(255, 122, 122, 122)),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
      borderRadius: BorderRadius.circular(0)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.deepOrange,
      ),
      borderRadius: BorderRadius.circular(0)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: const BorderSide(color: Colors.redAccent)),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
);
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
        var companyname = clientSnapShot['Company'].toString().toLowerCase();
        if (companyname.contains(_searchcontroller.text.toLowerCase())) {
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
          leading: const Icon(Icons.search_sharp),
          toolbarHeight: 70,
          backgroundColor: ProjectColors.primarycolor1,
          title: SizedBox(
            height: 50,
            child: TextFormField(
              decoration: decorationTextFormField,
              controller: _searchcontroller,
            ),
          ),
        ),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const FilterPage()));
              },
              child: Container(
                  height: 40,
                  color: ProjectColors.primarycolor1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.filter_list_sharp),
                      text(text: 'Filter')
                    ],
                  )),
            ),
            Expanded(
              child: _resultlist.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/bg/Screenshot 2024-01-11 193510-PhotoRoom.png-PhotoRoom.png',
                          width: MediaQuery.of(context).size.height * .18,
                        ),
                        Text(
                          'Oops,No Inventory Found !',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * .04,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 81, 81, 81)),
                        )
                      ],
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final selectedDocument = _resultlist[index];
                            final documentID = selectedDocument.id;

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    ParticularInventory(id: documentID)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 168,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 195, 202, 204),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${_resultlist[index]['Image Urls'][0]}'),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_resultlist[index]['Company']}  \n${_resultlist[index]['Model Name']}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Category : ${_resultlist[index]['Category']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Price : ${_resultlist[index]['Price Per Day']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              'Fuel Type : ${_resultlist[index]['Fuel Type']}',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        );
                      },
                      itemCount: _resultlist.length,
                    ),
            ),
          ],
        ));
  }
}
