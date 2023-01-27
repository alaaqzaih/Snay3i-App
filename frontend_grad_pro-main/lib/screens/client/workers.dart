// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'dart:developer';

// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/date_time.dart';
import 'package:flutter_app/screens/client/services.dart';
import 'package:flutter_app/screens/client/workerprofile.dart';
import 'package:flutter_app/services/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class workersPage extends StatefulWidget {
  var name, address, category, service, estimatedtime;
  // ignore: use_key_in_widget_constructors
  workersPage(
      this.name, this.address, this.category, this.service, this.estimatedtime);

  @override
  // ignore: library_private_types_in_public_api
  _workersPageState createState() =>
      // ignore: no_logic_in_create_state
      _workersPageState(name, address, category, service, estimatedtime);
}

// ignore: duplicate_ignore
class _workersPageState extends State<workersPage> {
  var name, address, category, service0, estimatedtime;
  _workersPageState(this.name, this.address, this.category, this.service0,
      this.estimatedtime);
  var selectedworker = -1;
  var selected;
  List images = [
    'assets/A.jpg',
    'assets/D.jpg',
    'assets/E.jpg',
    'assets/C.jpg',
    'assets/B.jpg',
    'assets/E.jpg'
  ];
  getworkers service = getworkers();
  List<dynamic> i = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: // PreferredSize(
            // preferredSize:
            //const Size.fromHeight(153.0), // here the desired height
            AppBar(
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(150.0, 0.0, 0.0),
            // ignore: prefer_const_constructors
            child: Text(
              " ...اختر مزود الخدمة",
            ),
          ),
          backgroundColor: const Color(0xffE63220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          servicesPage(name, address, category)));
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn2",
                onPressed: () async {
                  print(name);
                  print(address);
                  print(category);
                  if (selected != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DateAndTime(
                                name,
                                address,
                                category,
                                service0,
                                selected,
                                i,
                                estimatedtime)));
                  } else {
                    Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 24.0,
                      msg: "قم باختيار العامل اولا",
                    );
                  }
                },
                child: const Icon(Icons.navigate_before),
                backgroundColor: const Color(0xffE63220),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1,
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 10.0, left: 10.0),
                      child: SizedBox(
                        height: 200.0,
                        width: double.infinity,
                        child: Carousel(
                          dotSize: 5.0,
                          dotSpacing: 15.0,
                          dotPosition: DotPosition.bottomCenter,
                          images: [
                            Image.asset('assets/ad2.jpg', fit: BoxFit.cover),
                            Image.asset('assets/ad1.jpg', fit: BoxFit.cover)
                          ],
                        ),
                      )),
                ))
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: service.getworker(category, address.split(" ")[0]),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;
                      print(d);
                      if (d == 0) {
                        return const Center(
                            child: Text(
                          'لا يوجد معلومات',
                          textDirection: TextDirection.rtl,
                        ));
                      } else {
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 4.0,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return FadeAnimation(
                                  (1.0 + index) / 4,
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          i = snapshot.data![index]['time'];
                                          selected =
                                              snapshot.data![index]['_id'];
                                          print(snapshot.data![index]['time']);
                                          if (selectedworker == index)
                                            selectedworker = -1;
                                          else
                                            selectedworker = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: selectedworker == index
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade100,
                                          border: Border.all(
                                            color: selectedworker == index
                                                ? const Color(0xffF8C80E)
                                                : const Color(0xffF8C80E)
                                                    .withOpacity(0),
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          var n = snapshot
                                                                  .data![index]
                                                              ['name'];
                                                          var phone = snapshot
                                                                  .data![index]
                                                              ['phonenumber'];
                                                          var about = snapshot
                                                                  .data![index]
                                                              ['about'];
                                                          if (about == null) {
                                                            about = '';
                                                          }
                                                          var region = snapshot
                                                                  .data![index]
                                                              ['region'];

                                                          var rate = snapshot
                                                                  .data![index]
                                                              ['rating'];
                                                          if (rate == null) {
                                                            rate = 0;
                                                          }
                                                          print(n);
                                                          print(
                                                              '000000000000000');
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => workerProfilePage(
                                                                      n,
                                                                      phone,
                                                                      about,
                                                                      region,
                                                                      rate,
                                                                      address,
                                                                      category,
                                                                      service0,
                                                                      estimatedtime,
                                                                      name)));
                                                        },
                                                        icon: const Icon(
                                                            Icons.arrow_back))
                                                    // Text(
                                                    //   snapshot.data![index]
                                                    //       ['phonenumber'],
                                                    //   textDirection:
                                                    //       TextDirection.rtl,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 18,
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //   ),
                                                    // ),
                                                  ]),
                                                  const SizedBox(
                                                    width: 150,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            ['name'],
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          if (snapshot.data![
                                                                      index]
                                                                  ["rating"] !=
                                                              null)
                                                            for (int i = 0;
                                                                i <
                                                                    snapshot.data![
                                                                            index]
                                                                        [
                                                                        "rating"];
                                                                i++)
                                                              const Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .orange,
                                                                size: 15,
                                                              ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    // ignore: prefer_const_literals_to_create_immutables
                                                    children: [
                                                      // Image.asset(
                                                      //   images[index],
                                                      //   width: 80,
                                                      //   height: 80,
                                                      //   matchTextDirection:
                                                      //       true,
                                                      // ),
                                                      const Icon(Icons.person,
                                                          size: 38)
                                                    ],
                                                  )
                                                ]),
                                          ],
                                        ),
                                        // ignore: prefer_const_literals_to_create_immutables
                                      )));
                            });
                      }
                    } else {
                      return const Center(
                        child: Text(
                          'لا يوجد معلومات',
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    }
                  }),
            )));
  }
}
