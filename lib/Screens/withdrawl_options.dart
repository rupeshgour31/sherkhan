import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/order_history.dart';
import 'package:test_project/Screens/withdraw.dart';

class WithdrawlOption extends StatefulWidget {
  const WithdrawlOption({Key? key}) : super(key: key);

  @override
  _WithdrawlOptionState createState() => _WithdrawlOptionState();
}

class _WithdrawlOptionState extends State<WithdrawlOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.darkOrange,
        automaticallyImplyLeading: true,
        title: Text(
          'Withdraw Options',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        // child:
      ),
    );
  }
}
