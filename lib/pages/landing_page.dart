import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';
class LandingPage extends StatefulWidget {
  const LandingPage({@required this.auth});
  final AuthClass auth;
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
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return (_user!=null)?HomePage(
      auth: widget.auth,
      signOutCallback: ()=>_updateUser(null),
    )
        :MySignInPage(
      auth: widget.auth,
      onSignIn: (user)=>_updateUser(user),
    );
  }
}
