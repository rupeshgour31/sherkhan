import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';

class BITIncome extends StatefulWidget {
  final String title;
  BITIncome({required this.title});
  @override
  _BITIncomeState createState() => _BITIncomeState();
}

class _BITIncomeState extends State<BITIncome> {
  List _list = [];

  bool isLoading = false;
  List dataShow = [];
  @override
  void initState() {
    _selectFun();

    super.initState();
  }

  void _selectFun() {
    setState(() {
      String title = widget.title;
      switch (title) {
        case 'Referral Direct Bit Income':
          getData1();
          break;
        case 'Indirect Income':
          getData3();
          break;
        case 'BIT Profit':
          getData2();
          break;
        case 'Cashback':
          getData4();
          break;
        case 'Extra Bonus':
          getData5();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text(
          widget.title,
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: _list.length == 0
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: Center(
                      child: Text(isLoading ? '' : 'No Data Found'),
                    ),
                  )
                : ListView.builder(
                    itemCount: _list.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final DateTime now =
                          DateTime.parse(_list[index]['created_at']);
                      final DateFormat formatter = DateFormat('dd MMM yyyy');
                      final String formatted = formatter.format(now);
                      return Padding(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              // setBackToOrderQues(_list, index, "OrderPaymentDetail");
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Row(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     Expanded(
                                  //       flex: 10,
                                  //       child: Text(
                                  //         '#' + _list[index]['trx'].toString(),
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold,
                                  //             fontSize: 17.0),
                                  //       ),
                                  //     ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹' + _list[index]['amount'].toString(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                      Text(
                                        "Date: $formatted",
                                        style: TextStyle(
                                          color: CustomColors.appBarColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // status(_list[index]['status']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ), //
                                  _list[index]['details'] == null
                                      ? SizedBox.shrink()
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Remark: ",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                _list[index]['details'],
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: CustomColors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: CustomColors.black),
                            borderRadius: BorderRadius.all(Radius.circular(
                              5.0,
                            )),
                          ),
                        ),
                      );
                    }),
          ),
          isLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Future getData1() async {
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
          baseURL +
              'report/referral/commission?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
            _list = model['transactions']['data'];
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

  Future getData2() async {
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
          baseURL +
              'report/roi/commission?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
            _list = model['transactions']['data'];
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

  Future getData3() async {
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
          baseURL +
              'report/referral/indirect?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
            _list = model['transactions']['data'];
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

  Future getData4() async {
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
          baseURL +
              'report/referral/cashbonus?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
            _list = model['transactions']['data'];
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

  Future getData5() async {
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
          baseURL +
              'report/referral/weekly-commission?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
            _list = model['transactions']['data'];
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
}
