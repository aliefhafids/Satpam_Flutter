import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Please Sign In",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: TextFormField(
                controller: pwController,
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Color(0xFF6697BF),
              child: FlatButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = pwController.text.trim();

                  if (email.isEmpty) {
                    print("Email is Empty");
                  } else {
                    if (password.isEmpty) {
                      print("Password is Empty");
                    } else {
                      context.read<AuthService>().login(
                            email,
                            password,
                          );
                    }
                  }
                },
                child: Text(
                  "Log in",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 3,
              color: Color.fromARGB(255, 198, 234, 234),
              child: FlatButton(
                onPressed: () {
                  final String email = emailController.text.trim();
                  final String password = pwController.text.trim();

                  if (email.isEmpty) {
                    print("Email is Empty");
                  } else {
                    if (password.isEmpty) {
                      print("Password is Empty");
                    } else {
                      context
                          .read<AuthService>()
                          .signUp(
                            email,
                            password,
                          )
                          .then((value) async {
                        User? user = FirebaseAuth.instance.currentUser;

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user?.uid)
                            .set({
                          'uid': user?.uid,
                          'email': email,
                          'password': password,
                        });
                      });
                    }
                  }
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
