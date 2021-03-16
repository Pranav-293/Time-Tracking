
import 'package:flutter/material.dart';
import 'package:time_tracker/custom_widgets/facebook_login_button.dart';
import 'package:time_tracker/custom_widgets/go_anonymous_button.dart';
import 'package:time_tracker/custom_widgets/google_login_button.dart';
import 'package:time_tracker/custom_widgets/login_with_email_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyLoginPage(),
    );
  }
}
class MyLoginPage extends StatelessWidget {
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
              "Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            LoginGoogle(),
            SizedBox(
              height: 22,
            ),
            LoginFacebook(),
            SizedBox(
              height: 22,
            ),
            LoginEmail(),
            SizedBox(
              height: 22,
            ),
            Text(
              "or"
            ),
            SizedBox(
              height: 22,
            ),
            LoginAnonymously(),
          ],
        ),
      ),
    );
  }
}


