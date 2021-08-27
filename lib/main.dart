import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rideo/views/home_screen.dart';
import 'package:rideo/views/login_screen.dart';
import 'package:rideo/views/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance
    .reference()
    .child("user"); //called here so you can use in other part of your app

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
      initialRoute: HomeScreen.homeID,
    );
  }
}
