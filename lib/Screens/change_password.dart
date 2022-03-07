import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formValid = GlobalKey<FormState>();
  TextEditingController _currentPass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text('Change Password'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Form(
                key: _formValid,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    AllInputDesign(
                      controller: _currentPass,
                      labelText: 'Current Password',
                      obsecureText: true,
                      fillColor: CustomColors.white,
                      contentPadding: EdgeInsets.all(5.0),
                      validator: validatePassword,
                    ),
                    SizedBox(height: 20),
                    AllInputDesign(
                      controller: _newPass,
                      obsecureText: true,
                      labelText: 'New Password',
                      fillColor: CustomColors.white,
                      contentPadding: EdgeInsets.all(5.0),
                      validator: validatePassword,
                    ),
                    SizedBox(height: 45),
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
                                'Submit',
                                style: TextStyle(
                                  color: CustomColors.white,
                                ),
                              ),
                        onPressed: () {
                          if (_formValid.currentState!.validate()) {
                            updateMyProfile();
                          }
                        },
                        textColor: CustomColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future updateMyProfile() async {
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
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://admin.sherkhanril.com/api/change-password'),
      );
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'current_password': _currentPass.text,
        'password': _newPass.text,
      });
      request.headers.addAll(header);

      var response = await request.send();

      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
        print('00000 $model');
        var fnh = jsonDecode(model);
        setState(() {
          isLoading = false;
        });
        // progressHUD.state.dismiss();
        if (fnh == 'success') {
          showToast(fnh["msg"].toString());
        } else {
          showToast(fnh["msg"].toString());
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.reasonPhrase);
      }

      // var model;
      // print('------- $model');
      // if (response.statusCode == 200) {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   // progressHUD.state.dismiss();
      //   if (model["status"] == 'fail') {
      //     showToast(model["msg"].toString());
      //   } else {
      //     setState(() {
      //       _emailController.text = model['email'];
      //       _mobileController.text = model['mobile'];
      //       _firstNameController.text = model['firstname'];
      //       _lastNameController.text = model['lastname'];
      //     });
      //   }
      // } else {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   // progressHUD.state.dismiss();
      //   showToast(model["msg"].toString());
      // }
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
      // progressHUD.state.dismiss();
      showToast(Exepction.toString());
    }
  }
}
