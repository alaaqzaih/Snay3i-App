// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/screens/client/workers.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class servicesPage extends StatefulWidget {
  var name, address, category;
  // ignore: use_key_in_widget_constructors
  servicesPage(this.name, this.address, this.category);

  @override
  // ignore: library_private_types_in_public_api
  _servicesPageState createState() =>
      // ignore: no_logic_in_create_state
      _servicesPageState(name, address, category);
}

// ignore: duplicate_ignore
class _servicesPageState extends State<servicesPage> {
  var name, address, category, estimatedtime;
  _servicesPageState(this.name, this.address, this.category);
  var selectedService = -1;
  var selected, _rating;
  getservice service = getservice();
  @override
  void initState() {
    _rating = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: // PreferredSize(
            // preferredSize:
            //const Size.fromHeight(153.0), // here the desired height
            AppBar(
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(170.0, 0.0, 0.0),
            child: Text(
              "...اختر نوع الخدمة",
            ),
          ),
          backgroundColor: const Color(0xffE63220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectService(
                            name: name,
                          )));
            },
          ),
        ),
        // ),
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
                  print("address");
                  print(category);
                  if (selected != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => workersPage(name, address,
                                category, selected, estimatedtime)));
                  } else {
                    Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 24.0,
                      msg: "قم باختيار الخدمة اولا",
                    );
                  }
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
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
                      padding:
                          EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
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
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder<List>(
                  future: service.getAllCategory(),
                  builder: (context, snapshot) {
                    //  print(snapshot.data);
                    if (snapshot.hasData) {
                      //print(snapshot.data);
                      var d = snapshot.data?.length;
                      List<int> neededservices = [];
                      for (var i = 0; i < snapshot.data!.length; i++) {
                        if (snapshot.data![i]['catname'] == category) {
                          neededservices.add(i);
                        }
                      }
                      if (neededservices.length == 0) {
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
                              childAspectRatio: 5.0,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: neededservices.length,
                            itemBuilder: (context, index) {
                              return FadeAnimation(
                                  (1.0 + index) / 4,
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          estimatedtime = snapshot
                                                  .data![neededservices[index]]
                                              ['estimatedTime'];
                                          selected = snapshot
                                                  .data![neededservices[index]]
                                              ['service'];
                                          print(snapshot
                                                  .data![neededservices[index]]
                                              ['service']);
                                          if (selectedService == index)
                                            selectedService = -1;
                                          else
                                            selectedService = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: selectedService == index
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade100,
                                          border: Border.all(
                                            color: selectedService == index
                                                ? Color(0xffF8C80E)
                                                : Color(0xffF8C80E)
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
                                                  Text(
                                                    estimatedt(snapshot.data![
                                                            neededservices[
                                                                index]]
                                                            ['estimatedTime']
                                                        .toString()),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[700],
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 120,
                                                  ),
                                                  Text(
                                                    snapshot.data![
                                                        neededservices[
                                                            index]]['service'],
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    snapshot.data![
                                                            neededservices[
                                                                index]]['Img']
                                                        .toString(),
                                                    width: 35,
                                                    height: 35,
                                                  ),
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
                          'لايوجد معلومات',
                          textDirection: TextDirection.rtl,
                        ),
                      );
                    }
                  }),
            )));
  }

  estimatedt(est) {
    var h = int.parse(est) ~/ 60;
    var m = int.parse(est) % 60;
    print(h);
    return h.toString() + " " + "س" + " " + m.toString() + " " + "د";
  }
}
