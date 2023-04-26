import 'package:advance_ui/list_view.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Advanced UI',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Gridview(),
    );
  }
}


/// Onscale Gestures
/// Initialize Vaiables
/*
double _initialScale = 1.0;
  double _scaleFactor = 1.0;
  // double _rotation = 1.0;
 */

//   home: Scaffold(
//   appBar: AppBar(
//     title: Text('Onscale Gestures'),
//   ),
//   body: GestureDetector(
//     onScaleStart: (details) {
//       _initialScale = _scaleFactor;
//     },
//     onScaleUpdate: (details) {
//       setState(() {
//         _scaleFactor = _initialScale * details.scale;
//         // _rotation = details.rotation.abs() * (180 /pi);
//         // print(_rotation);
//       });
//     },
//       child: Container(
//         color: Colors.amberAccent,
//         child: Center(
//           child: Text(
//             "Developer",
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//             ),
//             textScaleFactor: _scaleFactor,
//           ),
//         ),
//       ),
//   ),
//
// ),
/// Gesture Detection
/// Initialize Variable
/*
  String text = "Left";
  Color color = Colors.purpleAccent;String text = "Left";
 */
// Color color = Colors.purpleAccent;
//   home: Scaffold(
//   appBar: AppBar(
//     title: Text('Flutter Gesture Detector'),
//   ),
//   body: GestureDetector(
//     child: Center(
//       child: Container(
//         width: double.infinity,
//         height: 500,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: color
//         ),
//       child: Text(
//       text,
//       style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             color: Colors.white),
//   ),),
//     ),
//         onHorizontalDragUpdate: (details){
//           print(details);
//           if(details.delta.dx>0){
//             setState(() {
//               color =  Colors.pink;
//               text = "Right";
//             });
//           }
//           else{
//             setState(() {
//               color =  Colors.purpleAccent;
//               text = "left";
//             });
//           }
//         },
//       )
//   ),
