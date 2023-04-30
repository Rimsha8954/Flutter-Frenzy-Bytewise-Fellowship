import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'components/animated_btn.dart';
import 'components/sign_in_page.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({Key? key}) : super(key: key);

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  @override
  void initState() {
    super.initState();
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              bottom: 300,
              left: 120,
              child: Image.asset("assets/Backgrounds/Spline.png")),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/onboding_animation.riv"),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          //Add Text
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                SizedBox(
                  child: Column(
                    children: const [
                      Text("Learn Design & Code",
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: "Poppins",
                              height: 1.1,
                              color: Colors.white)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "The best way to predict the future is to invent it.- Alan Kay \nCode is not just code, it's a language that can be used to create visual art, animation, and even music. - Linda Liukas",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                // Add an animated button
                AnimatedBtn(
                    btnAnimationController: _btnAnimationController,
                    press: () {
                      _btnAnimationController.isActive = true;
                      showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: "Sign In",
                          context: context,
                          pageBuilder: (context, _, __) => Center(
                                child: Container(
                                  height: 550,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 25),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.pink.shade50,
                                  ),
                                  child: Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    backgroundColor: Colors.transparent,
                                    body: Column(
                                      children:[
                                        Text(
                                          "Sign In",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 34,
                                          ),
                                        ),
                                        Text(
                                          "Get a chance to build android and flutter Apps with in three months",
                                          textAlign: TextAlign.center,
                                        ),
                                        SignInForm(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: Divider()),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Text("OR", style: TextStyle(color: Colors.black12),),
                                            ),
                                            Expanded(child: Divider()),
                                          ],
                                        ),
                                        Text("Sign Up with Email , Facebook or Google", style: TextStyle(color: Colors.black54),),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/icons/email.svg"),),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.facebook),),
                                            IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/icons/google_box.svg"),),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                    }),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "15-Days course with premium tutorials and source code. Purchase it now and get a free certificate ",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}

