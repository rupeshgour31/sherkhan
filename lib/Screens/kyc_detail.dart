import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/Screens/bit_deposit.dart';

class KycDetail extends StatefulWidget {
  const KycDetail({Key? key}) : super(key: key);

  @override
  _KycDetailState createState() => _KycDetailState();
}

class _KycDetailState extends State<KycDetail> {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _bankAccController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  var img;

  @override
  void initState() {
    getProfile();
    super.initState();
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
      print('------- ${model['image']}');
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
            // _emailController.text = model['user_email'];
            // _mobileController.text = model['mobile'];
            _fnameController.text = model['firstname'];
            _lnameController.text = model['lastname'];
            _panController.text = model['pan_no'];
            _aadharController.text = model['aadhar_no'];
            _bankAccController.text = model['account_no'];
            _ifscController.text = model['ifsc_code'];
            _bankNameController.text = model['bank_name'];
            // netImg = model['image'];
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
      print(Exepction.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text(
          'MY KYC',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Icon(
                    //   Icons.image_outlined,
                    //   color: CustomColors.black,
                    //   size: 150,
                    // ),
                    // Text(
                    //   'Image Upload',
                    //   style: TextStyle(
                    //     fontSize: 17,
                    //   ),
                    // ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _fnameController,
                        labelText: 'First Name',
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
                            return 'Please Enter First Name';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _lnameController,
                        labelText: 'Last Name',
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
                            return 'Please Enter Last Name';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _panController,
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
                            return 'Please Enter PAN Number';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _aadharController,
                        labelText: 'Aadhar Number',
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
                            return 'Please Enter Aadhar Number';
                          else
                            return null;
                        },
                      ),
                    ),
                    // SizedBox(height: 15),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       margin: EdgeInsets.all(2),
                    //       height: 100,
                    //       width: MediaQuery.of(context).size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey[200],
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: EdgeInsets.all(2),
                    //       height: 100,
                    //       width: MediaQuery.of(context).size.width * 0.4,
                    //       decoration: BoxDecoration(
                    //         color: Colors.grey[200],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _bankAccController,
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
                            return 'Please Enter Bank Account Number';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                        controller: _bankNameController,
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
                            return 'Please Enter Bank Name';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.5, 0.5, 1, 2),
                      decoration: BoxDecoration(
                          // color: Colors.grey[50],
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
                            return 'Please Enter IFSC Code';
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
                            Color(0xffEA1600).withOpacity(0.7),
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
                          if (_formKey.currentState!.validate()) {
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
          ),
          isLoading ? CircularProgressIndicator() : SizedBox.shrink()
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
      var request = http.MultipartRequest('POST',
          Uri.parse('https://admin.sherkhanril.com/api/profile-setting'));
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'firstname': _fnameController.text.toString(),
        'lastname': _lnameController.text.toString(),
        'address': 'test',
        'state': 'test',
        'zip': 'Admin@123',
        'city': 'ada',
        'image': 'adad',
        'pan_no': _panController.text.toString(),
        'aadhar_no': _aadharController.text.toString(),
        'account_no': _bankAccController.text.toString(),
        'ifsc_code': _ifscController.text.toString(),
        'bank_name': _bankNameController.text.toString(),
        'kyc_status': '1',
      });
      request.headers.addAll(header);

      var response = await request.send();

      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
        var fnh = jsonDecode(model);
        setState(() {
          isLoading = false;
        });
        if (fnh['status'] == 'success') {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isKYC', true);
          showToast(fnh["msg"].toString());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BitDeposit(from: 'register'),
              ),
              (route) => false);
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
      print(Exepction.toString());
    }
  }
}
