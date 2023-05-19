import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stream_provider/stream_provider.dart';



void main(List<String> args) {
  runApp(const ProviderScope(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()
  ),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildButton(context),
      ),);
  }


  Widget _buildButton(BuildContext context) {
    return ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => StreamProviderScreen()));
    }, child: Text('Stream Provider' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),));
  }
}
