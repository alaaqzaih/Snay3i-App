import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/client/homeuser.dart';
//import 'package:flutter_application_1/splash_map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_app/services/authservice.dart';
import 'package:flutter_app/screens/client/login.dart';

// ignore: use_key_in_widget_constructors
class Map extends StatefulWidget {
  var name;

  Map({this.name});
  @override
  // ignore: library_private_types_in_public_api
  _MapState createState() => _MapState(name);
}

class _MapState extends State<Map> {
  List<Marker> marker = [];
  final MapController _mapctl = MapController();
  var street = '';
  var city = '';
  var point = LatLng(32.04198170956528, 35.214836562281235);
  var name;
  var address;
  _MapState(this.name);

  setMarker() {
    return marker;
  }

  addMarker() {
    marker.add(Marker(
        point: LatLng(point.latitude, point.longitude),
        height: 45.0,
        width: 45.0,
        builder: (context) => Container(
              child: IconButton(
                icon: const Icon(Icons.location_on),
                color: Colors.red,
                iconSize: 46.0,
                onPressed: () {},
              ),
            )));
    return marker;
  }

  Future getAddress() async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(point.latitude, point.longitude);
    print(placeMark);
    setState(() {
      print(city);
      city = placeMark.first.locality.toString();
      street = placeMark.first.street.toString();
    });
  }

  Future getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();
    point.longitude = position.longitude;
    point.latitude = position.latitude;
    print('current location is $position');
  }

  _navegatetohome() async {
    // ignore: use_build_context_synchronously
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffE63220),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectService(
                            name: name,
                          )));
            },
          ),
          title: TextField(
            onChanged: (val) {
              print(val);
              address = val;
            },
            decoration: const InputDecoration(
              hintText: "اكتب العنوان بالتفصيل",
              hintTextDirection: TextDirection.rtl,
              hintStyle: TextStyle(color: Colors.white, fontSize: 16.0),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            textDirection: TextDirection.rtl,
          ),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        body: FlutterMap(
            mapController: _mapctl,
            options: MapOptions(
                minZoom: 4.0,
                onMapCreated: (p) async {
                  // MarkerLayerOptions(markers:await setMarker());
                },
                center: point),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(markers: setMarker())
            ]),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            //show my location
            backgroundColor: const Color(0xffE63220),
            onPressed: () async {
              await getCurrentLocation();
              print('before $name');
              var latlng = LatLng(point.latitude, point.longitude);
              double zoom = 15.0;
              _mapctl.move(latlng, zoom);
              await getAddress();
              await addMarker();
              //MarkerLayerOptions(markers:setMarker());
              print('after $point');
            },
            heroTag: null,
            child: const Icon(
              Icons.location_searching,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            //save my location to database
            backgroundColor: const Color(0xffE63220),
            onPressed: () async {
              print("try to save your locarion..");
              AuthService()
                  .savelocation(
                      point.latitude, point.longitude, name, city, address)
                  .then((val) {
                Fluttertoast.showToast(
                    msg: 'تم الحفظ بنجاح',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              });
            },
            heroTag: null,
            child: const Icon(Icons.save),
          ),
          const SizedBox(
            height: 20,
          ),
          // FloatingActionButton(
          //   //back to home
          //   backgroundColor: const Color(0xffE63220),
          //   onPressed: () async {
          //     print("jumping to home page");
          //     _navegatetohome();
          //   },
          //   heroTag: null,
          //   child: const Icon(Icons.arrow_back),
          // ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(city),
            ),
          ),
        ]));
  }
}
