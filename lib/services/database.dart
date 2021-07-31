import 'package:flutter/cupertino.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/services/FireStore_services.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database {
  Future<void> setJob(JobModel job);

  Stream<List<JobModel>> streamJobs();

  Future<void> deleteJob(JobModel job);
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final _fireStoreServices = FireStoreService.instance;

  @override
  Future<void> setJob(JobModel job) =>
      _fireStoreServices.setData(APIPath.job(uid, job.id), job.toMap());

  @override
  Stream<List<JobModel>> streamJobs() =>
      _fireStoreServices.collectionStream<JobModel>(
          path: APIPath.jobs(uid),
          builder: (data, jobId) => JobModel.fromMap(data, jobId));

  @override
  Future<void> deleteJob(JobModel job) =>
      _fireStoreServices.deleteData(APIPath.job(uid, job.id));
}
