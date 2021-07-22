import 'package:flutter/cupertino.dart';

class JobModel {
  JobModel(
      {@required this.id, @required this.name, @required this.ratePerHour});

  final String id;
  final String name;
  final int ratePerHour;

  factory JobModel.fromMap(Map<String, dynamic> data, String jobId) {
    if (data == null) {
      return null;
    }
    return JobModel(name: data["name"], ratePerHour: data["ratePerHour"],id: jobId);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "ratePerHour": ratePerHour,
    };
  }
}
