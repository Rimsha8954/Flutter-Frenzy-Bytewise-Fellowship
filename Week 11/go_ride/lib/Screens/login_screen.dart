import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_ride/AllWidgets/progress_dialog.dart';
import 'package:go_ride/Screens/registration_screen.dart';

import '../main.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "Login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 35,
              ),
              Image(
                image: AssetImage("images/main_logo.png"),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              Text(
                "Login as a Rider",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Brand Bold",
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email Address is Invalid", context);
                        } else if (passwordTextEditingController.text.length <
                            7) {
                          displayToastMessage(
                              "Password should be atleast 6 digits", context);
                        } else {
                          LoginAndAuthenticateUser(context);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber[400]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(color: Colors.black)),
                          )),
                      child: Container(
                        height: 45,
                        child: Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Brand Bold",
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RegistrationScreen.idScreen, (route) => false);
                        },
                        child: Text(
                          'Do not have an account? Register now.',
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void LoginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Authenticating, please wait...");
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
              Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      // Save user data into database

      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
            if (snap.value != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.idScreen, (route) => false);
              displayToastMessage("Welcome to Home Screen", context);
            } else {
              Navigator.pop(context);
              _firebaseAuth.signOut();
              displayToastMessage(
                  "You are new to this application, please register yourself",
                  context);
            }
          } as FutureOr Function(DatabaseEvent value));
    } else {
      //error occured
      Navigator.pop(context);
      displayToastMessage(
          "Error occured while signing you in Please try again:(", context);
    }
  }
}
