import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _emailController = TextEditingController();
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text(
          'My Profile',
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
                Icons.account_circle,
                color: CustomColors.black,
                size: 90,
              ),
              isEdit
                  ? SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isEdit = true;
                        });
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 17,
                        ),
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
                  enabled: isEdit,
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
                  labelText: 'Email',
                  enabled: isEdit,
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
                  labelText: 'Mobile',
                  enabled: isEdit,
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
                  labelText: 'Blood Group',
                  enabled: isEdit,
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
                  labelText: 'Gender',
                  enabled: isEdit,
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
                  labelText: 'Address',
                  enabled: isEdit,
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
              isEdit
                  ? Container(
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
                          'Save',
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
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
