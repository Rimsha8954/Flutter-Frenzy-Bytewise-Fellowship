import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_ride/Screens/home_screen.dart';
import 'package:go_ride/Screens/login_screen.dart';
import 'package:go_ride/main.dart';

import '../AllWidgets/progress_dialog.dart';

class RegistrationScreen extends StatelessWidget {

  static const String idScreen = "Register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  RegistrationScreen({Key? key}) : super(key: key);

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
                height: 25,
              ),
              Image(
                image: AssetImage("images/main_logo.png"),
                width: 390,
                height: 250,
                alignment: Alignment.center,
              ),
              Text(
                "Signup as a Rider",
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
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Full Name",
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
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone number",
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
                        if (nameTextEditingController.text.length < 4) {
                          displayToastMessage("Name must be atleast 3 characters", context);
                        }
                        else if(phoneTextEditingController.text.isEmpty){
                          displayToastMessage("Phone number is mondatory", context);
                        }
                        else if(!emailTextEditingController.text.contains("@")){
                          displayToastMessage("Email Address is Invalid", context);
                        }
                        else if(passwordTextEditingController.text.length < 7){
                          displayToastMessage("Password should be atleast 6 digits", context);
                        }
                        else{
                          registerNewUser(context);
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
                            "Create an Account",
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                        child: Text(
                          'Already have an account?Signin Here',
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

  void registerNewUser(BuildContext context) async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return ProgressDialog(message: "Registering, please wait...");
        });

    final User? firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(email: emailTextEditingController.text,
        password: passwordTextEditingController.text).catchError((errMsg){
          Navigator.pop(context);
          displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
      // Save user data into database

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congradulations, your account has successfully been created", context);

      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.idScreen, (route) => false);
    }
    else {
      //error occured
      Navigator.pop(context);
      displayToastMessage("Your sccount has not been created", context);
    }
  }
}

    displayToastMessage(String message, BuildContext context){
      Fluttertoast.showToast(msg: message);
    }

