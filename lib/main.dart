import 'package:flutter/material.dart';
import 'package:rideo/views/home_screen.dart';
import 'package:rideo/views/login_screen.dart';
import 'package:rideo/views/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        Login.logID: (context) => Login(),
        SignUp.regID: (context) => SignUp(),
        HomeScreen.homeID: (context) => HomeScreen(),
      },
      initialRoute: Login.logID,
    );
  }
}
