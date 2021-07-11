import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/alert_exception_dialogue_box.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

import 'models/job.dart';

class JobsPage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    Navigator.of(context).pop();
    await auth.signOut();
  }

  void _showAlert(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text("Log out"),
              content: Text("Are you sure you want to logout"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("NO")),
                TextButton(
                    onPressed: () => _signOut(context), child: Text("Yes")),
              ],
            ));
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final dataBase = Provider.of<Database>(context, listen: false);
      await dataBase.createJob(Job(name: "Coding", ratePerHour: 10));
    } catch (e) {
      alertExceptionDialogue(
          context: context, heading: "Operation Failed", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jobs"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _showAlert(context),
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<Job>>(
        stream: database.streamJobs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            final children = jobs.map((job) => ListTile(title: Text(job.name), trailing: Text(job.ratePerHour.toString()),)).toList();
            return ListView(children: children);
          }
          if(snapshot.hasError){
            return Center(child: Text("Some error occured"));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
