import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List _list = [
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'demos',
    },
    {
      'currencySign': '\$',
      'booking_id': '676552',
      'totalAmount': '75',
      'market': 'Test Product',
      'paymentMethod': 'CASH',
      'operator': 'credit',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text(
          'Transaction History',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.credit_card_rounded,
                                          size: 45,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        textbold(
                                            _list[index]['market'].toString()),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        textbold(_list[index]['paymentMethod']
                                            .toString()),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: _list[index]['operator'] ==
                                                      'credit'
                                                  ? Colors.green
                                                  : Colors.red),
                                          child: Text(
                                            _list[index]['operator'],
                                            style: TextStyle(
                                              color: CustomColors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(_list[index]['currencySign']
                                            .toString()),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          _list[index]['totalAmount']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                      ],
                                    ),
                                    flex: 6,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Description : lorem ipsum",
                                style: TextStyle(color: CustomColors.black),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.black),
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

  textbold(text) {
    return Text(
      text,
      maxLines: 1,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
    );
  }
}
