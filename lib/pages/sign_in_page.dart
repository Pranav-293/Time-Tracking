
import 'package:flutter/material.dart';
import 'package:time_tracker/custom_widgets/SignIn_with_email_button.dart';
import 'package:time_tracker/custom_widgets/facebook_SignIn_button.dart';
import 'package:time_tracker/custom_widgets/go_anonymous_button.dart';
import 'package:time_tracker/custom_widgets/google_SignIn_button.dart';
class MySignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SignInGoogle(),
            SizedBox(
              height: 22,
            ),
            SignInFacebook(),
            SizedBox(
              height: 22,
            ),
            SignInEmail(),
            SizedBox(
              height: 22,
            ),
            Text("or"),
            SizedBox(
              height: 22,
            ),
            SignInAnonymously(),
          ],
        ),
      ),
    );
  }
}
