import 'package:flutter_app/provider/timer_provider.dart';
import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter_app/screens/worker/detialedassignedorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/worker/homeworker.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:provider/provider.dart';

class assignedorderPage extends StatefulWidget {
  var phonenumber, namee;
  assignedorderPage(this.phonenumber, this.namee);
  @override
  _assignedorderPageState createState() =>
      _assignedorderPageState(phonenumber, namee);
}

class _assignedorderPageState extends State<assignedorderPage> {
  var phonenumber, selectedRoom, namee;
  var _id;
  Color color = const Color(0xffF8C80E);
  _assignedorderPageState(this.phonenumber, this.namee);
  final List<int> _selectedRooms = [];
  var cat = [], img = [];
  String time = '';
  getworkerassignedorders service = getworkerassignedorders();
  @override
  void initState() {
    AuthService().getcategory().then((val) {
      for (int i = 0; i < val.data.length; i++) {
        cat.add(val.data[i]['name']);
        img.add(val.data[i]['image']);
      }
    });
    // TODO: implement initState
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
            transform: Matrix4.translationValues(150.0, 0.0, 0.0),
            child: const Text(
              " ...  جدول اعمالي",
            ),
          ),
          backgroundColor: const Color(0xffE63220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(phonenumber, namee)));
            },
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
                        top: 50.0, right: 20.0, left: 20.0),
                    child: Text(
                      "ابدأ بتنفيذ طلبات عملائك",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: FutureBuilder<List>(
              future: service.getworkerorder(phonenumber),
              builder: (context, snapshot) {
                // print(snapshot.data);
                if (snapshot.hasData) {
                  //print(snapshot.data![0]['name']);
                  var d = snapshot.data?.length;
                  if (d == 0) {
                    return const Center(
                      child: Text(
                        'لايوجد معلومات',
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  } else {
                    return SafeArea(
                      bottom: false,
                      child: Column(
                        children: <Widget>[
                          //CategoryList(),
                          const SizedBox(height: 10.0),
                          Expanded(
                            child: Stack(
                              children: <Widget>[
                                // Our background
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, right: 50),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    ),
                                  ),
                                ),
                                GridView.builder(
                                  padding: const EdgeInsets.all(15),

                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 2.9,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  // here we use our demo procuts list
                                  itemCount: d,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    if (snapshot.data![index]['status'] ==
                                        'بدء التنفيذ') {
                                      color = Colors.green;
                                    } else if (snapshot.data![index]
                                            ['status'] ==
                                        'تمت') {
                                      color = Colors.red;
                                    } else if (snapshot.data![index]
                                            ['status'] ==
                                        'قيد التنفيذ') {
                                      color = const Color(0xffF8C80E);
                                    }
                                    // print(snapshot.data![index].image + "okk");
                                    return FadeAnimation(
                                        (1.0 + index) / 4,
                                        GestureDetector(
                                          onTap: () {
                                            selectedRoom =
                                                snapshot.data![index]['name'];
                                            //print(selectedcat);
                                            setState(() {
                                              if (_selectedRooms
                                                  .contains(index)) {
                                                _selectedRooms.remove(index);
                                              } else {
                                                _selectedRooms.add(index);
                                              }
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            padding: const EdgeInsets.only(
                                                right: 3.0),
                                            decoration: BoxDecoration(
                                              color: _selectedRooms == index
                                                  ? Colors.blue.shade50
                                                  : Colors.grey.shade100,
                                              border: Border.all(
                                                color: _selectedRooms == index
                                                    ? const Color(0xffF8C80E)
                                                    : const Color(0xffF8C80E)
                                                        .withOpacity(0),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // const Spacer(),
                                                        IconButton(
                                                          icon: const Icon(
                                                              Icons.arrow_back),
                                                          color:
                                                              Colors.red[700],
                                                          highlightColor:
                                                              Colors.red,
                                                          onPressed: () {
                                                            var name,
                                                                phonenumber0;
                                                            AuthService()
                                                                .getorder(snapshot
                                                                        .data![
                                                                    index]["_id"])
                                                                .then((val) {
                                                              print(snapshot
                                                                          .data![
                                                                      index][
                                                                  "clientname"]);

                                                              name = snapshot
                                                                          .data![
                                                                      index][
                                                                  "clientname"];

                                                              AuthService()
                                                                  .getclientnameandphonenumber(
                                                                      name)
                                                                  .then(
                                                                      (result) {
                                                                var lati = result
                                                                        .data[
                                                                    "latitude"];
                                                                var long = result
                                                                        .data[
                                                                    "longitude"];
                                                                phonenumber0 =
                                                                    result.data[
                                                                        'phonenumber'];
                                                                String time0;
                                                                time = val.data[
                                                                    'time'];
                                                                if (val.data[
                                                                        'time']
                                                                    .contains(
                                                                        'Tomorrow')) {
                                                                  time0 = val
                                                                      .data[
                                                                          'time']
                                                                      .replaceAll(
                                                                          'Tomorrow',
                                                                          'غدا');
                                                                  print(time0);
                                                                } else {
                                                                  time0 = val
                                                                      .data[
                                                                          'time']
                                                                      .replaceAll(
                                                                          'Today',
                                                                          "اليوم");
                                                                }
                                                                print(lati);
                                                                var workerid =
                                                                    service
                                                                        .getid();

                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => DetailsassignedPage(
                                                                        val,
                                                                        snapshot.data![index]
                                                                            [
                                                                            "_id"],
                                                                        name,
                                                                        phonenumber0,
                                                                        time0,
                                                                        workerid,
                                                                        lati,
                                                                        long,
                                                                        phonenumber,
                                                                        namee),
                                                                  ),
                                                                );
                                                              });
                                                            });
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          width: 150,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              snapshot.data![
                                                                      index]
                                                                  ['service'],
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            if (cat.isNotEmpty)
                                                              for (int i = 0;
                                                                  i <
                                                                      cat
                                                                          .length;
                                                                  i++)
                                                                if (cat[i] ==
                                                                    snapshot.data![
                                                                            index]
                                                                        [
                                                                        'category'])
                                                                  // ignore: prefer_interpolation_to_compose_strings
                                                                  Image.asset(
                                                                    // ignore: prefer_interpolation_to_compose_strings
                                                                    img[i],
                                                                    width: 35,
                                                                    height: 35,
                                                                  ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      /* ElevatedButton.icon(
                                                      icon: const Icon(
                                                          Icons.done),
                                                      label: const Text(
                                                        "قبول الطلب",
                                                      ),
                                                      onPressed: () {
                                                        _id = snapshot
                                                                .data![index]
                                                            ['_id'];
                                                        // showAlertDialog(
                                                        //     context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Color.fromARGB(
                                                            255, 0, 112, 4),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      32.0),
                                                        ),
                                                      ),
                                                    ),*/
                                                      const SizedBox(
                                                        width: 200,
                                                      ),
                                                      ElevatedButton(
                                                        // ignore: sort_child_properties_last
                                                        child: Text(snapshot
                                                                .data![index]
                                                            ['status']),
                                                        onPressed: () => print(
                                                            "it's pressed"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: color,
                                                          onPrimary:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        32.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                          ),
                                        ));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text(
                      'لايوجد معلومات',
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }
              },
            )));
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: const Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      style: TextButton.styleFrom(
        primary: Colors.black,
      ),
      child: const Text("نعم"),
      onPressed: () {
        var id = service.getid();
        print(id);

        // if (time.contains('Tomorrow')) {
        //   time = time.replaceAll('Tomorrow', 'غدا');
        //   print(time);
        // } else {
        //   time = time.replaceAll('Today', "اليوم");
        // }
        AuthService().addtimeforworker(id, time);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      //title: Text("AlertDialog"),
      backgroundColor: const Color.fromARGB(255, 248, 241, 145),

      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      content: const Text("هل انت متأكد؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
