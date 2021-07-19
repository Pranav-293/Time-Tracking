import 'package:flutter/cupertino.dart';

class JobModel{
  JobModel({@required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;

  factory JobModel.fromMap(Map<String,dynamic> data){
    if(data==null){
      return null;
    }
    return JobModel(name: data["name"], ratePerHour: data["ratePerHour"]);
  }

  Map<String, dynamic> toMap(){
    return{
      "name" : name,
      "ratePerHour" : ratePerHour,
    };
  }
}