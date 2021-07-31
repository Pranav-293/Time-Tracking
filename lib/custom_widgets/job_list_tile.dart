import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/home/jobs/job.dart';

class JobListTile extends StatelessWidget {
  const JobListTile({Key key, @required this.job, this.onTap})
      : super(key: key);
  final JobModel job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 0, 0),
      child: Container(
        child: ListTile(
          onTap: onTap,
          title: Text(
            job.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: 22,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
