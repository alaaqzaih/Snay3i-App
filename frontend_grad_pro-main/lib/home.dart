// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class MyApp1 extends StatelessWidget {
//   const MyApp1({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: FutureBuilder<List>(
//                 future: service.getAllCategory(),
//                 builder: (context, snapshot) {
//                   return showAlertDialog(context);
//                 })));
//   }

//   showAlertDialog(BuildContext context) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       style: TextButton.styleFrom(
//         primary: Colors.black,
//       ),
//       child: Text("لا"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = TextButton(
//       style: TextButton.styleFrom(
//         primary: Colors.black,
//       ),
//       child: Text("نعم"),
//       onPressed: () {
//         // print(_id);
//         // AuthService().cancelrequest(_id);
//         // Navigator.push(context,
//         //     MaterialPageRoute(builder: (context) => SelectService(name: name)));
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       //title: Text("AlertDialog"),
//       backgroundColor: Color.fromARGB(255, 248, 241, 145),

//       shape:
//           RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
//       content: Text("هل انت متأكد؟"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
