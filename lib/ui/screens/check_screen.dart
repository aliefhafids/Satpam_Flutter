import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_flutter/ui/screens/splash_screen.dart';

import 'home_screen.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({Key? key, required this.scanResult}) : super(key: key);
  final String scanResult;

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  bool buildWidgets = false;

  @override
  void initState() {
    super.initState();
    checkKey();
  }

  Future<void> checkKey() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("Key")
        .doc("loginKey1")
        .get();

    String key = snap["key"];

    if (widget.scanResult.toUpperCase() == key) {
      debugPrint("True");
      setState(() {
        buildWidgets = true;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 350,
            width: 350,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: new AssetImage('assets/img/check.png'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user?.uid)
                      .set({
                    'checkin': Timestamp.now(),
                  });
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
                      "Check In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(user?.uid)
                      .set({
                    'checkout': Timestamp.now(),
                  });
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
                      "Check Out",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
