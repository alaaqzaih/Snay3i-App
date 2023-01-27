import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/splash_map.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

// ignore: use_key_in_widget_constructors
class Mapworker extends StatefulWidget {
  var lati, long;

  Mapworker({this.lati, this.long});
  @override
  // ignore: library_private_types_in_public_api
  _MapworkerState createState() => _MapworkerState(lati, long);
}

class _MapworkerState extends State<Mapworker> {
  List<Marker> marker = [];
  final MapController _mapctl = MapController();
  var lati, long;
  _MapworkerState(this.lati, this.long);

  var point = LatLng(32.04198170956528, 35.214836562281235);

  setMarker() {
    return marker;
  }

  addMarker(lati, long) {
    marker.add(Marker(
        point: LatLng(lati, long),
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

  location() async {
    var latlng = await LatLng(lati, long);
    double zoom = 15.0;
    print(latlng);
    await addMarker(lati, long);
    await _mapctl.move(latlng, zoom);
  }

  @override
  void initState() {
    // TODO: implement initState
    location();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffE63220),
        title: const Text(
          'موقع العميل ',
          textDirection: TextDirection.rtl,
        ),
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
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(markers: setMarker())
          ]),
    );
  }
}
