import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Config/inputTextForm.dart';
import 'package:test_project/Config/payment_view.dart';
import 'package:test_project/Screens/navigation_page.dart';
import 'package:test_project/Screens/onBoardingNavBar.dart';

var planValues;

class BitDeposit extends StatefulWidget {
  final String from;
  BitDeposit({required this.from});
  @override
  _BitDepositState createState() => _BitDepositState();
}

class _BitDepositState extends State<BitDeposit> {
  bool isLoading = false;
  bool isLoading2 = false;
  bool isLoading3 = false;
  List dataShow = [];
  int selecePlan = 0;
  late Razorpay _razorpay;
  @override
  void initState() {
    getDashboard();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    successApi(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: response.message, toastLength: Toast.LENGTH_SHORT);
    print('errror opppp ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ", toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() async {
    var amount = double.parse(planValues['bv']) * 100;
    var options = {
      'key': 'rzp_test_d3eLnftDL7TJBP', //1eZI9hMlRfkg9XAPD3EVcb0T
      'amount': amount.toString(),
      'name': '',
      'description': '',
      'prefill': {
        'contact': USERMOBILE,
        'email': USEREMAIL,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error----: $e');
    }
  }

  Future getDashboard() async {
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
      final response = await http.get(
        Uri.parse(
          baseURL + 'plan?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
        headers: header,
      );
      var model = json.decode(response.body);
      print('------- $model');
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        if (model["status"] == 'fail') {
          showToast(model["msg"].toString());
        } else {
          setState(() {
            dataShow = model['data'];
          });
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
      // showToast(Exepction.toString());
    }
  }

  successApi(paymentId) async {
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
        Uri.parse(
          'https://admin.sherkhanril.com/api/deposit/manual?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
      );
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'amount': planValues['price'],
        'method_code': '1000',
        // 'razorpay_payment_id': '$paymentId',
        'plan_id': planValues['id'].toString(),
        // 'payment_status': 'success'
      });
      request.headers.addAll(header);
      var response = await request.send();
      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
        var fnh = jsonDecode(model);
        print('rrrr $fnh');
        setState(() {
          isLoading = false;
        });
        if (fnh['status'] == 'fail') {
          showToast(fnh["msg"].toString());
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentView(
                orderNo: fnh['order_no'],
                price: planValues['price'],
              ),
            ),
          );
          // Fluttertoast.showToast(
          //   msg: "SUCCESS: ${paymentId}",
          //   toastLength: Toast.LENGTH_SHORT,
          // );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.reasonPhrase);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          widget.from == 'register' ? _onBackPressed() : null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.darkOrange,
          title: Text('Bit Deposit'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 20, right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationPage(
                          currentTab: 2,
                        ),
                      ),
                      (route) => false);
                },
                child: Text('Skip'),
              ),
            )
          ],
        ),
        bottomSheet: Container(
          height: 70,
          padding: EdgeInsets.only(left: 25, right: 25),
          decoration: BoxDecoration(
              color: CustomColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade200, offset: Offset(-4, -4))
              ]),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              if (selecePlan == 0) {
                showToast('Please select plan first');
              } else {
                // openCheckout();
                successApi('');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentView(),
                //   ),
                // );
              }
            },
            child: Container(
              height: 47,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: selecePlan == 0
                    ? CustomColors.orange.withOpacity(0.5)
                    : CustomColors.darkOrange,
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: Alignment.center,
              child: isLoading2
                  ? CircularProgressIndicator()
                  : Text(
                      'Pay',
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
                child: dataShow.length == 0
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: Center(
                          child: Text(isLoading ? '' : 'No Data Found'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: dataShow.length, //_list.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final DateTime now =
                              DateTime.parse(dataShow[index]['created_at']);
                          final DateFormat formatter =
                              DateFormat('dd MMM yyyy');
                          final String formatted = formatter.format(now);
                          return Padding(
                            padding:
                                EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
                            child: Container(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selecePlan = dataShow[index]['id'];
                                    planValues = dataShow[index];
                                  });
                                  // setBackToOrderQues(_list, index, "OrderPaymentDetail");
                                },
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10.0, 10.0, 10.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        dataShow[index]['name'],
                                        style: TextStyle(
                                          color: CustomColors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '₹' + dataShow[index]['bv'],
                                        style: TextStyle(
                                          color: CustomColors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 10.0,
                                      // ),
                                      // Text(
                                      //   dataShow[index]['email'],
                                      //   style: TextStyle(
                                      //     color: CustomColors.black,
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 10.0,
                                      // ),
                                      // Text(
                                      //   'Join Date: ' + formatted.toString(),
                                      //   style: TextStyle(
                                      //     color: CustomColors.black,
                                      //     fontSize: 16,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: CustomColors.white,
                                border: Border.all(
                                  color: selecePlan == dataShow[index]['id']
                                      ? CustomColors.appBarColor
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          );
                        })),
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

  _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Are you sure?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(
            'Do you want to exit the app?',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Montserrat",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat",
                ),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            )
          ],
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }
}

