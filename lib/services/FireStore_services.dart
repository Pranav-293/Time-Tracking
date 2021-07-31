import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FireStoreService {
  FireStoreService._();
  static final instance = FireStoreService._();
  Future<void> setData(String path, Map<String, dynamic> data) async{
    try{
      final reference = FirebaseFirestore.instance.doc(path);
      await reference.set(data);
    }
    catch (e){
      rethrow;
    }

  }

  Future<void> deleteData(String path) async{
    final reference = FirebaseFirestore.instance.doc(path);
    print("delete : $path");
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String,dynamic> data, String documentId) builder,
  }){
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
            (snapshot) => snapshot.docs.map((snapshot){
          final data = snapshot.data();
          return builder(data,snapshot.id);
        }).toList());
  }
}