import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideo/components/progressbar.dart';
import 'package:rideo/main.dart';
import 'package:rideo/views/home_screen.dart';
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
                decoration: InputDecoration(
                    hintText: "Full Name", labelText: "Full Name")),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(hintText: "Email", labelText: "Email"),
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
              decoration: InputDecoration(
                  hintText: "Phone Number", labelText: "Phone Number"),
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
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                )),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text.length < 6) {
                  showToastmsg("Invalid Input", context);
                } else if (!_emailController.text.contains("@")) {
                  showToastmsg("Invalid emaill", context);
                } else if (_phoneNumberController.text.length < 8 ||
                    _phoneNumberController.text.isEmpty) {
                  showToastmsg("Enter a valid number", context);
                } else if (_passwordController.text.length < 6) {
                  showToastmsg("Enter atleast 8 characters", context);
                } else {
                  registerUser(context);
                }
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
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ProgressBar(message: "registering in...");
        });
    final User? firebaseUser = (await _auth
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .catchError((errMsg) {
      showToastmsg('error message' + errMsg.toString(), context);
      Navigator.pop(context);
    }))
        .user!;

    if (firebaseUser != null) {
      Map userData = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneNumberController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userData);
      showToastmsg("Registered Successfully", context);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.homeID, (route) => false);
    } else {
      Navigator.pop(context);
      showToastmsg("User creation failed", context);
    }
  }

  showToastmsg(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
