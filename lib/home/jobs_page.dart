
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';

class JobsPage extends StatelessWidget {
  void _signOut(BuildContext context) async{
    final auth = Provider.of<AuthBase>(context, listen: false);
    Navigator.of(context).pop();
    await auth.signOut();
}
void _showAlert(BuildContext context){
    showCupertinoDialog(context: context,
        builder:(context)=> CupertinoAlertDialog(
          title: Text("Log out"),
          content: Text("Are you sure you want to logout"),
          actions: [
            TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("NO")),
            TextButton(onPressed:()=> _signOut(context), child: Text("Yes")),
          ],
        ));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed:()=> _showAlert(context),
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
