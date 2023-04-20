import 'package:flutter/material.dart';
import 'package:navigation_routing/utils/routes.dart';
import 'package:navigation_routing/utils/routes_name.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteName.screenOne,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

