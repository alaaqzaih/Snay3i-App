import 'package:flutter/material.dart';
//import 'package:dropdownfield/dropdownfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/screens/worker/loginw.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/services/methods.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: use_key_in_widget_constructors
class SignupWPage extends StatefulWidget {
  @override
  State<SignupWPage> createState() => _SignupWPageState();
}

class _SignupWPageState extends State<SignupWPage> {
  var name, password, phonenumber, region;
  late List<String> category = [];

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
                  borderSide: BorderSide(color: Colors.grey))),
          onChanged: (val) {
            if (label ==
                "                                                                               الاسم") {
              name = val;
            } else if (label ==
                "                                                                         كلمة السر") {
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
            size: 15,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 850),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: MediaQuery.of(context).size.height - 60,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text(
                        "هل انت مزود خدمة؟ ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "! سجل معنا اليوم لتطوير عملك وزيادة دخلك",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Column(
                    children: <Widget>[
                      inputFile(
                          label:
                              "                                                                               الاسم"),
                      inputFile(
                          label:
                              "                                                                         كلمة السر",
                          obscureText: true),
                      inputFile(
                          label:
                              "                                                                          رقم جوال"),

                      //inputFile(label: "what's your major? ", obscureText: true),
                    ],
                  ),
                  const Text(
                    "ماهو مجال عملك؟",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          'اختر مجالات عملك من هنا',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                      items: arabicitems.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,

                          //disable default onTap to avoid closing menu when selecting an item
                          enabled: false,
                          child: StatefulBuilder(
                            builder: (context, menuSetState) {
                              // ignore: no_leading_underscores_for_local_identifiers
                              final _isSelected = selectedItems.contains(item);
                              return InkWell(
                                onTap: () {
                                  print(item);
                                  _isSelected
                                      ? {
                                          selectedItems.remove(item),
                                          category.remove(
                                              items[arabicitems.indexOf(item)]),
                                          print(category),
                                          print("updated")
                                        }
                                      : {
                                          selectedItems.add(item),
                                          category.add(
                                              items[arabicitems.indexOf(item)]),
                                          print(category),
                                          print(item)
                                        };
                                  //This rebuilds the StatefulWidget to update the button's text
                                  setState(() {});
                                  //This rebuilds the dropdownMenu Widget to update the check mark
                                  menuSetState(() {});
                                },
                                child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      _isSelected
                                          ? const Icon(Icons.check_box_outlined)
                                          : const Icon(
                                              Icons.check_box_outline_blank),
                                      const SizedBox(width: 20),
                                      Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                      //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                      value: selectedItems.isEmpty ? null : selectedItems.last,
                      onChanged: (value) {},
                      buttonHeight: 40,
                      buttonWidth: 300,
                      itemHeight: 40,
                      itemPadding: EdgeInsets.all(1.0),
                      selectedItemBuilder: (context) {
                        return items.map(
                          (item) {
                            return Container(
                              alignment: AlignmentDirectional.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                selectedItems.join(', '),
                                style: const TextStyle(
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                            );
                          },
                        ).toList();
                      },
                    ),
                  ),
                  //
                  const Text(
                    "المنطقة",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  //hon
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'اختر مدينتك من هنا',
                        // textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: arabicit
                          .map((arabicit) => DropdownMenuItem<String>(
                                value: arabicit,
                                child: Text(
                                  //textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.start,
                                  arabicit,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        region = it[arabicit.indexOf(value.toString())];
                        print(region);
                        //print(it[arabicit.indexOf(value.toString())]);
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 300,
                      itemHeight: 40,
                      itemPadding: EdgeInsets.all(1.0),
                      dropdownMaxHeight: 200,
                      dropdownPadding: null,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
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
                        print("ok");
                        // ignore: avoid_print
                        print(name);
                        var firebase = '';
                        firebase = phonenumber + "@gmail.com";
                        createAccount(name, firebase, password).then((value) {
                          print(firebase);
                          AuthService()
                              .addWorker(name, password, phonenumber,
                                  selectedItems, region)
                              .then((val) {
                            Fluttertoast.showToast(
                                msg: val.data['msg'],
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPagew()));
                        });
                      },
                      color: const Color.fromARGB(255, 196, 37, 37),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "انشاء",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPagew()));
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
          )),
    );
  }
}

final List<String> it = [
  'Nablus',
  'Ramallah',
  'Jenin',
  'Tolkarm',
  'Jericho',
  'Hebron',
  'Bethlehem'
];
final List<String> arabicit = [
  'نابلس',
  'رام الله',
  'جنين',
  'طولكرم',
  'اريحا',
  'الخليل',
  'بيت لحم'
];
String? selectedValue;

///list
final List<String> items = [
  'Cleaning',
  'Plumber',
  'Electrician',
  'Painter',
  'Gardener',
  'Carpenter',
];
final List<String> arabicitems = [
  'النظافة',
  'السباكة',
  'الكهرباء',
  'التكييف',
  'الدهان',
  'حدائق',
  'النجارة',
];
List<String> selectedItems = [];


//


