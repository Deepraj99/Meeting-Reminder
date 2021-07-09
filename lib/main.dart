import 'package:flutter/material.dart';
import 'package:meeting_reminder/Home/homePage.dart';
import 'package:meeting_reminder/Home/login_signup_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meeting Reminder',
      debugShowCheckedModeBanner: false,
      home: LoginSignup(),
    );
  }
}
