import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_flutter/ui/screens/check_screen.dart';

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
        child: GestureDetector(
          onTap: () {
            scanQR();
          },
          child: Container(
            height: 60,
            width: 120,
            color: Color(0xFF6697BF),
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
      ),
    );
  }
}
