import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/Screens/update_password.dart';

class OtpVerify extends StatefulWidget {
  final String username;
  OtpVerify({required this.username});
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: CustomColors.appBarColor,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/images/shekhan logo.png',
                        height: 120,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'OTP Verify',
                      style: TextStyle(
                        color: CustomColors.darkOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      child: AllInputDesign(
                        controller: _emailController,
                        labelText: 'Enter Otp',
                        keyBoardType: TextInputType.emailAddress,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        fillColor: CustomColors.white,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        inputborder: InputBorder.none,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: (text) {
                          if (text.isEmpty || text == null)
                            return 'Please Enter OTP';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 40,
                            margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xffEA1600).withOpacity(0.7),
                                  Color(0xffEA1600),
                                ],
                              ),
                            ),
                            child: FlatButton(
                              child: isLogin
                                  ? SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: CircularProgressIndicator(
                                        color: CustomColors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: CustomColors.white,
                                      ),
                                    ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (_emailController.text.trim().toString() ==
                                      '123456') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UpdatePassword(
                                            username: widget.username),
                                      ),
                                    );
                                  } else {
                                    showToast('Wronge OTP');
                                  }
                                }
                              },
                              textColor: CustomColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future updateMyProfile() async {
    setState(() {
      isLogin = true;
    });
    var header = {
      'Content-Type': 'application/json',
    };
    try {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://admin.sherkhanril.com/api/password/reset'));
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'type': 'username',
        'value': _emailController.text.toString(),
      });
      request.headers.addAll(header);

      var response = await request.send();

      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
        var fnh = jsonDecode(model);
        setState(() {
          isLogin = false;
        });
        if (fnh['status'] == 'success') {
          showToast(fnh["msg"].toString());
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => OtpVerify(),
          //     ),
          //     (route) => false);
        } else {
          showToast(fnh["msg"].toString());
        }
      } else {
        setState(() {
          isLogin = false;
        });
        print(response.reasonPhrase);
      }
    } catch (Exepction) {
      setState(() {
        isLogin = false;
      });
      // progressHUD.state.dismiss();
      showToast(Exepction.toString());
    }
  }
}
