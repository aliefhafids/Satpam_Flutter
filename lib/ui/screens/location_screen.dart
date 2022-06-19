import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../services/location_services.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String country = '';
  String name = '';
  String street = '';
  String postalCode = '';

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  Future<void> getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(SatpamLocation.lat, SatpamLocation.long);

    print(placemark[0].country);
    print(placemark[0].name);
    print(placemark[0].street);
    print(placemark[0].postalCode);

    setState(() {
      country = placemark[0].country!;
      name = placemark[0].name!;
      street = placemark[0].street!;
      postalCode = placemark[0].postalCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Lat : " + "${SatpamLocation.lat}"),
            Text("Long : " + "${SatpamLocation.long}"),
            Text("Country : " + "$country"),
            Text("Name : " + "$name"),
            Text("Street : " + "$street"),
            Text("PostalCode : " + "$postalCode"),
          ],
        ),
      ),
    );
  }
}
