import 'package:flutter/cupertino.dart';
import 'package:time_tracker/home/jobs/job.dart';
import 'package:time_tracker/services/FireStore_services.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database {
  Future<void> createJob(JobModel job);

  Stream<List<JobModel>> streamJobs();
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  final fireStoreServices = FireStoreService.instance;
  String documentIDFormCurrentTime() => DateTime.now().toIso8601String();

  Future<void> createJob(JobModel job) =>
      fireStoreServices.setData(APIPath.job(uid, documentIDFormCurrentTime()), job.toMap());

  Stream<List<JobModel>> streamJobs() =>
      fireStoreServices.collectionStream<JobModel>(
          path: APIPath.jobs(uid), builder: (data) => JobModel.fromMap(data));
}
