import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideo/views/signup.dart';

class Login extends StatefulWidget {
  static const String logID = 'LOGIN_SCREEN';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 65.0,
          ),
          Image(
            width: 300,
            height: 250,
            alignment: Alignment.centerRight,
            image: AssetImage(
              "images/logo.png",
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            "Login as a Rider",
            textAlign: TextAlign.center,
            style: GoogleFonts.sahitya(
                color: Colors.teal, fontSize: 35, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Email"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Password"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                  side: BorderSide(style: BorderStyle.solid)),
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Not registered?",
                style: GoogleFonts.sahitya(
                    fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(width: 15.0),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignUp.regID, (route) => false);
                  },
                  child: Text(
                    "SignUp",
                    style: GoogleFonts.sahitya(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.sahitya(color: Colors.red, fontSize: 16),
              )),
        ],
      ),
    );
  }
}
