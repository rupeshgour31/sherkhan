import 'package:flutter/material.dart';
import 'package:test_project/Config/common_widgets.dart';
import 'package:test_project/Screens/kyc_detail.dart';
import 'package:test_project/Screens/my_profile.dart';
import 'package:test_project/Screens/order_history.dart';
import 'package:test_project/Screens/transaction_history.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.orange,
        title: Text('My Account'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),

                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/appimg1.jpeg',
                    height: 140,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                // Container(
                //   height: 85,
                //   width: 85,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(
                //       color: CustomColors.black,
                //     ),
                //   ),
                //   alignment: Alignment.center,
                //   child: Icon(
                //     Icons.account_circle_outlined,
                //     size: 85,
                //   ),
                // ),
                // SizedBox(height: 15),
                // Text(
                //   'Hello User',
                //   style: TextStyle(
                //     color: CustomColors.black,
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                SizedBox(height: 15),
                commonListTile(
                  'Profile',
                  Icon(
                    Icons.account_circle,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfile(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Order History',
                  Icon(
                    Icons.shopping_cart_sharp,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistory(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'My Transactions',
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionHistory(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'KYC',
                  Icon(
                    Icons.verified_user,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KycDetail(),
                      ),
                    );
                  },
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'BIT Deposit',
                  Icon(
                    Icons.stay_current_portrait,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Team IPO',
                  Icon(
                    Icons.category,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Team BIT',
                  Icon(
                    Icons.verified,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Withdraw',
                  Icon(
                    Icons.verified_user,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Setting',
                  Icon(
                    Icons.settings,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Logout',
                  Icon(
                    Icons.logout,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Invite Friend',
                  Icon(
                    Icons.share,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Tutorials',
                  Icon(
                    Icons.title_outlined,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),
                commonListTile(
                  'Customer Support',
                  Icon(
                    Icons.supervised_user_circle,
                    color: CustomColors.black,
                    size: 25,
                  ),
                  () {},
                ),
                Divider(height: 1, thickness: 1),

                SizedBox(height: 25),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget commonListTile(String title, leading, ontap) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 30, right: 30, bottom: 5),
      title: Text(
        title,
        style: TextStyle(
          color: CustomColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: leading,
      onTap: ontap,
    );
  }
}
