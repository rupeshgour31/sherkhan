import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({Key? key}) : super(key: key);

  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subController = TextEditingController();
  final TextEditingController _msgController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Future getOpenSupport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    setState(() {
      isLoading = true;
    });
    var header = {
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth'
    };
    try {
      final response = await http.post(
          Uri.parse(
            baseURL +
                'ticket/create?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
          ),
          headers: header,
          body: {
            'name': _userIdController.text,
            'email': _emailController.text,
            'subject': _subController.text,
            'message': _msgController.text,
          });
      var model = json.decode(response.body);
      print('------- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          showToast(model["msg"].toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text('Create Ticket'),
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
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 18),
                AllInputDesign(
                  controller: _userIdController,
                  labelText: 'Name',
                  keyBoardType: TextInputType.emailAddress,
                  fillColor: CustomColors.white,
                  contentPadding: EdgeInsets.all(5.0),
                  validator: validateName,
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
                  controller: _subController,
                  labelText: 'Subject',
                  keyBoardType: TextInputType.emailAddress,
                  fillColor: CustomColors.white,
                  contentPadding: EdgeInsets.all(5.0),
                  validator: validateSubject,
                ),
                SizedBox(height: 18),
                AllInputDesign(
                  controller: _msgController,
                  labelText: 'Message',
                  keyBoardType: TextInputType.emailAddress,
                  fillColor: CustomColors.white,
                  contentPadding: EdgeInsets.all(5.0),
                  validator: validateMessage,
                ),
                SizedBox(height: 18),
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
                            'Create',
                            style: TextStyle(
                              color: CustomColors.white,
                            ),
                          ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        getOpenSupport();
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
      ),
    );
  }
}
