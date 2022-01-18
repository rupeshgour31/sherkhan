import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';

class KycDetail extends StatefulWidget {
  const KycDetail({Key? key}) : super(key: key);

  @override
  _KycDetailState createState() => _KycDetailState();
}

class _KycDetailState extends State<KycDetail> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text(
          'MY KYC',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Icon(
                Icons.image_outlined,
                color: CustomColors.black,
                size: 150,
              ),
              Text(
                'Image Upload',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 15),
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
                  // controller: _emailController,
                  labelText: 'Full Name',

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
                  labelText: 'PAN Number',
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
                  labelText: 'Adhar number',
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
                  labelText: 'Bank Account Number',
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
                  labelText: 'Bank Name',
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
                  labelText: 'Card Number',
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
                  child: Text(
                    'Complete KYC',
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
            ],
          ),
        ),
      ),
    );
  }
}
