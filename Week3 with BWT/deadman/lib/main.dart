import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Flutter Frenzy',
            style: TextStyle(fontSize: 26, fontFamily: 'Pacifo'),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Rimsha Ashraf Project'),
                  Icon(Icons.account_circle),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.cyan[900],
                child: const Center(
                  child: Text('Box1'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.cyan[900],
                child: const Center(
                  child: Text('Box2'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.cyan[900],
                child: const Center(
                  child: Text('Box3'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.cyan[900],
                child: const Center(
                  child: Text('Box4'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
