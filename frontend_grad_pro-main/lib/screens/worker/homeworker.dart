import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/chat/HomeScreen.dart';
import 'package:flutter_app/screens/worker/assignedorder.dart';
import 'package:flutter_app/screens/worker/loginw.dart';
import 'package:flutter_app/screens/worker/pendingorder.dart';
import 'package:flutter_app/screens/worker/profile.dart';
import 'package:flutter_app/services/methods.dart';
//import 'package:/cleaning.dart';

class HomeScreen extends StatefulWidget {
  var name, phonenumber;
  HomeScreen(this.phonenumber, this.name);
  @override
  _HomeScreenState createState() => _HomeScreenState(phonenumber, name);
}

class _HomeScreenState extends State<HomeScreen> {
  var name, phonenumber;
  TextEditingController namecontrol = TextEditingController();

  _HomeScreenState(this.phonenumber, this.name);
  @override
  void initState() {
    // TODO: implement initState
    print(name);
    namecontrol.text = name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              // <-- SEE HERE

              decoration: BoxDecoration(
                  color: Color(0xffE63220),
                  image: DecorationImage(
                    image: AssetImage("assets/logo3.png"),
                    scale: 2.3,
                    alignment: FractionalOffset.center,
                  )),
              accountName: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              accountEmail: Text(
                "services at your fingertips",
                style: TextStyle(
                  height: 4,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              //   currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              trailing: Icon(
                Icons.account_circle,
              ),
              title: const Text('اعداد حسابي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatProfile(name)));
              },
            ),
            ListTile(
              trailing: Icon(
                Icons.shopping_cart,
              ),
              title: const Text('طلباتي',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => BookingPage(name)));
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
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SignupWPage()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPagew()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          /*   Container(
            height: size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
              alignment: Alignment.topCenter,
              image: Image.network(
                      "https://mars-metcdn-com.global.ssl.fastly.net/content/uploads/sites/101/2019/04/30162428/Top-Header-Background.png")
                  .image,
            )),
          ),*/
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  color: const Color(0xffE63220),
                  height: 78,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        iconSize: 35,
                        color: Colors.white,
                        onPressed: () {
                          logOut(context);
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPagew()));
                        },
                        icon: Icon(Icons.logout),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Text(
                            name,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const Text(
                            //textDirection: TextDirection.rtl,
                            ' مرحبا   ',
                            style: const TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   height: 65,
                      //   child: CircleAvatar(
                      //     radius: 50,
                      //     // backgroundImage: NetworkImage(
                      //     //     "https://smoothmove.co.za/wp-content/uploads/2021/02/pp1.jpg"),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                /* Padding(
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
                    )),*/
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, right: 1.0, left: 140.0),
                  child: Text(
                    'اهلا بك صديقي الصنايعي',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      assignedorderPage(phonenumber, name)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                "https://cdn-icons-png.flaticon.com/512/3057/3057349.png",
                                height: 120,
                              ),
                              const Text('جدول اعمالي',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          print(name);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingPage(phonenumber, name)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                "https://www.seekpng.com/png/full/622-6222510_home-maintenance-services-icons.png",
                                height: 110,
                              ),
                              const Text('طلبات العملاء',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreatProfile(phonenumber)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                "https://cdn.icon-icons.com/icons2/2468/PNG/512/user_kids_avatar_user_profile_icon_149314.png",
                                height: 120,
                              ),
                              const Text('إعدادات الحساب',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chat(phonenumber)));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT96cBORRLH_jjwB0nL6H415qzni-oMfnxRSA&usqp=CAU",
                                height: 120,
                              ),
                              const Text('الرسائل',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatProfile(
                                        name,
                                      )));
                        },
                      ),
                      /* GestureDetector(
                        onTap: () {
                          logOut(context);
                          // To do
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPagew()));
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTku2oJC2M9rZu0jq3hLd7n_lgwUEFudUCVLu_XOo7bY0V_7ih5LsWA9p2LBVPFNkbVZx8&usqp=CAU",
                                height: 120,
                              ),
                              const Text('تسجيل الخروج',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
