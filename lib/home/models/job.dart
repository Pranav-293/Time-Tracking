import 'package:flutter/cupertino.dart';

class Job{
  Job({@required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;

  factory Job.fromMap(Map<String,dynamic> data){
    if(data==null){
      return null;
    }
    return Job(name: data["name"], ratePerHour: data["ratePerHour"]);
  }

  Map<String, dynamic> toMap(){
    return{
      "name" : name,
      "ratePerHour" : ratePerHour,
    };
  }
}