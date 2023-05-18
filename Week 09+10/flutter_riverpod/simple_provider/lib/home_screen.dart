import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String ourData = ref.read<String>(stringProvider);
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          child: Text(ourData, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.greenAccent),),
        ),
      ),
    );
  }
}
