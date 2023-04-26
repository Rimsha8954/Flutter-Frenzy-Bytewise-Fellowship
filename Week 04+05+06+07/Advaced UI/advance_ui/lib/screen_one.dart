import 'package:flutter/material.dart';


// Grid View can be used for navigation and routing such as categories selection
class ScreenOne extends StatefulWidget {
  const ScreenOne({Key? key, required this.title, required this.image}) : super(key: key);

  final title;
  final image;
  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            child: Image.asset(widget.image, fit: BoxFit.cover,),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Text("This is the description content of ${widget.title} "),
          )
        ],
      ),
    );
  }
}
