import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/transactions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentView extends StatefulWidget {
  final orderNo;
  final price;
  PaymentView({this.orderNo, this.price});
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String paymentView = '';
  void initState() {
    super.initState();
    setState(() {
      paymentView =
          'https://payment.sherkhanril.com?email=$USEREMAIL2&mobile=$USERMOBILE&amount=${widget.price}&order_no=${widget.orderNo}';
    });
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    print('rrr $paymentView');
    return Scaffold(
      body: WebView(
        initialUrl: paymentView,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        // ignore: prefer_collection_literals
        // javascriptChannels: <JavascriptChannel>[
        //   _toasterJavascriptChannel(context),
        // ].toSet(),
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          // print('Page started loading: $url');
          // print(
          //     'Page started loading payment fail: ${url.contains("payment_fail")}');
          // print(
          //     'Page started loading payment success: ${url.contains("payment_success")}');
          // if (url.contains("payment_success")) {
          //   // if (url.contains("payment_fail")) {
          //   //   Navigator.pushAndRemoveUntil(
          //   //     context,
          //   //     MaterialPageRoute(
          //   //       builder: (context) => PaymentDenied(),
          //   //     ),
          //   //     (Route<dynamic> route) => false,
          //   //   );
          //   // } else {
          //
          //   // }
          // } else if (url.contains("payment_fail")) {}
        },
        onPageFinished: (String url) {
          print('Page finished loading: ${url.contains('payment_fail')}');
          print('Page finished loading: ${url.contains('payment_success')}');
          if (url.contains('payment_success')) {
            successApi();
          } else {}
        },
        gestureNavigationEnabled: true,
      ),
    );
  }

  successApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var auth = prefs.getString('authToken');

    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $auth'
    };
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          'https://admin.sherkhanril.com/api/deposit/confirm?secret=bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        ),
      );
      request.fields.addAll({
        'secret': 'bd5c49f2-2f73-44d4-8daa-6ff67ab1bc14',
        'payment_status': 'success',
        'plan_id': '',
        'Track': widget.orderNo,
      });
      request.headers.addAll(header);
      var response = await request.send();
      var model = await response.stream.bytesToString();
      var fnh = jsonDecode(model);
      print('123123123123 $fnh');
      if (response.statusCode == 200) {
        showToast('Payment Successful');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyTransactions(),
          ),
        );
        // setState(() {
        //   isLoading = false;
        // });
        // if (fnh['status'] == 'fail') {
        //   showToast(fnh["msg"].toString());
        // } else {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => PaymentView(
        //         orderNo: fnh['order_no'],
        //       ),
        //     ),
        //   );
        //   // Fluttertoast.showToast(
        //   //   msg: "SUCCESS: ${paymentId}",
        //   //   toastLength: Toast.LENGTH_SHORT,
        //   // );
        // }
      } else {
        Navigator.pop(context);
        print(response.reasonPhrase);
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }
}
