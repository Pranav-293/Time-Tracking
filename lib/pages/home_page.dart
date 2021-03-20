
import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.auth }) : super(key: key);
  final AuthClass auth;
  void signOut() async{
    await auth.signOut();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: signOut,
            child: Text("Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
