import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/Login/login.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  late final Animation<double> _animation;
  late AnimationController delayedcontroller;
  late final Animation<double> _delayedAnimation;

  init()
  {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    _delayedAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.8, 1, curve: Curves.fastOutSlowIn),
    );

    offset = Tween<Offset>(
        begin: const Offset(0.0, -5), end: const Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
  }

  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(
        const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            _marvelAnimatedLogo(context),
            // _animatedText(context),
            // _footer()
          ],
        ));
  }

  // Column _footer() {
  //   return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
  //     SizedBox(
  //       width: double.infinity,
  //       child: Padding(
  //         padding: const EdgeInsets.only(bottom: 10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //            const Text(
  //               AppConstants.poweredBy,
  //               style: TextStyle(
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.w400,
  //                   color: Colors.black),
  //             ),
  //             Image.asset(
  //               AppConstants.successiveLogo,
  //               width: 35,
  //               height: 35,
  //               fit: BoxFit.scaleDown,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: const [
  //                 Text(
  //                   AppConstants.successive,
  //                   style: TextStyle(
  //                       fontSize: 22,
  //                       fontWeight: FontWeight.w600,
  //                       letterSpacing: 3),
  //                 ),
  //                 Text(
  //                   AppConstants.technologies,
  //                   style: TextStyle(
  //                       fontSize: 21,
  //                       fontWeight: FontWeight.w400,
  //                       letterSpacing: 1.2),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   ]);
  // }

  Center _animatedText(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _delayedAnimation,
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return  RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Colors.brown,
                    Colors.black,
                    Colors.brown,
                    Colors.black,
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  "welcome",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _marvelAnimatedLogo(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: controller,
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Image.asset("assets/picture/brain.png"),
          ),
        ),
      ),
    );
  }
}
