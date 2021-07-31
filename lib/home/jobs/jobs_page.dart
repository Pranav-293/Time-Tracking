import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/common_widgets/alert_exception_dialogue_box.dart';
import 'package:time_tracker/custom_widgets/job_list_tile.dart';
import 'package:time_tracker/home/jobs/edit_job_page.dart';
import 'package:time_tracker/home/jobs/empty_jobs_page.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/home/jobs/list_item_builders.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/services/database.dart';

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
        onPressed: () => EditJobPage.show(context),
      ),
    );
  }

  Future<void> _deleteJob(BuildContext context, JobModel item) async{
    try{
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(item);
    } catch (e){
      alertExceptionDialogue(
        context: context,
        heading: "Operation Failed",
        message: e.toString(),
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<JobModel>>(
        stream: database.streamJobs(),
        builder: (context, snapshot) {
          return ListItemBuilder<JobModel>(
            snapshot: snapshot,
            itemBuilder: (context, item) => Dismissible(
              background: Container(
                padding: EdgeInsets.only(right: 8.0),
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 36,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ),
              direction: DismissDirection.endToStart,
              key: Key("Job : ${item.id}"),
              onDismissed: (direction)=> _deleteJob(context,item),
              child: JobListTile(
                job: item,
                onTap: () => EditJobPage.show(context, job: item),
              ),
            ),
          );
        });
  }
}

