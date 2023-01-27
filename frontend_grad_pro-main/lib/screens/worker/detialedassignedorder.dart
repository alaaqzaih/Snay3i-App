// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_app/provider/home_screen.dart';
import 'package:flutter_app/provider/timer_provider.dart';
import 'package:flutter_app/screens/worker/assignedorder.dart';
import 'package:flutter_app/screens/worker/homeworker.dart';
import 'package:flutter_app/screens/worker/mapworker.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/services/index.dart';
import 'package:provider/provider.dart';

class DetailsassignedPage extends StatefulWidget {
  var val,
      id,
      name,
      phonenumber,
      time,
      workerid,
      lati,
      long,
      workerphonenumber,
      workername;
  DetailsassignedPage(
      this.val,
      this.id,
      this.name,
      this.phonenumber,
      this.time,
      this.workerid,
      this.lati,
      this.long,
      this.workerphonenumber,
      this.workername);
  @override
  _DetailsassignedPageState createState() => _DetailsassignedPageState(
      val,
      id,
      name,
      phonenumber,
      time,
      workerid,
      lati,
      long,
      workerphonenumber,
      workername);
}

class _DetailsassignedPageState extends State<DetailsassignedPage> {
  var val, id, workerid, lati, long, workerphonenumber, workername;
  var name, phonenumber;
  getspacificorder service = getspacificorder();
  var _rating;
  var time;
  _DetailsassignedPageState(
      this.val,
      this.id,
      this.name,
      this.phonenumber,
      this.time,
      this.workerid,
      this.lati,
      this.long,
      this.workerphonenumber,
      this.workername);

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
                          assignedorderPage(workerphonenumber, workername)));
            },
          ),
        ),
        body: _mountainDellPage());
  }

  void _myCallback() {
    setState(() {
      _isPressed = true;
    });
    if (flag == 0) {
      AuthService().startrequest(id);
    }
    if (flag == 1) {
      //AuthService().endrequest(id);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  assignedorderPage(workerphonenumber, workername)));
    }
    flag = 1;
  }

  bool _isPressed = false;
  int flag = 0;
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
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(
                Icons.location_pin,
                color: Color(0xffE63220),
                size: 28.0,
              ),
              color: Color.fromARGB(255, 248, 241, 145),
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
      //    const Divider(),
      Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: ChangeNotifierProvider<TimerProvider>(
            create: (context) => TimerProvider(),
            child: HomeScreenl(
                id, workerphonenumber, val.data['service'], time, workerid)),
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
                    HomeScreen(val.data['phonenumber'], val.data['name'])));
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
