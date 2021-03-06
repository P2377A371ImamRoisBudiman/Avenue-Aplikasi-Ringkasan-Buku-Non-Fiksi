// @dart=2.9
import 'package:avenue/view/bottom_view/bottom_view.dart';
import 'package:avenue/view/bottom_view/home.dart';
import 'package:avenue/view/login/login.dart';
import 'package:avenue/view/register/register.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color.fromARGB(255, 53, 52, 52),
        ),
        themeMode: ThemeMode.system,
        home: Login(),
      );
    });
  }
}
