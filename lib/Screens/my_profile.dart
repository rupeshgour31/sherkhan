import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/validations.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool isEdit = false;
  bool isLoading = false;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  var img;
  var netImg;

  @override
  void initState() {
    getMyProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text(
          'My Profile',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      isEdit ? _showPicker() : null;
                    },
                    child: _imageFile != null
                        ? Container(
                            margin: EdgeInsets.all(2),
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  File(img.path),
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(
                                  color: CustomColors.black,
                                  width: 1.3,
                                )),
                            child: Image.network(
                              'https://admin.sherkhanril.com/assets/images/user/profile/$netImg',
                            ),
                          ),
                  ),
                  SizedBox(height: 15),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  SizedBox(height: 15),
                  AllInputDesign(
                    controller: _firstNameController,
                    labelText: 'First Name',
                    enabled: isEdit,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: CustomColors.white,
                    contentPadding: EdgeInsets.all(5.0),
                    validator: validateName,
                  ),
                  SizedBox(height: 15),
                  AllInputDesign(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                    enabled: isEdit,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: CustomColors.white,
                    contentPadding: EdgeInsets.all(5.0),
                    validator: validateLastName,
                  ),
                  SizedBox(height: 15),
                  AllInputDesign(
                    controller: _emailController,
                    labelText: 'Email',
                    enabled: isEdit,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: CustomColors.white,
                    contentPadding: EdgeInsets.all(5.0),
                    validator: validateEmail,
                  ),
                  SizedBox(height: 15),
                  AllInputDesign(
                    controller: _mobileController,
                    labelText: 'Mobile',
                    enabled: isEdit,
                    keyBoardType: TextInputType.emailAddress,
                    fillColor: CustomColors.white,
                    contentPadding: EdgeInsets.all(5.0),
                    validator: validateMobile,
                  ),
                  // SizedBox(height: 15),
                  // AllInputDesign(
                  //   // controller: _emailController,
                  //   labelText: 'Blood Group',
                  //   enabled: isEdit,
                  //   keyBoardType: TextInputType.emailAddress,
                  //   fillColor: CustomColors.white,
                  //   contentPadding: EdgeInsets.all(5.0),
                  //   // validator:
                  // ),
                  // SizedBox(height: 15),
                  // AllInputDesign(
                  //   // controller: _emailController,
                  //   labelText: 'Gender',
                  //   enabled: isEdit,
                  //   keyBoardType: TextInputType.emailAddress,
                  //   fillColor: CustomColors.white,
                  //   contentPadding: EdgeInsets.all(5.0),
                  //   validator: (text) {
                  //     if (text.isEmpty || text == null)
                  //       return 'Please enter email';
                  //     else
                  //       return null;
                  //   },
                  // ),
                  // SizedBox(height: 15),
                  // AllInputDesign(
                  //   // controller: _emailController,
                  //   labelText: 'Address',
                  //   enabled: isEdit,
                  //   keyBoardType: TextInputType.emailAddress,
                  //   fillColor: CustomColors.white,
                  //   contentPadding: EdgeInsets.all(5.0),
                  // ),
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
                                Color(0xffEA1600).withOpacity(0.7),
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
                              updateMyProfile();
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
    );
  }

  Future getMyProfile() async {
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
            _emailController.text = model['user_email'];
            _mobileController.text = model['mobile'];
            _firstNameController.text = model['firstname'];
            _lastNameController.text = model['lastname'];
            netImg = model['image'];
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
      showToast(Exepction.toString());
    }
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
      // print(baseURL +
      //     'profile-setting?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14');
      // final response = await http.post(
      //     Uri.parse(
      //       baseURL + 'myprofile?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
      //     ),
      //     headers: header,
      //     body: {});

      var request = http.MultipartRequest('POST',
          Uri.parse('https://admin.sherkhanril.com/api/profile-setting'));
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'firstname': _firstNameController.text,
        'lastname': _lastNameController.text,
        'address': '',
        'state': '',
        'zip': '',
        'city': ''
      });
      if (_imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _imageFile!.path,
          ),
        );
      }
      request.headers.addAll(header);

      var response = await request.send();

      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
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

  _imgFromCamera() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 75,
      maxHeight: 300,
      maxWidth: 400,
    );
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
        img = _imageFile;
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 75,
      maxHeight: 300,
      maxWidth: 400,
    );
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
        img = _imageFile;
      }
    });
  }

  void _showPicker() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text(
                    'Photo Library',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    _imgFromGallery();
                  },
                ),
                new ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text(
                    'Camera',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _imgFromCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
