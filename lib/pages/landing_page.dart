import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //instance of the user
  User _user;

  void _updateUser(User user){
  setState(() {
    _user = user;
  });
  }

  @override
  Widget build(BuildContext context) {
    return (_user!=null)?HomePage():MySignInPage(
      onSignIn: (user)=>_updateUser(user),
    );
  }
}
