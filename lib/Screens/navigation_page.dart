import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/about_us.dart';
import 'package:test_project/Screens/chat_screen.dart';
import 'package:test_project/Screens/dashboard.dart';
import 'package:test_project/Screens/my_account_screen.dart';
import 'package:test_project/Screens/news_screen.dart';
import 'dart:async';

class NavigationPage extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = Dashboard();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  NavigationPage({this.currentTab}) {
    if (currentTab != null) {
      currentTab = currentTab;
    } else {
      currentTab = 0;
    }
  }

  @override
  _NavigationPageState createState() {
    return _NavigationPageState(currentTab);
  }
}

class _NavigationPageState extends State<NavigationPage> {
  final currentTab;
  _NavigationPageState(this.currentTab);
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(NavigationPage oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = AboutUs();
          break;
        case 1:
          widget.currentPage = NewsScreen();
          break;
        case 2:
          widget.currentPage = Dashboard();
          break;
        case 3:
          widget.currentPage = ChatScreen();
          break;
        case 4:
          widget.currentPage = MyAccountScreen();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _onBackPressed(),
      child: Scaffold(
        key: widget.scaffoldKey,
        body: Stack(
          children: <Widget>[
            widget.currentPage,
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(45.0),
              topLeft: Radius.circular(45.0),
            ),
            border: Border.all(
              color: CustomColors.darkOrange,
              width: 2.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            child: BottomNavyBar(
              selectedIndex: widget.currentTab,
              showElevation: true,
              itemCornerRadius: 24,
              curve: Curves.easeIn,
              onItemSelected: (index) => setState(() => this._selectTab(index)),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                  icon: Icon(
                    Icons.admin_panel_settings_outlined,
                    color: widget.currentTab == 0
                        ? CustomColors.darkOrange
                        : Colors.grey,
                  ),
                  title: Text(
                    'About',
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
                    Icons.add_location_sharp,
                    color: widget.currentTab == 1
                        ? CustomColors.darkOrange
                        : Colors.grey,
                  ),
                  title: Text(
                    'News',
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
                    Icons.message,
                    color: widget.currentTab == 3
                        ? CustomColors.darkOrange
                        : Colors.grey,
                  ),
                  title: Text(
                    'Chat',
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
                    Icons.menu,
                    color: widget.currentTab == 4
                        ? CustomColors.darkOrange
                        : Colors.grey,
                  ),
                  title: Text(
                    'My Account',
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
          ),
        ),
      ),
    );
  }

  _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            'Do you want to exit the app?',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Montserrat",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}
