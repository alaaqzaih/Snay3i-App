import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/worker/assignedorder.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/provider/timer_provider.dart';

class HomeScreenl extends StatefulWidget {
  var id, workerphonenumber, service, time, workerid;
  HomeScreenl(
      this.id, this.workerphonenumber, this.service, this.time, this.workerid);
  @override
  _HomeScreenState createState() =>
      _HomeScreenState(id, workerphonenumber, service, time, workerid);
}

class _HomeScreenState extends State<HomeScreenl> {
  var timer, id, workerphonenumber, service, time, workerid;
  _HomeScreenState(
      this.id, this.workerphonenumber, this.service, this.time, this.workerid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Provider.of<TimerProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return homeScreenBody();
  }

  Widget homeScreenBody() {
    return Container(child: Consumer<TimerProvider>(
      builder: (context, timeprovider, widget) {
        return Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                // ignore: prefer_adjacent_string_concatenation
                '${timer.hour} : ${timer.minute} : ${timer.seconds} ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (timer.startEnable)
                    ? ElevatedButton(
                        onPressed: timer.startTimer,
                        child: const Text('بدء'),
                      )
                    : ElevatedButton(
                        onPressed: start(),
                        child: const Text('بدء'),
                      ),
                (timer.stopEnable)
                    ? ElevatedButton(
                        onPressed: timer.stopTimer,
                        child: const Text('توقف'),
                      )
                    : ElevatedButton(
                        onPressed: end(),
                        child: const Text('توقف'),
                      ),
                (timer.continueEnable)
                    ? ElevatedButton(
                        onPressed: timer.continueTimer,
                        child: const Text('استمرار'),
                      )
                    : ElevatedButton(
                        onPressed: start(),
                        child: const Text('استمرار'),
                      ),
              ],
            ),
          ],
        );
      },
    ));
  }

  start() {
    AuthService().startrequest(id);
  }

  end() {
    int sum = 0;
    var average = 0.0;
    var count = 0.0;
    var est = timer.hour * 60 + timer.minute;
    AuthService().endrequest(id, est);
    AuthService().removetimeforworker(workerid, time);
    AuthService().getlast10times(service).then((val) {
      print(val.data['msg']);
      for (int i = 0; i < val.data!['msg'].length; i++) {
        // ignore: unnecessary_null_comparison
        if (val.data!['msg'][i]['durationTime'].toString() == "null") {
          continue;
        }
        print(val.data['msg'][i]['durationTime']);
        print(val.data['msg'][i]['service']);
        sum += int.parse(
            val.data!['msg'][i]['durationTime'].toString().split(" ")[0]);
        count++;
      }
      print(sum);
      print(count);
      average = sum / count;
      AuthService().changeestimatedtime(service, average.round());
      print(average.round());
    });
  }
}
