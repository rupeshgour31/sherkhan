import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List _list = [
    {
      'currency_sign': '\$',
      'booking_id': '676552',
      'discounted_amount': '75',
      'name': 'Test Product',
      'status': '1',
    },
    {
      'currency_sign': '\$',
      'booking_id': '3412342',
      'name': 'Test Product',
      'discounted_amount': '1232',
      'status': '2',
    },
    {
      'currency_sign': '\$',
      'booking_id': '451344',
      'name': 'Test Product',
      'discounted_amount': '342',
      'status': '3',
    },
    {
      'currency_sign': '\$',
      'booking_id': '234324',
      'name': 'Test Product',
      'discounted_amount': '784',
      'status': '4',
    },
    {
      'currency_sign': '\$',
      'booking_id': '3544334',
      'name': 'Test Product',
      'discounted_amount': '424',
      'status': '5',
    },
    {
      'currency_sign': '\$',
      'booking_id': '12324324',
      'name': 'Test Product',
      'discounted_amount': '231',
      'status': '6',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text(
          'Order History',
          style: TextStyle(
            color: CustomColors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                itemCount: _list.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          // setBackToOrderQues(_list, index, "OrderPaymentDetail");
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "#" +
                                          _list[index]['booking_id'].toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      _list[index]['name'].toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                      _list[index]['currency_sign'].toString() +
                                          ' ' +
                                          _list[index]['discounted_amount']
                                              .toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black),
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    orderStatusSet(_list, index),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                                margin: EdgeInsets.only(bottom: 8),
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                              )
                              // setActionOrder(_list, index),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.all(Radius.circular(
                                5.0) //                 <--- border radius here
                            ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  orderStatusSet(list, index) {
    //1=new order,2=dispatch ready,3=on the way,4=delivered,5=cancel by user,6=cancel by admin
    var colour = Colors.green;
    var text = "";
    if (list[index]['status'] == "1") {
      colour = Colors.red;
      text = "new_order";
    } else if (list[index]['status'] == "2") {
      colour = Colors.green;
      text = "dispatch_ready";
    } else if (list[index]['status'] == "3") {
      colour = Colors.green;
      text = "on_the_way";
    } else if (list[index]['status'] == "4") {
      colour = Colors.green;
      text = "delivered";
    } else if (list[index]['status'] == "5") {
      colour = Colors.red;
      text = "cancelled_by_user";
    } else if (list[index]['status'] == "6") {
      colour = Colors.red;
      text = "cancelled_by_admin";
    } else {
      colour = Colors.green;
      text = "cancelled_by_admin";
    }
    return Text(
      text.toString(),
      maxLines: 1,
      style: TextStyle(
        fontSize: 16.0,
        color: colour,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montaga',
      ),
    );
  }
}
