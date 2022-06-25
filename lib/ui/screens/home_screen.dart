import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_flutter/ui/screens/check_screen.dart';
import 'package:sign_flutter/ui/screens/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> scanQR() async {
    String result = "";

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#0000ff", "Cancel", false, ScanMode.BARCODE);
    } catch (e) {
      print("Error");
    }

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CheckScreen(
                scanResult: result,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
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
          children: <Widget>[
            new Container(
              height: 350,
              width: 350,
              decoration: new BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: new AssetImage('assets/img/home.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                scanQR();
              },
              child: Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Color(0xFF6697BF),
                ),
                child: const Center(
                  child: Text(
                    "SCAN QRCODE",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
              },
              child: Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Color.fromARGB(255, 153, 200, 238),
                ),
                child: const Center(
                  child: Text(
                    "Location",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
