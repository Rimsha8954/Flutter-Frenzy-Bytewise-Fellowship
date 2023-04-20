import 'package:flutter/material.dart';
import 'package:navigation_routing/screen_one.dart';
import 'package:navigation_routing/screen_three.dart';
import 'package:navigation_routing/screen_two.dart';
import 'package:navigation_routing/utils/routes_name.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RouteName.screenOne:
        return MaterialPageRoute(builder: (context) => ScreenOne());
      case RouteName.screenTwo:
        return MaterialPageRoute(builder: (context) => ScreenTwo(data: settings.arguments as Map,));
      case RouteName.screenThree:
        return MaterialPageRoute(builder: (context) => ScreenThree());
      default:
        return MaterialPageRoute(builder: (context){
          return const Scaffold(
            body: Center(child: Text('No Routes Find')),
          );
        }
        );
    }
  }
}