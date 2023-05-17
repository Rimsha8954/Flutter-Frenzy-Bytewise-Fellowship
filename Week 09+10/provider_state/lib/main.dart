import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state/list_provider.dart';

import 'home_screen.dart';

void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> NumbersListProvider())
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
