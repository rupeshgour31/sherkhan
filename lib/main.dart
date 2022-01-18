import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/Screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<ValueNotifier<int>>(
        create: (_) => ValueNotifier<int>(0),
        child: SplashScreen(),
      ),
    );
  }
}
