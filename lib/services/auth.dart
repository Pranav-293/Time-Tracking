import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;

  Future<UserCredential> signInAnonymously();

  Future<void> signInWithGoogle();

  Future<void> signInWithFacebook();

  Stream<User> authStateChange();

  Future<void> signOut();

  Future<void> signInWithEmail(String email, String password);

  Future<void> createAccountWithEmail(String email, String password);
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
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleUserCredentials.idToken,
            accessToken: googleUserCredentials.accessToken,
          ),
        );
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: "Exception_Token_Id_is_Null",
          message: "Sign In aborted by the token Id",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: "Exception_SignIn_Aborted_By_User",
        message: "Sign In aborted by the user",
      );
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email,
        ]
    );
    switch (response.status) {
      case FacebookLoginStatus.success:
        final tokenNum = response.accessToken;
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
            FacebookAuthProvider.credential(tokenNum.token)
        );
        return userCredential;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(code: "Sign_Up_Aborted_By_The_User",
            message: "Sign in cancelled by the user");
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(code: "Sign_Up_Aborted_By_The_Error",
            message: response.error.developerMessage);
      default:
        throw UnimplementedError;
    }
  }

  @override
  Future<void> signInWithEmail(String email, String password) async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      return userCredentials;
    } catch (e) {
      print(e.toString());
      throw FirebaseAuthException(
        code: "Exception_Token_Id_is_Null",
        message: "Email or Password is badly formatted",
      );
    }
  }

  @override
  Future<void> createAccountWithEmail(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }catch(e){
      throw FirebaseAuthException(
        code: "Exception_Token_Id_is_Null",
        message: "Email or Password is badly formatted",
      );
    }
  }

  @override
  Stream<User> authStateChange() => FirebaseAuth.instance.authStateChanges();

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    final fb = FacebookLogin();
    fb.logOut();
    await FirebaseAuth.instance.signOut();
  }
}