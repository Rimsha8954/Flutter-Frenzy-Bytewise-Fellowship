import 'package:flutter/material.dart';

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with TickerProviderStateMixin {
  // Intialize animationController and animation
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  late Animation<Offset> _animation =
      Tween<Offset>(begin: Offset(0, 0), end: Offset(1.5, 0))
          .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));

  // @override
  // void initState(){
  //   _controller.forward();
  //   super.initState();
  // }

  //dispose controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Explicit Animations'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          /// FadeTransition is similar to animatedOpacity the only diifference is fade in handaled by animatedController
          position: _animation,
          child: FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
  }
}

/// Difference between Implicit and Explicit animation is that
/// Explicit animation requires animationController and a set of controls for telling flutter
/// how to rapidly rebuilt the widget tree while changing widget properties to create animation effects.
/// and this allows developers to create animation effects that cant be achived by Implicit animations
