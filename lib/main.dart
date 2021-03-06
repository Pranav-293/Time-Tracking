import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///C:/Flutter_Projects/time_tracker/Time-Tracking/lib/sign_in/landing_page.dart';
import 'package:time_tracker/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create:(context)=>AuthClass(),
       child: MaterialApp(
           title: 'Time Tracker',
           theme: ThemeData(
             primarySwatch: Colors.indigo,
           ),
           home: LandingPage(
           ),
         )
         ,
    );
  }
}

