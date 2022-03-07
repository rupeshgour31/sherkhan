import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';

class IPOReturnProfit extends StatefulWidget {
  const IPOReturnProfit({Key? key}) : super(key: key);

  @override
  _IPOReturnProfitState createState() => _IPOReturnProfitState();
}

class _IPOReturnProfitState extends State<IPOReturnProfit> {
  List _list = [];

  bool isLoading = false;
  List dataShow = [];
  @override
  void initState() {
    getDashboard();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text(
          'BIT Return Profit',
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
                      final DateFormat formatter =
                          DateFormat('dd MMM yyyy hh:mm:ss');
                      final String formatted = formatter.format(now);
                      return Container(
                        margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '#' + _list[index]['trx'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  '₹' + _list[index]['amount'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              formatted.toString(),
                              style: TextStyle(
                                color: CustomColors.appBarColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColors.black),
                          borderRadius: BorderRadius.all(Radius.circular(
                            5.0,
                          )),
                        ),
                      );
                    },
                  ),
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
}
