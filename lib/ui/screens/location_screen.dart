import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../services/location_services.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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

    print(placemark[0].street);
    print(placemark[0].postalCode);

    setState(() {
      street = placemark[0].street!;
      postalCode = placemark[0].postalCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Komplek App',
          style:
              GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://assets10.lottiefiles.com/private_files/lf30_7tjsbbp7.json'),
            SizedBox(
              height: 30,
            ),
            Text(
              "Lat : " + "${SatpamLocation.lat}",
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
            Text(
              "Long : " + "${SatpamLocation.long}",
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
            Text(
              "Street : " + "$street",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              "PostalCode : " + "$postalCode",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
