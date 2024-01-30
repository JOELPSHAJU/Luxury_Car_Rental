// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/filter_pages.dart';

import 'package:luxurycars/UserPanel/viewontapInventory.dart';

class SearchInventory extends StatefulWidget {
  const SearchInventory({super.key});

  @override
  State<SearchInventory> createState() => _SearchInventoryState();
}

final decorationTextFormField = InputDecoration(
  fillColor: const Color.fromARGB(255, 255, 255, 255),
  label: Row(
    children: [
      Icon(
        Icons.search,
        color: ProjectColors.primarycolor1,
      ),
      const SizedBox(
        width: 10,
      ),
      const Text(
        'Search Your Inventory....',
        style: TextStyle(fontWeight: FontWeight.w400),
      )
    ],
  ),
  hintStyle: const TextStyle(
      fontWeight: FontWeight.w400, color: Color.fromARGB(255, 148, 148, 148)),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide:
          const BorderSide(width: 1, color: Color.fromARGB(255, 129, 129, 129)),
      borderRadius: BorderRadius.circular(100)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: Colors.deepOrange,
      ),
      borderRadius: BorderRadius.circular(100)),
  errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.redAccent,
        width: 1,
      )),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
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
          elevation: 4,
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
            height: 50,
            child: TextFormField(
              decoration: decorationTextFormField,
              controller: _searchcontroller,
            ),
          ),
        ),
        body: Container(
          color: const Color.fromARGB(255, 239, 239, 239),
          child: Column(
            children: [
              Expanded(
                child: _resultlist.isEmpty
                    ? Center(
                        child: Stack(
                          children: [
                            Lottie.asset(
                              'assets/animations/Animation - 1706182910823.json',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Positioned(
                              bottom: 30.0,
                              left: 100.0,
                              child: Center(
                                child: Text(
                                  'Oops,No Inventory Found!',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width * .04,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 81, 81, 81),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                                      color: ProjectUtils().listcolor,
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
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .017,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Category : ${_resultlist[index]['Category']}',
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .016,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                'Price : ${_resultlist[index]['Price Per Day']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .016,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                'Fuel Type : ${_resultlist[index]['Fuel Type']}',
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .016,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
          ),
        ));
  }
}
