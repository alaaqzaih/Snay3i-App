// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/screens/client/services.dart';
import 'package:flutter_app/screens/client/workers.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'dart:convert';

// ignore: must_be_immutable
class DateAndTime extends StatefulWidget {
  var name, address, category, service, worker, estimatedtime;
  List<dynamic> timing;

  // ignore: use_key_in_widget_constructors
  DateAndTime(this.name, this.address, this.category, this.service, this.worker,
      this.timing, this.estimatedtime);
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _DateAndTimeState createState() => _DateAndTimeState(
      name, address, category, service, worker, timing, estimatedtime);
}

class _DateAndTimeState extends State<DateAndTime> {
  List<dynamic> timing;
  String name, address, category, service, worker;
  var estimatedtime;
  _DateAndTimeState(this.name, this.address, this.category, this.service,
      this.worker, this.timing, this.estimatedtime);
  getworkers servic = getworkers();
  int _selectedRepeat = 0;
  String _selectedHour = '13:30';
  String selected_h = "";
  // ignore: prefer_final_fields
  ItemScrollController _scrollController = ItemScrollController();
  final List<String> hours = [];
  //  = <String>[
  //   'Today 08:00-9:00',
  //   'Today 09:00-10:00',
  //   'Today 10:00-11:00',
  //   'Today 11:00-12:00',
  //   'Today 12:00-13:00',
  //   'Today 13:00-14:00',
  //   'Today 14:00-15:00',
  //   'Today 15:00-16:00',
  //   'Today 16:00-17:00',
  //   'Today 17:00-18:00',
  //   'Today 18:00-19:00',
  //   'Tomorrow 08:00-9:00',
  //   'Tomorrow 09:00-10:00',
  //   'Tomorrow 10:00-11:00',
  //   'Tomorrow 11:00-12:00',
  //   'Tomorrow 12:00-13:00',
  //   'Tomorrow 13:00-14:00',
  //   'Tomorrow 14:00-15:00',
  //   'Tomorrow 15:00-16:00',
  //   'Tomorrow 16:00-17:00',
  //   'Tomorrow 17:00-18:00',
  //   'Tomorrow 18:00-19:00',
  // ];
  final List<String> _hours = <String>[
    'اليوم 08:00-9:00',
    'اليوم 09:00-10:00',
    'اليوم 10:00-11:00',
    'اليوم 11:00-12:00',
    'اليوم 12:00-13:00',
    'اليوم 13:00-14:00',
    'اليوم 14:00-15:00',
    'اليوم 15:00-16:00',
    'اليوم 16:00-17:00',
    'اليوم 17:00-18:00',
    'اليوم 18:00-19:00',
    'غدا 08:00-9:00',
    'غدا 09:00-10:00',
    'غدا 10:00-11:00',
    'غدا 11:00-12:00',
    'غدا 12:00-13:00',
    'غدا 13:00-14:00',
    'غدا 14:00-15:00',
    'غدا 15:00-16:00',
    'غدا 16:00-17:00',
    'غدا 17:00-18:00',
    'غدا 18:00-19:00',
  ];
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () {
      _scrollController.scrollTo(
        index: 24,
        duration: Duration(seconds: 3),
        curve: Curves.easeInOut,
      );
    });
    print(estimatedtime);
    print((int.parse(estimatedtime.toString()) / 30).ceil());
    // print("object0");
    int est = (int.parse(estimatedtime.toString()) / 30).ceil();
    print("est=$est");
    int half = (((int.parse(estimatedtime.toString()) / 30) * 10) % 10).round();
    print("half=$half");
    int esth = (est / 2).floor();
    print("esth=$esth");
    int s = 0;
    int inc = 8, initial = 8;
    for (int t = 0; inc < 20; t++) {
      String str = 'Today ';
      // ignore: prefer_interpolation_to_compose_strings
      inc = inc + esth;
      if (est % 2 == 0) {
        str = '$str$initial:00-$inc:00';
        initial = inc;
      } else {
        if (s == 0) {
          str = '$str$initial:00-$inc:30';
          initial = inc;
          inc++;
          s = 1;
        } else {
          str = '$str$initial:30-$inc:00';
          initial = inc;
          s = 0;
        }
      }
      hours.add(str);
    }
    s = 0;
    inc = 8;
    initial = 8;
    for (int t = 0; inc < 20; t = t + esth) {
      String str = 'Tomorrow ';
      // ignore: prefer_interpolation_to_compose_strings
      inc = inc + esth;
      if (est % 2 == 0) {
        str = '$str$initial:00-$inc:00';
        initial = inc;
      } else {
        if (s == 0) {
          str = '$str$initial:00-$inc:30';
          initial = inc;
          inc++;
          s = 1;
        } else {
          str = '$str$initial:30-$inc:00';
          initial = inc;
          s = 0;
        }
      }
      hours.add(str);
    }
    // print(timing[0]
    //     .toString()
    //     .split(" ")[1]
    //     .replaceAll(RegExp('[^[]]'), '')
    //     .split(":")[0]);
    for (int i = 0; i < timing.length; i++) {
      var j = int.parse(timing[i]
          .toString()
          .split(" ")[1]
          .replaceAll(RegExp('[^[]]'), '')
          .split(":")[0]);
      var comp =
          timing[i].toString().replaceAll(RegExp('[^[]]'), '').split(":")[0];
      var x = int.parse(timing[i].split("-")[1].split(":")[0]);
      // print("comp= $x");
      // print("comp= $j");

      var z = x - j;
      // print("z= $z");
      if (esth == 0) {
        z = 2 * z;
      }
      for (int k = 0; k < hours.length; k++) {
        // print("object0");
        // print("second=" + hours[k].split("-")[1].split(":")[0]);
        // print("first=" + hours[k].split(" ")[1].split(":")[0]);
        // print("compp=" + comp.split(" ")[1]);

        if (hours[k].split(" ")[0] == comp.split(" ")[0]) {
          if (half != 0) {
            while (int.parse(hours[k].split(" ")[1].split(":")[0]) <
                        int.parse(comp.split(" ")[1]) &&
                    int.parse(comp.split(" ")[1]) <
                        int.parse(hours[k].split("-")[1].split(":")[0]) ||
                int.parse(hours[k].split(" ")[1].split(":")[0]) ==
                    int.parse(comp.split(" ")[1]) ||
                int.parse(hours[k].split(" ")[1].split(":")[0]) <= x &&
                    x < int.parse(hours[k].split("-")[1].split(":")[0])) {
              // print("true000000000");
              // print(hours);
              //  hours.removeAt(k);

              z = x - j + 1;
              if (esth == 0) {
                z = x - j + 1;
              }
              while (z >= 0) {
                hours.removeAt(k);
                if (esth == 0) {
                  z--;
                } else {
                  z = z - esth;
                }
                // if (int.parse(comp.split(" ")[1]) <
                //     int.parse(hours[k].split("-")[1].split(":")[0])) {
                //   z++;
                // }
                // print("index = $z");
              }
              break;
            }
          } else {
            while (int.parse(hours[k].split(" ")[1].split(":")[0]) <
                        int.parse(comp.split(" ")[1]) &&
                    int.parse(comp.split(" ")[1]) <
                        int.parse(hours[k].split("-")[1].split(":")[0]) ||
                int.parse(hours[k].split(" ")[1].split(":")[0]) ==
                    int.parse(comp.split(" ")[1]) ||
                int.parse(hours[k].split(" ")[1].split(":")[0]) <= x &&
                    x < int.parse(hours[k].split("-")[1].split(":")[0])) {
              // print("true000000000");
              // print(hours);
              z = x - j;
              if (esth == 0) {
                z = x - j + 1;
              }
              while (z >= 0) {
                hours.removeAt(k);
                if (esth == 0) {
                  z--;
                } else {
                  z = z - esth - 1;
                }
                // if (int.parse(comp.split(" ")[1]) <
                //     int.parse(hours[k].split("-")[1].split(":")[0])) {
                //   z++;
                // }
                // print("index = $z");
              }
              break;
            }
          }
        }
      }

      // for (int y = 0; y < z; y++) {
      //   hours.removeAt(s);
      //   _hours.removeAt(s);
      //   print("s= $s");
      //   print(hours);
      // }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Transform(
            // you can forcefully translate values left side using Transform
            transform: Matrix4.translationValues(60.0, 0.0, 0.0),
            child: Text(
              '..اختر اليوم والوقت المناسب لك',
            ),
          ),
          backgroundColor: const Color(0xffE63220),
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeAnimation(
                    1,
                    Row(
                      children: [
                        const Text(""),
                        const Spacer(),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.grey.shade700,
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                    1.2,
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border:
                            Border.all(width: 1.5, color: Colors.grey.shade200),
                      ),
                      child: ScrollablePositionedList.builder(
                          itemScrollController: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemCount: hours.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_h = hours[index];
                                  print(selected_h);
                                  _selectedHour = hours[index];
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: _selectedHour == hours[index]
                                      ? Colors.orange.shade100.withOpacity(0.5)
                                      : Colors.orange.withOpacity(0),
                                  border: Border.all(
                                    color: _selectedHour == hours[index]
                                        ? Colors.orange
                                        : Colors.white.withOpacity(0),
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      hours[index]
                                          .toString()
                                          .replaceAll('Tomorrow', 'غدا')
                                          .replaceAll('Today', 'اليوم'),
                                      style: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 110.0),
                  child: MaterialButton(
                      minWidth: 150.0,
                      height: 50.0,
                      color: const Color(0xffE63220),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color(0xffE63220),
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Text('تأكيد الطلب',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      onPressed: () {
                        if (address != null) {
                          List<String> add = address.split(",");
                          AuthService()
                              .addOrder(name, add, category, service, worker,
                                  selected_h)
                              .then(
                            (val) {
                              Fluttertoast.showToast(
                                  msg: val.data['msg'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "قم بتحديد الموقع اولا",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectService(name: name)));
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
