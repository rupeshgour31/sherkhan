import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomColors {
  static final Color orange = Color(0xffFF4500);
  static final Color lightOrange = Color(0xFFe9523f);
  static final Color darkOrange = Color(0xffEA1600);
  static final Color appBarColor1 = Color(0xffFF4500);
  static final Color appBarColor = Color(0xffEA1600);
  static final Color peach = const Color(0xfffab087);
  static final Color white = const Color(0xffffffff);
  static final Color black = Colors.black;
  static final Color darkGrey = Colors.grey;
}

var USERNAME;
var ISREF = false;
var USEREMAIL;
var USEREMAIL2;
var USERNAME1;
var USERMOBILE;
var MYBALANCE;
var TOTALBIT;
var TOTALIPO;
final String baseURL = 'https://admin.sherkhanril.com/api/';
Future showToast(message) {
  return Fluttertoast.showToast(
    msg: message.toString(),
    backgroundColor: CustomColors.orange,
    textColor: CustomColors.white,
  );
}
