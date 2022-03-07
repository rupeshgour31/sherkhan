import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';
import 'package:test_project/Screens/kyc_detail.dart';
import 'package:test_project/Screens/navigation_page.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lsstNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referalController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoading = false;
  bool isChecked = false;
  bool _isCheck = false;
  @override
  void initState() {
    if (ISREF) {
      setState(() {
        _referalController.text = USERNAME1;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.white,
        brightness: Brightness.light,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                        'Registration',
                        style: TextStyle(
                          color: CustomColors.darkOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 40),
                      AllInputDesign(
                        controller: _firstNameController,
                        labelText: 'First Name',
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: validateName,
                      ),
                      SizedBox(height: 18),
                      AllInputDesign(
                        controller: _lsstNameController,
                        labelText: 'Last Name',
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: validateLastName,
                      ),
                      SizedBox(height: 18),
                      AllInputDesign(
                        controller: _mobileController,
                        labelText: 'Mobile Number',
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: validateMobile,
                      ),
                      SizedBox(height: 18),
                      AllInputDesign(
                        controller: _referalController,
                        labelText: 'Reference',
                        fillColor: CustomColors.white,
                        autoValidate: true,
                        onChanged: (String val) {
                          checkReferal();
                        },
                        suffixIcon: isChecked
                            ? Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              )
                            : SizedBox.shrink(),
                        contentPadding: EdgeInsets.all(5.0),
                        validator: (val) {
                          if (isChecked) {
                            return null;
                          } else {
                            return 'Invalid referal';
                          }
                        },
                      ),
                      SizedBox(height: 18),
                      AllInputDesign(
                        controller: _emailController,
                        labelText: 'Email',
                        keyBoardType: TextInputType.emailAddress,
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 18),
                      AllInputDesign(
                        controller: _userIdController,
                        labelText: 'Create User Name',
                        keyBoardType: TextInputType.emailAddress,
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: validateEmail,
                      ),
                      SizedBox(height: 15),
                      AllInputDesign(
                        controller: _passwordController,
                        labelText: 'Password',
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        obsecureText: passwordVisible,
                        validator: validatePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 18),
                      Row(
                        children: [
                          Checkbox(
                              value: _isCheck,
                              onChanged: (val) {
                                setState(() {
                                  _isCheck = val!;
                                });
                              }),
                          RichText(
                            text: new TextSpan(
                                text: 'Please accept ',
                                style: TextStyle(color: Colors.black),
                                children: [
                                  new TextSpan(
                                    text: 'Terms & Conditions',
                                    style: TextStyle(color: Colors.blue),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => tnc(),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
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
                                child: isLoading
                                    ? SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: CustomColors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (isChecked) {
                                      if (_isCheck) {
                                        signUp();
                                      }
                                    } else {
                                      showToast(
                                          'Please add valid referral code');
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
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.pop(context);
                            //     },
                            //     child: RichText(
                            //       text: TextSpan(
                            //         text: '',
                            //         style: TextStyle(
                            //           fontSize: 16,
                            //           color: CustomColors.black,
                            //         ),
                            //         children: <TextSpan>[
                            //           TextSpan(
                            //             text: 'Already have an account? ',
                            //             style: TextStyle(
                            //               fontSize: 15,
                            //               decoration: TextDecoration.underline,
                            //               color: Colors.grey[900],
                            //             ),
                            //           ),
                            //           TextSpan(
                            //             text: 'Sign In',
                            //             style: TextStyle(
                            //               fontWeight: FontWeight.bold,
                            //               fontSize: 15,
                            //               decoration: TextDecoration.underline,
                            //               color: Colors.deepOrange,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 55),
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
      ),
    );
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

  Future signUp() async {
    setState(() {
      isLoading = true;
    });
    var bodyReq = {
      'secret': 'bd5c49f2-a-44d4-8daa-6ff67ab1bc14',
      'referral': _referalController.text,
      'email': _emailController.text,
      'username': _userIdController.text,
      'password': _passwordController.text,
      'mobile': _mobileController.text,
      'firstname': _firstNameController.text,
      'lastname': _lsstNameController.text
    };
    try {
      final response = await http.post(
        Uri.parse(baseURL + 'register'),
        body: bodyReq,
      );
      var model = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', model['access_token']);
          prefs.setBool('isLogin', true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => KycDetail(),
            ),
            (Route<dynamic> route) => false,
          );
        }
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
      showToast(Exepction.toString());
    }
  }

  Future checkReferal() async {
    // progressHUD.state.show();

    var bodyReq = {
      'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
      'ref_id': _referalController.text,
    };
    try {
      print(baseURL + 'check/referral');
      final response = await http.post(
        Uri.parse(baseURL + 'check/referral'),
        body: bodyReq,
      );
      var model = json.decode(response.body);
      if (response.statusCode == 200) {
        // progressHUD.state.dismiss();
        if (model["status"] == 'fail') {
          setState(() {
            isChecked = false;
          });
          // showToast(model["msg"].toString());
        } else {
          if (model['msg'] == 'Referrer username matched') {
            setState(() {
              isChecked = true;
            });
          }
        }
      } else {
        // progressHUD.state.dismiss();
        showToast(model["msg"].toString());
      }
    } catch (Exepction) {
      // progressHUD.state.dismiss();
      showToast(Exepction.toString());
    }
  }
}
