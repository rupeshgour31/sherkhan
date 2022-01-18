import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'assets/images/appimg1.jpeg',
                        height: 120,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: CustomColors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.2),
                            // spreadRadius: 0.1,
                            blurRadius: 0.2,
                          ),
                        ],
                      ),
                      child: AllInputDesign(
                        controller: _emailController,
                        labelText: 'Email',
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
                            return 'Please enter email';
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
                                  Color(0xffF26455),
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
                                // _login()
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
}
