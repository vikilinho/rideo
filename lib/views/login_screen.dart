import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rideo/components/progressbar.dart';
import 'package:rideo/main.dart';
import 'package:rideo/views/home_screen.dart';
import 'package:rideo/views/signup.dart';

class Login extends StatefulWidget {
  static const String logID = 'LOGIN_SCREEN';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              controller: emailController,
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
              obscureText: true,
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Password"),
            ),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {
                if (emailController.text.length < 8) {
                  showToastmsg("Enter a valied email address", context);
                } else if (passwordController.text.isEmpty) {
                  showToastmsg("Enter a valid password", context);
                } else {
                  loginUser(context);
                }
              },
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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ProgressBar(message: "Logging in...");
        });
    final User? firebaseUser = (await _auth
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      showToastmsg('error message' + errMsg.toString(), context);
    }))
        .user!;

    if (firebaseUser != null) {
      userRef
          .child(firebaseUser.uid)
          .once()
          .then((value) => (DataSnapshot snapshot) {
                if (snapshot.value != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.homeID, (route) => false);
                  showToastmsg("Login Successfully", context);
                } else {
                  _auth.signOut();
                  showToastmsg("User does not exists", context);
                }
              });

      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.homeID, (route) => false);
    } else {
      Navigator.pop(context);
      showToastmsg("User login error", context);
    }
  }

  showToastmsg(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
