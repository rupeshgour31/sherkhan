import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  GlobalKey<FormState> _keyValid = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accNoController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool isLoading = false;
  bool isLoading2 = false;
  bool isAdd = false;
  List dataShow = [];
  var charge;
  var payable;
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
            'https://admin.sherkhanril.com/api/mybanks?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14'
            // baseURL + 'mybanks?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14%27',
            ),
        headers: header,
      );
      var model = json.decode(response.body);
      print('----sss--- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        setState(() {
          dataShow = model;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      }
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future addBank() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    setState(() {
      isLoading = true;
    });
    var headerGet = {'Authorization': 'Bearer $auth'};
    var params = {
      'acountname': _nameController.text,
      'account': _accNoController.text,
      'ifsc': _ifscController.text,
    };
    try {
      print(headerGet);
      print(params);
      final response = await http.post(
        Uri.parse(
          'https://admin.sherkhanril.com/api/add-banks?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        body: params,
        headers: headerGet,
      );
      var model = json.decode(response.body);
      print('----sss--- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          getDashboard();
        }
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      }
    } catch (d) {
      print('----ddd--- $d');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future withdrawl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    var amount = int.parse(_amountController.text) * 0.18;
    setState(() {
      isLoading = true;
    });
    var header = {'Authorization': 'Bearer $auth'};
    var params = {
      'method_code': '1',
      'amount': _amountController.text,
      'bank_id': typeIs.toString(),
    };
    try {
      final response = await http.post(
        Uri.parse(
          'https://admin.sherkhanril.com/api/withdraw?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: header,
        body: params,
      );
      var model = json.decode(response.body);
      print('----sss--- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(model["msg"].toString());
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('exception $e');
    }
  }

  var typeIs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        automaticallyImplyLeading: true,
        title: Text(
          'Withdraw',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 10, 25, 15),
          child: Stack(
            children: [
              Form(
                key: _keyValid,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: CustomColors.orange, width: 1.5),
                        color: CustomColors.orange.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Text(
                        '*EVERY WITHDRAWALS ON MONDAY 10AM to 3PM. \n\n*ALL WITHDRAWALS PAY SERVICE TAX WILL BE – 18% GST. \n\n*MINIMUM WITHDRAWAL = Rs.4000/',
                        style: TextStyle(
                          color: CustomColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
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
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Your Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    for (int i = 0; i < dataShow.length; i++) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: CustomColors.orange),
                        ),
                        padding: EdgeInsets.only(left: 15, right: 15),
                        margin: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              typeIs = dataShow[i]['id'];
                            });
                          },
                          contentPadding: EdgeInsets.only(bottom: 3),
                          title:
                              Text('Name: ${dataShow[i]['acountname'] ?? ''}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Account Number: ${dataShow[i]['account'] ?? ''}'),
                              Text('IFSC Code: ${dataShow[i]['ifsc'] ?? ''}'),
                            ],
                          ),
                          trailing: typeIs == dataShow[i]['id']
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.circle),
                          // subtitle: Text(withdrawSelect[i]['des']),
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isAdd = !isAdd;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add New Account',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          isAdd
                              ? Icon(
                                  Icons.arrow_circle_up,
                                  size: 30,
                                )
                              : Icon(
                                  Icons.arrow_circle_down,
                                  size: 30,
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    isAdd ? selectType() : SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     offset: Offset(0.0, 0.2),
                        //     // spreadRadius: 0.1,
                        //     blurRadius: 0.2,
                        //   ),
                        // ],
                      ),
                      child: AllInputDesign(
                        controller: _amountController,
                        labelText: 'Enter Amount',
                        keyBoardType: TextInputType.number,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: CustomColors.white,
                        onChanged: (val) {
                          setState(() {
                            charge = int.parse(val) * 0.18;
                            payable = int.parse(val) - charge;
                          });
                          print('ruururururu$charge $payable');
                        },
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        inputborder: InputBorder.none,
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 15, 1, 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Charges '),
                            Text('${charge ?? ''}'),
                          ],
                        )),
                    SizedBox(height: 15),
                    Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 15, 1, 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Payable amount '),
                            Text('${payable ?? ''}'),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (typeIs != null) {
                          if (_amountController.text == null ||
                              _amountController.text.isEmpty) {
                            showToast('Please enter amount');
                          } else {
                            withdrawl();
                          }
                        } else {
                          showToast('Please select account');
                        }
                      },
                      child: Container(
                        height: 47,
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          color: CustomColors.orange,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        alignment: Alignment.center,
                        child: isLoading2
                            ? CircularProgressIndicator()
                            : Text(
                                'Withdraw',
                                style: TextStyle(
                                  color: CustomColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 15),
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
        ),
      ),
    );
  }

  selectType() {
    // if (typeIs == 'Enter bank a/c details') {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(0.0, 0.2),
            //     // spreadRadius: 0.1,
            //     blurRadius: 0.2,
            //   ),
            // ],
          ),
          child: AllInputDesign(
            controller: _nameController,
            labelText: 'Name',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            fillColor: CustomColors.white,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            inputborder: InputBorder.none,
            contentPadding: EdgeInsets.all(5.0),
            validator: validateName,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(0.0, 0.2),
            //     // spreadRadius: 0.1,
            //     blurRadius: 0.2,
            //   ),
            // ],
          ),
          child: AllInputDesign(
            controller: _accNoController,
            labelText: 'Account Number',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            fillColor: CustomColors.white,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            inputborder: InputBorder.none,
            contentPadding: EdgeInsets.all(5.0),
            validator: (value) {
              if (value.isEmpty || value == null) {
                return 'Please enter account number';
              } else
                return null;
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey,
            //     offset: Offset(0.0, 0.2),
            //     // spreadRadius: 0.1,
            //     blurRadius: 0.2,
            //   ),
            // ],
          ),
          child: AllInputDesign(
            controller: _ifscController,
            labelText: 'IFSC Code',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            fillColor: CustomColors.white,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            inputborder: InputBorder.none,
            contentPadding: EdgeInsets.all(5.0),
            validator: (value) {
              if (value.isEmpty || value == null) {
                return 'Please enter IFSC code';
              } else
                return null;
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (_keyValid.currentState!.validate()) {
                addBank();
              }
            },
            child: Text(
              'Add Bank',
              style: TextStyle(
                fontSize: 18,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
    // } else {
    //   return Container(
    //     padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
    //     decoration: BoxDecoration(
    //       color: Colors.grey[50],
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey,
    //           offset: Offset(0.0, 0.2),
    //           // spreadRadius: 0.1,
    //           blurRadius: 0.2,
    //         ),
    //       ],
    //     ),
    //     child: AllInputDesign(
    //       // controller: _passwordController,
    //       labelText: 'Mobile number',
    //       focusedBorder: InputBorder.none,
    //       enabledBorder: InputBorder.none,
    //       fillColor: CustomColors.white,
    //       disabledBorder: InputBorder.none,
    //       errorBorder: InputBorder.none,
    //       inputborder: InputBorder.none,
    //       contentPadding: EdgeInsets.all(5.0),
    //       validator: (value) {
    //         if (value.isEmpty || value == null) return 'Please password';
    //         if (value.length < 6)
    //           return "Please enter a password with at least 6 characters";
    //         else
    //           return null;
    //       },
    //     ),
    //   );
    // }
  }
}
