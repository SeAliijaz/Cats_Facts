import 'package:cats_facts/Home_Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
        ///title of app
        title: 'Cats-Facts',

        ///debugShowCheckedModeBanner
        debugShowCheckedModeBanner: false,

        ///home
        home: HomeScreen(),
      );
    }));
  }
}
