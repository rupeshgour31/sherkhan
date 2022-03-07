import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/init_splash.dart';
import 'package:test_project/Screens/navigation_page.dart';
import 'package:test_project/Screens/onBoardingNavBar.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/images/SS3.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    setState(() {
      _controller.play();
    });
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
    Timer(Duration(seconds: 5), () async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => InitSplash(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.orange,
      body: Center(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        // padding: EdgeInsets.all(25),
        // decoration: BoxDecoration(
        //   color: CustomColors.white,
        // ),
        child: VideoPlayer(_controller),
        // child: Image.asset('assets/images/SHERKHAN1.jpg'),
      ),
    );
  }
}
