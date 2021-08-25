import 'package:flutter/material.dart';
import 'package:rideo/views/login_screen.dart';
import 'package:rideo/views/signup.dart';

const String LOGIN_SCREEN = 'LOGIN_SCREEN';
const String SIGNUP_SCREEN = 'SIGNUP_SCREEN';
Route<dynamic?> nameRoutes(RouteSettings settings) {
  switch (settings.name) {
    case LOGIN_SCREEN:
      return MaterialPageRoute(builder: (context) => Login());
    case SIGNUP_SCREEN:
      return MaterialPageRoute(builder: (context) => SignUp());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('${settings.name} not found'),
          ),
        ),
      );
  }
}
