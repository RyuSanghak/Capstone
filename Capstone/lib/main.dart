import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Geolocator.dart';
import 'dart:async';

// 이승연
void main() {
  runApp(MyApp());
}

//SH Test 2

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capstone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(), // App Launching Page
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }

  @override
  State<MainPage> createState() =>_MainPageState();
}

class _MainPageState extends State<MainPage> {
  String locationMessage = 'Location not available';
  final GeolocatorService _geolocatorService = GeolocatorService(); // Create an instance GeolocatorService, GPS
  Timer? _timer;
// sanghak
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      _getLocation(); // call _getLocation() every 2 sec
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(locationMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _getLocation();
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getLocation() async { // get location info, (Latitude, Longitude)
    final position = await _geolocatorService.getCurrentPosition();
    if (position != null) {
      setState(() {
        locationMessage = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
      });
    } else {
      setState(() {
        locationMessage = 'Error getting location';
      });
    }
  }
}

