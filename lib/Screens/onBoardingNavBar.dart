import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/about_us.dart';
import 'package:test_project/Screens/contact_us.dart';
import 'package:test_project/Screens/dashboard.dart';
import 'package:test_project/Screens/login_screen.dart';
import 'package:test_project/Screens/registration_screen.dart';
import 'package:test_project/Screens/t_and_c.dart';

class OnBoardingNavBar extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = Dashboard();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  OnBoardingNavBar({this.currentTab}) {
    if (currentTab != null) {
      currentTab = currentTab;
    } else {
      currentTab = 0;
    }
  }

  @override
  _OnBoardingNavBarState createState() {
    return _OnBoardingNavBarState(currentTab);
  }
}

class _OnBoardingNavBarState extends State<OnBoardingNavBar> {
  final currentTab;
  _OnBoardingNavBarState(this.currentTab);
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(OnBoardingNavBar oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = LoginScreen();
          break;
        case 1:
          widget.currentPage = RegistrationScreen();
          break;
        case 2:
          widget.currentPage = Dashboard();
          break;
        case 3:
          widget.currentPage = TAndC();
          break;
        case 4:
          widget.currentPage = AboutUs();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: Stack(
        children: <Widget>[
          widget.currentPage,
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: widget.currentTab,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => this._selectTab(index)),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(
              Icons.login,
              color: widget.currentTab == 0
                  ? CustomColors.darkOrange
                  : Colors.grey,
            ),
            title: Text(
              'Sign In',
              style: TextStyle(
                color: widget.currentTab == 0
                    ? CustomColors.darkOrange
                    : Colors.white,
              ),
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.assignment_ind,
              color: widget.currentTab == 1
                  ? CustomColors.darkOrange
                  : Colors.grey,
            ),
            title: Text(
              'Sign Up',
              style: TextStyle(
                color: widget.currentTab == 1
                    ? CustomColors.darkOrange
                    : Colors.white,
              ),
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.align_vertical_bottom,
              color: widget.currentTab == 2
                  ? CustomColors.darkOrange
                  : Colors.grey,
            ),
            title: Text(
              'Trade',
              style: TextStyle(
                color: widget.currentTab == 2
                    ? CustomColors.darkOrange
                    : Colors.white,
              ),
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.document_scanner,
              color: widget.currentTab == 3
                  ? CustomColors.darkOrange
                  : Colors.grey,
            ),
            title: Text(
              'Terms', //'Contact Us', //'Privacy Policy',
              style: TextStyle(
                color: widget.currentTab == 3
                    ? CustomColors.darkOrange
                    : Colors.white,
              ),
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.admin_panel_settings_outlined,
              color: widget.currentTab == 4
                  ? CustomColors.darkOrange
                  : Colors.grey,
            ),
            title: Text(
              'About Us',
              style: TextStyle(
                color: widget.currentTab == 4
                    ? CustomColors.darkOrange
                    : Colors.white,
              ),
            ),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
