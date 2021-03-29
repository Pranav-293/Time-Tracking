import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/pages/home_page.dart';
import 'package:time_tracker/pages/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthClass>(context,listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChange(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user != null) {
              return HomePage();
            } else {
              return MySignInPage();
            }
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
