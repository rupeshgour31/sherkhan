import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/dashboard.dart';
import 'package:test_project/Screens/my_account_screen.dart';

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
          widget.currentPage = Dashboard();
          break;
        case 1:
          widget.currentPage = Dashboard();
          break;
        case 2:
          widget.currentPage = Dashboard();
          break;
        case 3:
          widget.currentPage = MyAccountScreen();
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(45.0),
            topLeft: Radius.circular(45.0),
          ),
          border: Border.all(
            color: CustomColors.orange,
            width: 2.0,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(45),
            topLeft: Radius.circular(45),
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
                  Icons.home,
                  color: widget.currentTab == 0
                      ? CustomColors.orange
                      : Colors.grey,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: widget.currentTab == 0
                        ? CustomColors.orange
                        : Colors.white,
                  ),
                ),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(
                  Icons.credit_card,
                  color: widget.currentTab == 1
                      ? CustomColors.orange
                      : Colors.grey,
                ),
                title: Text(
                  'Transactions',
                  style: TextStyle(
                    color: widget.currentTab == 1
                        ? CustomColors.orange
                        : Colors.white,
                  ),
                ),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(
                  Icons.work,
                  color: widget.currentTab == 2
                      ? CustomColors.orange
                      : Colors.grey,
                ),
                title: Text(
                  'Shop',
                  style: TextStyle(
                    color: widget.currentTab == 2
                        ? CustomColors.orange
                        : Colors.white,
                  ),
                ),
                activeColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: Icon(
                  Icons.menu,
                  color: widget.currentTab == 3
                      ? CustomColors.orange
                      : Colors.grey,
                ),
                title: Text(
                  'My Account',
                  style: TextStyle(
                    color: widget.currentTab == 3
                        ? CustomColors.orange
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
    );
  }
}
