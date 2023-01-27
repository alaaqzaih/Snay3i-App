import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/screens/chat/HomeScreen.dart';
import 'package:flutter_app/screens/client/booking.dart';
import 'package:flutter_app/screens/client/oldpass.dart';
import 'package:flutter_app/screens/client/services.dart';
import 'package:flutter_app/services/methods.dart';
import 'package:flutter_app/screens/client/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/login.dart';
import 'package:flutter_app/services/index.dart';
import 'package:flutter_app/screens/client/map.dart';
import 'package:flutter_app/screens/worker/signupworker.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectService extends StatefulWidget {
  var name;

  SelectService({this.name});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SelectServiceState createState() => _SelectServiceState(name);
}

class _SelectServiceState extends State<SelectService> {
  var name, address = '0';
  _SelectServiceState(this.name);
  getcat service = new getcat();
  var selectedcat;
  var n = 0;
  int selectedService = -1;
  var txt = TextEditingController();
  @override
  void initState() {
    service.getAllCategory();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = RemoteNotification();
      AndroidNotification android = AndroidNotification();
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    color: Colors.blue,
                    playSound: true,
                    icon: "@mipmap/ic_launcher")));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp was published! ');
      RemoteNotification notification = RemoteNotification();
      AndroidNotification android = AndroidNotification();
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
    setaddress();
    sendnotification();
    showpuplicNotification();
  }

  void sendnotification() {
    AuthService().getorderfornot(name).then((val) {
      for (int i = 0; i < val.data.length; i++) {
        print(val.data[i]['status']);
        if (val.data[i]['status'] == 'قيد التنفيذ') {
          showNotification_accept();
        }
      }
    });
  }

  void showNotification() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});

    FlutterLocalNotificationsPlugin().show(
        0,
        "اكمال الملف الشخصي",
        "الرجاء استخدام الخريطة في تحديد موقعك",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/ic_launcher")));
  }

  void showpuplicNotification() async {
    await Future.delayed(const Duration(milliseconds: 12000), () {});

    FlutterLocalNotificationsPlugin().show(
        0,
        "🤹‍♂️🔧 صيانة المكيفات لعبتنا ",
        "🚴‍♂️ اطلب صنايعي تكييف ولا تشيل هم ",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/ic_launcher")));
  }

  void showNotification_accept() {
    FlutterLocalNotificationsPlugin().show(
        0,
        "تم تأكيد طلبك",
        "تم تأكيد طلبك من قبل مزود الخدمة",
        NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/ic_launcher")));
  }

  setaddress() async {
    AuthService().getlocation(name).then((val) {
      address = val.data['msg'];
      txt.text = address.split(",")[1];
      if (address == 'undefined , undefined') {
        address = 'قم بتحديد موقعك';
        print(address);
        txt.text = address;
        showNotification();
      }
    });
  }

  gridview(AsyncSnapshot<dynamic> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: snapshot.data.map((service) {
            return GestureDetector(
                child: const GridTile(
                  child: Text("dymmy"),
                ),
                onTap: () {});
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {
                  if (address == "قم بتحديد موقعك") {
                    Fluttertoast.showToast(
                        msg: "قم بتحديد موقعك",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    print(name);
                    print(address);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                servicesPage(name, address, selectedcat)));
                  }
                },
                child: Icon(Icons.navigate_before),
                backgroundColor: Color(0xffE63220),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xffE63220),
          title: Text(
            'مرحبا , $name',
            textDirection: TextDirection.rtl,
          ),
          // actions: <Widget>[
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.notifications),
          //   ),
          // ],
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                // <-- SEE HERE

                decoration: BoxDecoration(
                    color: const Color(0xffE63220),
                    image: DecorationImage(
                      image: AssetImage("assets/logo3.png"),
                      scale: 2.3,

                      // fit: BoxFit.fill,

                      alignment: FractionalOffset.center,
                    )),

                accountName: Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                accountEmail: Text(
                  "Service at your fingerprint",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 4,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                //   currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                trailing: Icon(
                  Icons.shopping_cart,
                ),
                title: const Text('طلباتي',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookingPage(name)));
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.chat,
                ),
                title: const Text('المحادثات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Chat(name)));
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.account_circle,
                ),
                title: const Text('تغيير كلمة السر',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OldpassPage(name)));
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.home_repair_service,
                ),
                title: const Text('التسجيل كمزود خدمة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupWPage()));
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.help,
                ),
                title: const Text(
                  'المساعدة',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                trailing: Icon(
                  Icons.logout,
                ),
                title: const Text(
                  'تسجيل الخروج',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  logOut(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1.2,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    child: TextField(
                      controller: txt,
                      textDirection: TextDirection.rtl,
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Map(
                                      name: name,
                                    )));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              const BorderSide(color: Color(0xffF8C80E)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            print(name);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Map(
                                          name: name,
                                        )));
                          },
                          icon: const Icon(Icons.location_pin),
                          color: const Color(0xffE63220),
                          iconSize: 35.0,
                        ),
                        hintText: "address",
                      ),
                    ),
                  ),
                )),
                SliverToBoxAdapter(
                    child: FadeAnimation(
                  1.2,
                  Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    child: Text(
                      'كيف بنقدر نساعدك اليوم؟',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ))
              ];
            },
            body: FutureBuilder<List>(
              future: service.getAllCategory(),
              builder: (context, snapshot) {
                //  print(snapshot.data);
                if (snapshot.hasData) {
                  // print(snapshot.data![0]['name']);

                  var d = snapshot.data?.length;
                  return SafeArea(
                    bottom: false,
                    child: Column(
                      children: <Widget>[
                        //CategoryList(),
                        SizedBox(height: 20.0),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Stack(
                              children: <Widget>[
                                // Our background
                                /*  Container(
                                
                                margin: const EdgeInsets.only(top: 60),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40),
                                  ),
                                ),
                              ),*/
                                GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.0,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  physics: NeverScrollableScrollPhysics(),
                                  // here we use our demo procuts list
                                  itemCount: d,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    // print(snapshot.data![index].image + "okk");
                                    return FadeAnimation(
                                        (1.0 + index) / 4,
                                        GestureDetector(
                                          onTap: () {
                                            selectedcat =
                                                snapshot.data![index]['name'];
                                            //print(selectedcat);
                                            setState(() {
                                              if (selectedService == index)
                                                selectedService = -1;
                                              else
                                                selectedService = index;
                                            });
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                Duration(milliseconds: 300),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                      snapshot.data![index]
                                                              ['image']
                                                          .toString()
                                                          .replaceAll(" ", ''),
                                                      height: 60),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                        ['name'],
                                                    style: TextStyle(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                          ),
                                        ));
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No Data Found'),
                  );
                }
              },
            )));
  }

  serviceContainer(String img, String name, int index) {
    print(name);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else {
            selectedService = index;
          }
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
                : Color(0xffF8C80E).withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(img, height: 60),
              SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}

//CleaningPage() {}