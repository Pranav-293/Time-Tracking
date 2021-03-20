import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Future<UserCredential> signInAnonymously();

  Future<void> signOut();

  Future<void> signInWithGoogle();

  Stream<User> authStateChange();
}

class AuthClass implements AuthBase {
  @override
  User get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Future<UserCredential> signInAnonymously() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleUserCredentials = await googleUser.authentication;
      if (googleUserCredentials.idToken != null) {
        final userCredential =await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleUserCredentials.idToken,
            accessToken: googleUserCredentials.accessToken,
          ),
        );
        return userCredential;
      }else{
        throw FirebaseAuthException(
          code: "Exception_Token_Id_is_Null",
          message: "Sign In aborted by the token Id",
        );
      }
    }else{
      throw FirebaseAuthException(
        code: "Exception_SignIn_Aborted_By_User",
        message: "Sign In aborted by the user",
      );
    }
  }

  @override
  Stream<User> authStateChange() => FirebaseAuth.instance.authStateChanges();

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}