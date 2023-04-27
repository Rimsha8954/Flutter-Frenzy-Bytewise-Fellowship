/// Tween animation builder takes full ownership of the Provided tween instance and it will mutated it
/// Tween defines the target value for the animation and animates from Tween.begin to Tween.end

import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}
/// I combine all Position, Container, Opacity in to this builder
/// In this code I demonstrate a simple custom implicit animation using TweenAnimationBuilder
class _ImplicitAnimationState extends State<ImplicitAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tween Animation Builder'),
      ),
      body: Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.2, end: 1),
        duration: Duration(seconds: 3),
        builder: (context, double value, child){
          return SizedBox(
            width: double.infinity,
            height: 500,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  /// this animates the flutter logo from bottom to top by 300 in 3 seconds
                  /// it is similar to AnimatedPositioned but you may add some other animations in to this builders
                    bottom: value * 300,
                    child: Opacity(
                      opacity: value,
                    child: Container(
                      width: value * 200,
                      height: value * 200,
                    child: FlutterLogo(
                  size: 200,
                ),
                    ),
                ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}




/// Implicit application are easy to use and implement if your application does not require complicated UI
/// There are several built-in-implicit Animation such as AnimatedOpacity, AnimatedContainer, AnimatedAlign, AnimatedPositioned and so on

// class _ImplicitAnimationState extends State<ImplicitAnimation> {
//   bool setAnimate = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Implicit Animations'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 500,
//             child: Stack(
//               children: [
//                 AnimatedPositioned(
//                   top: setAnimate ? 50 : 300,
//                     child: FlutterLogo(
//                       size: 250,
//                     ),
//                     duration: Duration(seconds: 3),
//                 ),
//               ],
//             ),
//           ),
//           // AnimatedContainer(
//           //   width: setAnimate ? 50 : 300,
//           //   height: setAnimate ? 50 : 300,
//           //   // child: AnimatedOpacity(
//           //   //     opacity: setAnimate ? 1 : 0.3,
//           //     duration: Duration(seconds: 3),
//           //     child: FlutterLogo(
//           //       size: 200,
//           //     ),
//           //    ),
//           SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 setAnimate = !setAnimate;
//               });
//             },
//             child: Text('Tap'),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// Tween Animation
// class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<double> animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller =
//         AnimationController(duration: Duration(seconds: 3), vsync: this);
//     animation = Tween<double>(begin: 50, end: 200).animate(_controller)..addListener(() {
//       setState(() {
//       });
//     });
//     _controller.forward();
//   }
//     @override
//     void dispose(){
//       _controller.dispose();
//       super.dispose();
//     }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Animations'),
//       ),
//       body: Center(
//         child: Container(
//           alignment: Alignment.center,
//           child: Transform.rotate(angle: animation.value,
//           child: FlutterLogo(
//             size: animation.value,
//           ),
//           ),
//         ),
//       ),
//     );
//   }
// }
