import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/kyc_detail.dart';
import 'package:test_project/Screens/navigation_page.dart';
import 'package:test_project/Screens/onBoardingNavBar.dart';

class InitSplash extends StatefulWidget {
  const InitSplash({Key? key}) : super(key: key);

  @override
  _InitSplashState createState() => _InitSplashState();
}

class _InitSplashState extends State<InitSplash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var auth = prefs.getBool('isLogin') ?? false;
      var isKYC = prefs.getBool('isKYC') ?? false;
      print(auth);
      print(isKYC);
      if (auth && isKYC) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationPage(
                currentTab: 2,
              ),
            ),
            (route) => false);
      } else if (auth && !isKYC) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => KycDetail(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoardingNavBar(),
            ),
            (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: CustomColors.white,
        ),
        child: Image.asset('assets/images/ss2.jpg'),
      ),
    );
  }
}
