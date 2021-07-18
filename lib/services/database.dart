import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker/home/models/job.dart';
import 'package:time_tracker/services/FireStore_services.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database{
  Future<void> createJob(Job job );
  Stream<List<Job>> streamJobs();
}
class FireStoreDatabase implements Database{
  FireStoreDatabase({@required this.uid}) : assert(uid!=null);
  final String uid;
  final fireStoreServices = FireStoreService.instance;
  Future<void> createJob(Job job ) =>fireStoreServices.setData(APIPath.job(uid, "job_abc"), job.toMap());
  Stream<List<Job>> streamJobs()=> fireStoreServices.collectionStream(path: APIPath.jobs(uid), builder:(data)=>Job.fromMap(data));

}