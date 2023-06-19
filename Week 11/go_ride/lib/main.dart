import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_ride/DataHandler/app_data.dart';
import 'package:go_ride/Screens/login_screen.dart';
import 'package:go_ride/Screens/registration_screen.dart';
import 'package:provider/provider.dart';
import 'Screens/home_screen.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


DatabaseReference usersRef  = FirebaseDatabase.instance.reference().child("users");


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Go Ride App',
        theme: ThemeData(
          primaryColor: Colors.amber[300],
        ),

        initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : HomeScreen.idScreen,
        routes: {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
          LoginScreen.idScreen: (context) => LoginScreen(),
          HomeScreen.idScreen: (context) => HomeScreen(),

        },
      ),
    );
  }
}
