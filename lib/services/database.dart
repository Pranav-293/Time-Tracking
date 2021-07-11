
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker/home/models/job.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database{
  Future<void> createJob(Job job );
  Stream<List<Job>> streamJobs();
}
class FireStoreDatabase implements Database{
  FireStoreDatabase({@required this.uid}) : assert(uid!=null);
  final String uid;
  Future<void> createJob(Job job ) =>_setData(APIPath.job(uid, "job_abc"), job.toMap());
  Future<void> _setData(String path, Map<String, dynamic> data) async{
    try{
      final reference = FirebaseFirestore.instance.doc(path);
      print("$uid : $data");
      await reference.set(data);
    }
    catch (e){
      rethrow;
    }

  }
  Stream<List<Job>> streamJobs(){
    final reference = FirebaseFirestore.instance.collection(APIPath.jobs(uid));
    final snapshots = reference.snapshots();
    return snapshots.map(
            (snapshot) => snapshot.docs.map((snapshot){
              final data = snapshot.data();
              return (data!=null) ? Job(name: data["name"], ratePerHour: data["ratePerHour"]): null;
            }).toList());
  }
}