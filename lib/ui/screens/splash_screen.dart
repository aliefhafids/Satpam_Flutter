import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sign_flutter/ui/screens/location_screen.dart';

import '../services/location_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    locationService();
  }

  Future<void> locationService() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if(_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if(_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }

    _locData = await location.getLocation();

    setState(() {
      SatpamLocation.lat = _locData.latitude!;
      SatpamLocation.long = _locData.longitude!;
    });

    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LocationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Location"),
      ),
    );
  }
}