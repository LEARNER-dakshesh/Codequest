import 'package:codequest/Authentication%20Page/auth_page.dart';
import 'package:codequest/HomePage.dart';
import 'package:codequest/Intro_Screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {

        'splash_screen':(context)=>Splash(),
        'Auth':(context)=>Auth(),
        'otp_screen':(context)=>HomePage(),
      },
    );
  }
}