class ConfirmDeposit extends StatefulWidget {
  const ConfirmDeposit({Key? key}) : super(key: key);

  @override
  _ConfirmDepositState createState() => _ConfirmDepositState();
}

class _ConfirmDepositState extends State<ConfirmDeposit> {
  TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  var img;
  var dataShow;
  bool isLoading = false;
  late Razorpay _razorpay;

  @override
  void initState() {
    // depositReq();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", toastLength: Toast.LENGTH_SHORT);
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ThankYouPage(),
    //   ),
    //       (route) => false,
    // );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: response.message, toastLength: Toast.LENGTH_SHORT);
    print('errror opppp ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ", toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() async {
    var amount = double.parse(_emailController.text) * 100;
    var options = {
      'key': 'rzp_test_d3eLnftDL7TJBP', //1eZI9hMlRfkg9XAPD3EVcb0T
      'amount': amount.toString(),
      'name': '',
      'description': '',
      'prefill': {
        'contact': USERMOBILE,
        'email': USEREMAIL,
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Future depositReq() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');
    setState(() {
      isLoading = true;
    });
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth'
    };
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://admin.sherkhanril.com/api/deposit',
        ),
      );
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'amount': planValues['bv'],
        'method_code': '1000',
        'plan_id': planValues['id'].toString(),
        'transaction_hash': _emailController.text,
        'transaction_date': formatted.toString(),
      });
      // request.files.add(await http.MultipartFile.fromPath(
      //   'payment_screenshot',
      //   _imageFile!.path,
      // ));
      request.headers.addAll(header);

      var response = await request.send();
      if (response.statusCode == 200) {
        var model = await response.stream.bytesToString();
        print('00000 $model');
        var fnh = jsonDecode(model);
        setState(() {
          isLoading = false;
        });
        if (fnh == 'fail') {
          showToast(fnh["msg"].toString());

          // showToast(fnh["msg"].toString());
        } else {
          setState(() {
            dataShow = fnh[0];
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print(response.reasonPhrase);
      }
    } catch (Exepction) {
      setState(() {
        isLoading = false;
      });
      // showToast(Exepction.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        title: Text('Confirm Bit Deposit'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
        ),
        child: Form(
          key: _formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   dataShow['name'],
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 15),
              // Text(
              //   dataShow['symbol'] + '' + dataShow['method_code'],
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // SizedBox(height: 15),
              // Html(
              //   data: dataShow['method']['description'],
              // ),
              /*
                      upar ka qr code se pay karne ka code hai.
                     */
              AllInputDesign(
                controller: _emailController,
                labelText: 'Transaction Amount',
                keyBoardType: TextInputType.number,
                contentPadding: EdgeInsets.all(5.0),
                validator: (text) {
                  if (text.isEmpty || text == null)
                    return 'Please enter Transaction Amount';
                  else
                    return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () => _showPicker(),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: CustomColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    img != null ? img.path.toString() : 'Upload Payment Proof',
                    maxLines: 2,
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
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
                          'Pay Now',
                          style: TextStyle(
                            color: CustomColors.white,
                          ),
                        ),
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      openCheckout();
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
    );
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
