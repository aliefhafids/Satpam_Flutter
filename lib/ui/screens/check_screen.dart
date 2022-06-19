import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: buildWidgets
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      color: Color(0xFF6697BF),
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
                  const SizedBox(height: 20),
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
                      color: Color(0xFF6697BF),
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
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: ()  {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SplashScreen()),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 120,
                      color: Color(0xFF6697BF),
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
              )
            : const SizedBox(),
      ),
    );
  }
}
