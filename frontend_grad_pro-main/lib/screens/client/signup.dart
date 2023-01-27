import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/services/methods.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/screens/client/login.dart';

// ignore: use_key_in_widget_constructors, must_be_immutable
class SignupPage extends StatelessWidget {
  Widget inputFile({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          textDirection: TextDirection.rtl,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        TextField(
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 119, 118, 118)))),
          onChanged: (val) {
            if (label ==
                "الاسم                                                                              ") {
              name = val;
            } else if (label ==
                "كلمة السر                                                                        ") {
              password = val;
            } else {
              phonenumber = val;
            }
          },
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  @override
  var name, password, phonenumber;
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "انشاء حساب جديد",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "! سارع بالاشتراك مجاناً  ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(
                      label:
                          "الاسم                                                                              "),
                  inputFile(
                      label:
                          "كلمة السر                                                                        ",
                      obscureText: true),
                  inputFile(
                      label:
                          "رقم جوال                                                                          "),
                  //inputFile(label: "what's your major? ", obscureText: true),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    // ignore: avoid_print
                    print("ok");
                    // ignore: avoid_print
                    var namefirebase = '';
                    if (name == null ||
                        password == null ||
                        phonenumber == null) {
                      Fluttertoast.showToast(
                          msg: "تأكد من ادخال جميع المعلومات",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (password.toString().length < 6) {
                      Fluttertoast.showToast(
                          msg: "تأكد من ادخال كلمة سر قوية",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      namefirebase = name.replaceAll(" ", "") + "@gmail.com";
                      createAccount(name, namefirebase, password).then((value) {
                        print(namefirebase);

                        AuthService()
                            .addUser(name, password, phonenumber)
                            .then((val) {
                          if (val.data['msg'] == 'تم التسجيل بنجاح') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          }
                          Fluttertoast.showToast(
                              msg: val.data['msg'],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      });
                    }
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(" تسجيل الدخول",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  const Text("هل لديك حساب؟",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

///list

// we will be creating a widget for text field