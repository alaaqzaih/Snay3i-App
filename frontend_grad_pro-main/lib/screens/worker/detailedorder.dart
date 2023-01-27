// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/worker/homeworker.dart';
import 'package:flutter_app/screens/worker/mapworker.dart';
import 'package:flutter_app/screens/worker/pendingorder.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/services/index.dart';

class DetailsPage extends StatefulWidget {
  var val, id, name, phonenumber, time, workerid, lati, long, workerphonenumber;
  DetailsPage(
    this.val,
    this.id,
    this.name,
    this.phonenumber,
    this.time,
    this.workerid,
    this.lati,
    this.long,
    this.workerphonenumber,
  );
  @override
  _DetailsPageState createState() => _DetailsPageState(val, id, name,
      phonenumber, time, workerid, lati, long, workerphonenumber);
}

class _DetailsPageState extends State<DetailsPage> {
  var val, id, workerid, lati, long, workername;
  String name = "", phonenumber = "", workerphonenumber;
  getspacificorder service = getspacificorder();
  var _rating;
  String time;
  _DetailsPageState(
    this.val,
    this.id,
    this.name,
    this.phonenumber,
    this.time,
    this.workerid,
    this.lati,
    this.long,
    this.workerphonenumber,
  );

  getworkerorders service0 = getworkerorders();

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
            transform: Matrix4.translationValues(180.0, 0.0, 0.0),
            child: Text("... تفاصيل الطلب"),
          ),
          backgroundColor: const Color(0xffE63220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BookingPage(workerphonenumber, 'احمد عيد')));
            },
          ),
        ),
        body: _mountainDellPage());
  }

  _mountainDellPage() {
    return Column(children: [
      const SizedBox(
        height: 50.0,
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(val.data['service'],
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.home_repair_service_outlined,
              color: Color(0xffE63220),
              size: 28.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(time,
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.schedule,
              color: Color(0xffE63220),
              size: 28.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name.toString(),
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.person,
              color: Color(0xffE63220),
              size: 28.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              phonenumber.toString(),
              style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(
              Icons.call,
              color: Color(0xffE63220),
              size: 28.0,
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              val.data['address'][1],
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(
                Icons.location_pin,
                color: Color(0xffE63220),
                size: 28.0,
              ),
              color: Color.fromARGB(255, 8, 152, 201),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Mapworker(
                              lati: lati,
                              long: long,
                            )));
              },
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 60.0,
            ),
            Wrap(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(
                  width: 4.0,
                ),
              ],
            )
          ],
        ),
      ),
      const Divider(),
      Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 200.0,
            ),
            Wrap(
              // ignore: prefer_const_literals_to_create_immutables
              children: [],
            )
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(right: 120.0, bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              //margin: const EdgeInsets.only(left: 50.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.done),
                label: const Text(
                  "قبول الطلب",
                ),
                onPressed: () {
                  showAlertDialog(context, workerid, time, id, name);
                  // showAlertDialog(
                  //     context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
              /* child: MaterialButton(
                    minWidth: 150.0,
                    height: 50.0,
                    color: const Color(0xffF8C80E),
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color(0xffF8C80E),
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                    child: const Text('تأكيد الطلب',
                        style: TextStyle(
                            color: Color(0xffE63220),
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    onPressed: () {
                      showAlertDialog(context, workerid, time, id, name);
                    })*/
            )
          ],
        ),
      ),
      const Divider(),
    ]);
  }
}

showAlertDialog(BuildContext context, workerid, time, id, name) {
  // set up the buttons
  Widget cancelButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.black,
    ),
    child: Text("لا"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.black,
    ),
    child: Text("نعم"),
    onPressed: () {
      if (time.contains('غدا')) {
        time = time.replaceAll('غدا', 'Tomorrow');
        print(time);
      } else {
        time = time.replaceAll('اليوم', "Today");
      }
      AuthService().addtimeforworker(workerid, time);
      AuthService().acceptrequest(id);
      AuthService().getworkernameandphonenumber(workerid).then((val) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BookingPage(val.data['phonenumber'], val.data['name'])));
      });
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //title: Text("AlertDialog"),
    backgroundColor: Color.fromARGB(255, 248, 241, 145),

    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
    content: Text("هل انت متأكد؟"),
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
