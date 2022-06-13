import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Container();
  }
}
