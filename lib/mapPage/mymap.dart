import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appmap/mapPage/rainfallmodel.dart';


class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  List<StationMonthlyRainfall> sta

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(15.791796, 100.986852), zoom: 6),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.hybrid,
          markers: {
            Marker(
                markerId: MarkerId('1'),
                position: LatLng(17.188360, 104.088865),
                infoWindow: InfoWindow(
                    title: 'มหาวิทยาลัยราชภัฏสกลนคร', snippet: 'สถานศึกษา')),
            Marker(
                markerId: MarkerId('2'),
                position: LatLng(17.190933280558852, 104.08471027719372),
                infoWindow: InfoWindow(
                    title: 'เอราวัณอพาร์ทเมนต์', snippet: 'หอพักของฉัน')),
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCurrentPosition,
        label: Text('My location'),
        icon: Icon(Icons.my_location),
      ),
    );
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  Future _goToCurrentPosition() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 16,
    )));
  }
}

@override
void initState() { 
  super.initState();
  _getRainfall()
}

_getRainfall() async {
    var url = 'data.tmd.go.th';
    var xxx = 'api/ThailandMonthlyRainfall/v1/index.php?uid=u64chaiyanan&ukey=5691cc0f5e8afec49ee0374e3fe95e51&format=json&year=2020';
    final response = await http.get(Uri.https(url, xxx));
    if (response.statusCode == 200) {
      rainFall rainfall =
          rainFallModel.rainFall = rainFallModel.fromJson(jsonDecode(response.body.));
      setState(() {
        stationsRainFall = rainfall.stationMonthlyRainfall;
      });
 } else {
      throw Exception('Fail');
    }
}