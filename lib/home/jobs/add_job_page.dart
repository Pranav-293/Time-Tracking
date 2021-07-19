import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  @override
  _AddJobPageState createState() => _AddJobPageState();
  static Future<void> show(BuildContext context) async{
    await Navigator.of(context).push(
      MaterialPageRoute(builder:(context)=>AddJobPage(),
      fullscreenDialog: true)
    );
  }
}

class _AddJobPageState extends State<AddJobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Job"),),
    );
  }
}
