import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:http/http.dart' as http;

class DashPage extends StatefulWidget {
  @override
  _DashPageState createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  bool isLoading = false;
  var dashData;
  var getMin;
  late DateTime getTime;
  var gggg1;
  var gggg2;
  var gggg3;
  var gggg4;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Duration _duration = Duration(seconds: 1000000);
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);

    return (to.difference(from).inHours / 24).round();
  }

  @override
  void initState() {
    getDashboard();

    super.initState();
  }

  gettimestamp() async {
    final date2 = DateTime.now();
    final difference = await daysBetween(date2, getTime);
    setState(() {
      gggg1 = difference;
    });
    setState(() {
      // gggg1 = to.difference(from).inHours / 24;
      // gggg2 = to.difference(from).inHours;
      // gggg3 = to.difference(from).inMinutes;
      // gggg4 = to.difference(from).inSeconds;
    });
    print('============ ============$getTime  $date2 $difference');
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

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          var q1 = DateTime.parse(model['timer_end_time']).day;
          setState(() {
            dashData = model;
            gggg1 = q1.toString();
            // gggg2 = DateTime.parse(model['timer_end_time']).hour.toString();
            // gggg3 = DateTime.parse(model['timer_end_time']).minute.toString();
            // gggg4 = DateTime.parse(model['timer_end_time']).second.toString();
            getMin = model['remaining_minute'];
            getTime = DateTime.parse(model['timer_end_time']);
            MYBALANCE = dashData['user']['balance'];
          });
          await gettimestamp();
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

  @override
  Widget build(BuildContext context) {
    print('---------- trererewr $gggg1 $gggg2 $gggg3 $gggg4');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text('DashBoard'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    gggg1 == 0
                        ? SizedBox.shrink()
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: CustomColors.orange, width: 1.5),
                              color: CustomColors.orange.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(25, 8, 25, 8),
                            child: Column(
                              children: [
                                Text(
                                  'Time Left to Complete IPO',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                SlideCountdownClock(
                                  duration: Duration(
                                    days: gggg1,
                                    // hours: int.parse(gggg2),
                                    // minutes: int.parse(gggg3),
                                    // seconds: int.parse(gggg4),
                                  ),
                                  slideDirection: SlideDirection.Up,
                                  separator: ":",
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shouldShowDays: true,
                                  onDone: () {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        SnackBar(
                                            content: Text('Clock 1 finished')));
                                  },
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        datashow(
                          'Wallet Balance',
                          '₹ ${dashData['user']['balance']}',
                          Colors.brown,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        datashow(
                          'My Investment',
                          '₹ ${dashData['totalDeposit']}',
                          Colors.lime,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        datashow(
                          'Referral Team',
                          dashData['total_ref'] ?? '0',
                          Colors.black87,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'My BIT',
                          dashData['total_bit'] ?? '0',
                          Colors.pink,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        datashow(
                          'Team BIT',
                          dashData['user_extra']['total_team'] ?? '0',
                          Colors.redAccent,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'IPO',
                          dashData['total_ipo'] ?? '0',
                          Colors.greenAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        datashow(
                          'Direct BIT Income',
                          '₹ ${dashData['direct_bit_income']}',
                          Colors.deepPurple,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'BIT Profit',
                          '₹ ${dashData['bit_profit']}',
                          Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        datashow(
                          'Indirect Income',
                          '₹ ${dashData['indirect_income']}',
                          Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'Cashback',
                          '₹ ${dashData['cashback']}',
                          Colors.black54,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        datashow(
                          'Extra Bonus',
                          '₹ ${dashData['extra_bonus']}',
                          Colors.greenAccent,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'Total Withdraw',
                          '₹ ${dashData['totalWithdraw']}',
                          Colors.teal,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        datashow(
                          'Complete Withdraw',
                          '₹ ${dashData['completeWithdraw']}',
                          Colors.green,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        datashow(
                          'Pending Withdraw',
                          '₹ ${dashData['pendingWithdraw']}',
                          Colors.deepPurple,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // datashow(
                        //   'Reject Withdraw',
                        //   '₹ ${dashData['rejectWithdraw']}',
                        //   Colors.orange,
                        // ),
                        // SizedBox(
                        //   width: 8,
                        // ),
                        // datashow(
                        //   'Pending Withdraw',
                        //   '₹ ${dashData['pendingWithdraw']}',
                        //   Colors.deepPurple,
                        // ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }

  Widget datashow(heading, text, colorsget) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.41,
      decoration: BoxDecoration(
        color: colorsget,
        // gradient: LinearGradient(
        //   colors: <Color>[
        //     Colors.grey.shade200,
        //     Colors.grey.shade300,
        //   ],
        // ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            heading.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
