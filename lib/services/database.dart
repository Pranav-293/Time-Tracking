
import 'package:flutter/cupertino.dart';
import '../home/job.dart';
import 'package:time_tracker/services/FireStore_services.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database{
  Future<void> createJob(JobModel job );
  Stream<List<JobModel>> streamJobs();
}
class FireStoreDatabase implements Database{
  FireStoreDatabase({@required this.uid}) : assert(uid!=null);
  final String uid;
  final fireStoreServices = FireStoreService.instance;
  Future<void> createJob(JobModel job ) =>fireStoreServices.setData(APIPath.job(uid, "job_abc"), job.toMap());
  Stream<List<JobModel>> streamJobs()=> fireStoreServices.collectionStream<JobModel>(path: APIPath.jobs(uid), builder:(data)=>JobModel.fromMap(data));

}