import 'dart:convert';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/bit_deposit.dart';
import 'package:test_project/Screens/bit_income.dart';
import 'package:test_project/Screens/change_password.dart';
import 'package:test_project/Screens/dashPage.dart';
import 'package:test_project/Screens/investment_history.dart';
import 'package:test_project/Screens/ipo_return_profit.dart';
import 'package:test_project/Screens/kyc_detail.dart';
import 'package:test_project/Screens/my_profile.dart';
import 'package:test_project/Screens/my_referrals.dart';
import 'package:test_project/Screens/navigation_page.dart';
import 'package:test_project/Screens/onBoardingNavBar.dart';
import 'package:test_project/Screens/order_history.dart';
import 'package:test_project/Screens/transactions.dart';
import 'package:test_project/Screens/tutorials.dart';
import 'package:test_project/Screens/withdraw.dart';
import 'package:test_project/Screens/withdrawl_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:test_project/Screens/t_and_c.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  bool isLoading = false;
  bool isTap = false;
  bool isIncTap = false;
  var dashData;
  var image;
  var username;
  var teamBitId;

  @override
  void initState() {
    getDashboard();
    getMyProfile();
    super.initState();
  }

  Future getDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    setState(() {
      isLoading = true;
    });
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth'
    };
    try {
      final response = await http.get(
        Uri.parse(
          baseURL + 'dashboard?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: header,
      );
      var model = json.decode(response.body);
      print('------- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          setState(() {
            dashData = model;
            MYBALANCE = dashData['user']['balance'];
            TOTALBIT = dashData['total_bit'];
            TOTALIPO = dashData['total_ipo'];
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
      // progressHUD.state.dismiss();
      showToast(Exepction.toString());
    }
  }

  Future getMyProfile() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');

    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth'
    };
    try {
      print(baseURL + 'myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14');
      final response = await http.get(
        Uri.parse(
          baseURL + 'myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: header,
      );
      var model = json.decode(response.body);
      print('------- ${model['image']}');
      print('------- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          setState(() {
            teamBitId = model['id'];
            USEREMAIL = model['email'];
            USEREMAIL2 = model['user_email'];
            USERMOBILE = model['mobile'];
            USERNAME1 = model['username'];
            USERNAME = model['firstname'] + ' ' + model['lastname'];
            image = model['image'];
          });
        }
      } else {}
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text('My Account'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                // Align(
                //   alignment: Alignment.center,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(5),
                //     child: Image.asset(
                //       'assets/images/shekhan logo.png',
                //       height: 155,
                //       width: 200,
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                if (dashData != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(
                                  color: CustomColors.black,
                                  width: 1.3,
                                )),
                            child: Image.network(
                              'https://admin.sherkhanril.com/assets/images/user/profile/$image',
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          USERNAME,
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'USER-ID: ' + USERNAME1,
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'My Balance: ₹' +
                              dashData['user']['balance'].toString(),
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total Invest: ₹' +
                              dashData['totalDeposit'].toString(),
                          style: TextStyle(
                            color: CustomColors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
                // Container(
                //   height: 85,
                //   width: 85,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: CustomColors.black,
                //     ),
                //   ),
                //   alignment: Alignment.center,
                //   child: Icon(
                //     Icons.account_circle_outlined,
                //     size: 85,
                //   ),
                // ),
                // SizedBox(height: 15),
                // Text(
                //   'Hello User',
                //   style: TextStyle(
                //     color: CustomColors.black,
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                isLoading
                    ? LinearProgressIndicator(color: CustomColors.orange)
                    : SizedBox.shrink(),
                Divider(height: 1, thickness: 1),
                SizedBox(height: 15),
                commonListTile(
                  'Dashboard',
                  Icon(
                    Icons.home,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashPage(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Profile',
                  Icon(
                    Icons.account_circle,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfile(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'KYC',
                  Icon(
                    Icons.verified_user,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KycDetail(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'Income',
                //   Icon(
                //     Icons.business_center,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => BITIncome(),
                //       ),
                //     );
                //   },
                // ),
                Divider(height: 1, thickness: 1),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 30, right: 30, bottom: 5),
                  title: Text(
                    'Income',
                    style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    isIncTap
                        ? Icons.arrow_drop_up_outlined
                        : Icons.arrow_drop_down,
                    size: 35,
                  ),
                  leading: Icon(
                    Icons.business_center,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  onTap: () {
                    setState(() {
                      isIncTap = !isIncTap;
                    });
                  },
                ),
                isIncTap
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 5, bottom: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BITIncome(
                                      title: 'Referral Direct Bit Income',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                height: 45,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Referral Direct Bit Income',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BITIncome(
                                      title: 'Indirect Income',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: Text(
                                  'Indirect Income',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BITIncome(
                                      title: 'BIT Profit',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: Text(
                                  'BIT Profit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BITIncome(
                                      title: 'Cashback',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: Text(
                                  'Cashback',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BITIncome(
                                      title: 'Extra Bonus',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: Text(
                                  'Extra Bonus',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'BIT/IPO Deposit',
                  Icon(
                    Icons.stay_current_portrait,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BitDeposit(
                          from: 'profile',
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'BIT Return Profit',
                //   Icon(
                //     Icons.category,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => IPOReturnProfit(),
                //       ),
                //     );
                //   },
                // ),
                // Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'My Transactions',
                //   Icon(
                //     Icons.account_balance_wallet_outlined,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => TransactionHistory(),
                //       ),
                //     );
                //   },
                // ),
                // Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'IPO',
                //   Icon(
                //     Icons.ad_units_outlined,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => MyReferrals(
                //           title: 'IPO',
                //         ),
                //       ),
                //     );
                //   },
                // ),
                // Divider(height: 1, thickness: 1),
                commonListTile(
                  'IPO',
                  Icon(
                    Icons.align_vertical_bottom_outlined,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReferrals(
                          title: 'IPO',
                          id: teamBitId.toString(),
                        ),
                      ),
                    );
                  },
                ),
                // Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'BIT',
                //   Icon(
                //     Icons.verified,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => MyReferrals(
                //           title: 'BIT',
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'BIT',
                  Icon(
                    Icons.air_rounded,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReferrals(
                          title: 'BIT',
                          id: teamBitId.toString(),
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                ListTile(
                  contentPadding:
                      EdgeInsets.only(left: 30, right: 30, bottom: 5),
                  title: Text(
                    'Withdrawal',
                    style: TextStyle(
                      color: CustomColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(
                    isTap
                        ? Icons.arrow_drop_up_outlined
                        : Icons.arrow_drop_down,
                    size: 35,
                  ),
                  leading: Icon(
                    Icons.verified_user,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  onTap: () {
                    setState(() {
                      isTap = !isTap;
                    });
                  },
                ),
                isTap
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 5, bottom: 15),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Withdraw(),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                height: 45,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Withdrawal Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderHistory(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 45,
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(
                                    left: 15, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100]),
                                child: Text(
                                  'Withdrawal History',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                // Divider(height: 1, thickness: 1),
                // commonListTile(
                //   'Withdraw History',
                //   Icon(
                //     Icons.shopping_cart_sharp,
                //     color: CustomColors.black,
                //     size: 25,
                //   ),
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => OrderHistory(),
                //       ),
                //     );
                //   },
                // ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Investment History',
                  Icon(
                    Icons.account_balance_sharp,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvestmentHistory(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Transaction History',
                  Icon(
                    Icons.credit_card_rounded,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyTransactions(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Change Password',
                  Icon(
                    Icons.password_rounded,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePassword(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'My Referrals',
                  Icon(
                    Icons.group,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyReferrals(
                          title: 'My Referrals',
                          id: '',
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Become a Member',
                  Icon(
                    Icons.person,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    setState(() {
                      ISREF = true;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnBoardingNavBar(currentTab: 1),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Invite Friend',
                  Icon(
                    Icons.share,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    share();
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Tutorials',
                  Icon(
                    Icons.title_outlined,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Tutorials(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),

                commonListTile(
                  'Customer Support',
                  Icon(
                    Icons.supervised_user_circle,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationPage(
                          currentTab: 3,
                        ),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Terms & Conditions',
                  Icon(
                    Icons.person,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TAndC(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Logout',
                  Icon(
                    Icons.logout,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () async {
                    setState(() {
                      ISREF = false;
                    });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLogin', false);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnBoardingNavBar(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),

                SizedBox(height: 25),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> tnc() async {
    if (!await launch(
      'https://admin.sherkhanril.com/terms-conditions',
      forceSafariVC: true,
      forceWebView: true,
      enableDomStorage: true,
    )) {
      throw 'Could not launch ';
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Sherkhan RIL',
      text: 'hello user',
      linkUrl: 'https://flutter.dev/',
      chooserTitle: 'Example Chooser Title',
    );
  }

  Widget commonListTile(String title, leading, ontap) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
      title: Text(
        title,
        style: TextStyle(
          color: CustomColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: leading,
      onTap: ontap,
    );
  }
}
