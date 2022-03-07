import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';
import 'package:test_project/Screens/forgot_password.dart';
import 'package:test_project/Screens/kyc_detail.dart';
import 'package:test_project/Screens/navigation_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  bool isLoading = false;
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
                        'Sign In',
                        style: TextStyle(
                          color: CustomColors.darkOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 40),
                      AllInputDesign(
                        controller: _emailController,
                        labelText: 'User Name',
                        validatorFieldValue: validateEmail,
                        keyBoardType: TextInputType.emailAddress,
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        validator: (text) {
                          if (text.isEmpty || text == null)
                            return 'Please enter user name';
                          else
                            return null;
                        },
                      ),
                      SizedBox(height: 15),
                      AllInputDesign(
                        controller: _passwordController,
                        labelText: 'Password',
                        validatorFieldValue: validatePassword,
                        fillColor: CustomColors.white,
                        contentPadding: EdgeInsets.all(5.0),
                        obsecureText: passwordVisible,
                        validator: (value) {
                          if (value.isEmpty || value == null)
                            return 'Please password';
                          if (value.length < 6)
                            return "Please enter a password with at least 6 characters";
                          else
                            return null;
                        },
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          ),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: CustomColors.orange,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
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
                                    // Color(0xffF26455),
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
                                        'Sign In',
                                        style: TextStyle(
                                          color: CustomColors.white,
                                        ),
                                      ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    logInpApi();
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
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               RegistrationScreen(),
                            //         ),
                            //       );
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
                            //             text: 'Don\'t have an account? ',
                            //             style: TextStyle(
                            //               fontSize: 15,
                            //               decoration: TextDecoration.underline,
                            //               color: Colors.grey[900],
                            //             ),
                            //           ),
                            //           TextSpan(
                            //             text: 'Sign Up',
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
                            // SizedBox(height: 10),
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

  Future logInpApi() async {
    // progressHUD.state.show();
    setState(() {
      isLoading = true;
    });
    var bodyReq = {
      'secret': 'bd5c49f2-a-44d4-8daa-6ff67ab1bc14',
      'email': _emailController.text,
      'password': _passwordController.text,
    };
    try {
      print(baseURL + 'register');
      print('request body ---- $bodyReq');
      final response = await http.post(
        Uri.parse(baseURL + 'login'),
        body: bodyReq,
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('authToken', model['access_token']);
          prefs.setBool('isLogin', true);
          setState(() {
            ISREF = false;
          });
          getProfile();
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

  Future getProfile() async {
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
      print(baseURL + 'myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14');
      final response = await http.get(
        Uri.parse(
          baseURL + 'myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
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
          if (model['kyc_status'].toString() == '0') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => KycDetail(),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationPage(
                  currentTab: 2,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          }
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
