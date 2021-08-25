import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideo/views/login_screen.dart';

class SignUp extends StatefulWidget {
  static const String regID = 'SIGNUP_SCREEN';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
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
            "Register as a Rider",
            textAlign: TextAlign.center,
            style: GoogleFonts.sahitya(
                color: Colors.teal, fontSize: 35, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _nameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Full Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _emailController,
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
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Phone Number"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Password"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.length < 6 ||
                    _emailController.text.length < 6 ||
                    _phoneNumberController.text.length < 6 ||
                    _passwordController.text.length < 6) {
                  showToastmsg("Invalid Input", context);
                }
                registerUser(context);
              },
              child: Text("Register"),
              style: ElevatedButton.styleFrom(
                  side: BorderSide(style: BorderStyle.solid)),
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already registered?",
                style: GoogleFonts.sahitya(
                    fontSize: 20, fontWeight: FontWeight.w300),
              ),
              SizedBox(width: 15.0),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Login.logID, (route) => false);
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.sahitya(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  registerUser(BuildContext context) async {
    final firebaseuser = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (firebaseuser != null) {
      //save user to database with firebaseuser.uid as key
    } else {
      //show error;
    }
  }

  showToastmsg(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
