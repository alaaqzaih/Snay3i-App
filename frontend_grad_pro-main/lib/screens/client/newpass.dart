import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewpassPage extends StatelessWidget {
  var name, oldpass, newpass;
  NewpassPage(this.name, this.oldpass);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xffE63220),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
// ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          const SizedBox(
            height: 20,
          ),
          const Text(
            ' يرجى ادخال كلمة السر الجديدة',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: TextField(
              textAlign: TextAlign.right,
              obscureText: true,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 119, 118, 118)))),
              onChanged: (value) => newpass = value,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                // AuthService()
                //     .newpassforclient(name, oldpass, newpass)
                //     .then((val) {
                //   Fluttertoast.showToast(
                //       msg: "تم التحديث بنجاح",
                //       toastLength: Toast.LENGTH_SHORT,
                //       gravity: ToastGravity.BOTTOM,
                //       backgroundColor: Colors.red,
                //       textColor: Colors.white,
                //       fontSize: 16.0);
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => SelectService(
                //                 name: name,
                //               )));
                // });
              },
              color: const Color(0xffE63220),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "انشاء",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
