import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/home/jobs/jobs_page.dart';
import 'file:///C:/Flutter_Projects/time_tracker/Time-Tracking/lib/sign_in/sign_in_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context,listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChange(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user != null) {
              return Provider<Database>(
                create: (_) => FireStoreDatabase(uid: user.uid),
                  child: JobsPage()
              );
            } else {
              return MySignInPage.create(context);
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
