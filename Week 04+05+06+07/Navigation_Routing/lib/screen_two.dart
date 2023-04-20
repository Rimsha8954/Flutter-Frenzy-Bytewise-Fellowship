import 'package:flutter/material.dart';
import 'package:navigation_routing/utils/routes_name.dart';

class ScreenTwo extends StatefulWidget {

  dynamic data;
  ScreenTwo({Key? key, required this.data}) : super(key: key);

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text(widget.data['Flutter']),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.screenThree);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                  ),
                  child: Center(child: const Text('Screen 2')),
                ),
              ),
            ],
          ),
        ),
    );
  }
}

