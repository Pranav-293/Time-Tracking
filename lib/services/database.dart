import 'package:flutter/cupertino.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/services/FireStore_services.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database {
  Future<void> setJob(JobModel job);
  Stream<List<JobModel>> streamJobs();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final fireStoreServices = FireStoreService.instance;

  Future<void> setJob(JobModel job) =>
      fireStoreServices.setData(APIPath.job(uid, job.id), job.toMap());

  Stream<List<JobModel>> streamJobs() =>
      fireStoreServices.collectionStream<JobModel>(
          path: APIPath.jobs(uid), builder: (data,jobId) => JobModel.fromMap(data,jobId));
}
