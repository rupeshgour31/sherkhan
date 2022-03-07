import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';

class MyTransactions extends StatefulWidget {
  const MyTransactions({Key? key}) : super(key: key);

  @override
  _MyTransactionsState createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {
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
          'https://admin.sherkhanril.com/api/report/transactions/log?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
          'Transaction History',
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Available Balance: ",
                              style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹' + MYBALANCE.toString(),
                              style: TextStyle(
                                color: CustomColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ListView.builder(
                          itemCount: _list.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final DateTime now =
                                DateTime.parse(_list[index]['created_at']);
                            final DateFormat formatter =
                                DateFormat('dd MMM yyyy');
                            final String formatted = formatter.format(now);
                            return Padding(
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    // setBackToOrderQues(_list, index, "OrderPaymentDetail");
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        10.0, 10.0, 10.0, 0.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.credit_card_rounded,
                                              size: 45,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Text(
                                              '#' +
                                                  _list[index]['trx']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: CustomColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹' +
                                                  _list[index]['amount']
                                                      .toString(),
                                              style: TextStyle(
                                                  color: CustomColors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                            Text(
                                              "Date: $formatted",
                                              style: TextStyle(
                                                color: CustomColors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // status(
                                        //     _list[index]['trx_type'].toString()),

                                        SizedBox(
                                          height: 10.0,
                                        ),

                                        Text(
                                          "Remark: " +
                                              _list[index]['details']
                                                  .toString(),
                                          style: TextStyle(
                                            color: CustomColors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: CustomColors.white,
                                  border: Border.all(
                                    color: _list[index]['trx_type'] == '+'
                                        ? Colors.green
                                        : Colors.red,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          10.0) //                 <--- border radius here
                                      ),
                                ),
                              ),
                            );
                          }),
                      SizedBox(height: 20.0),
                    ],
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

  textbold(text) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    );
  }

  status(text) {
    print('gggg $text');
    return Row(
      children: [
        Text('Status:'),
        Container(
          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: text == 1
          //         ? Colors.green
          //         : text == 2
          //             ? Colors.yellow
          //             : Colors.red),
          child: Text(
            text == '+' ? 'Success' : 'Cancel',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: text == '+' ? Colors.green : Colors.red,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
