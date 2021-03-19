import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase{
  User get currentUser;
  Future<UserCredential> signInAnonymously();
  Future<void> signOut();
}
class AuthClass implements AuthBase{
  @override
  User get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<UserCredential> signInAnonymously() async {
    final userCredential =  await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }
  @override
  Future<void> signOut() async{
     await FirebaseAuth.instance.signOut();
  }
}