import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker/services/auth.dart';

class SignInBloc{
  SignInBloc(@required this.auth);
  final AuthClass auth;
  final StreamController<bool> _isLoadingController = new StreamController();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading){
    _isLoadingController.add(isLoading);
  }

  Future<UserCredential> signInAnonymously()async{
    try{
      _setIsLoading(true);
      return auth.signInAnonymously();
    }
    catch(e){
      rethrow;
    }
    finally{
      _setIsLoading(false);
    }
  }

  Future<void> signInWithGoogle()async{
    try{
      _setIsLoading(true);
      return auth.signInWithGoogle();
    }
    catch(e){
      rethrow;
    }
    finally{
      _setIsLoading(false);
    }
  }

  Future<void> signInWithFacebook()async{
    try{
      _setIsLoading(true);
      return auth.signInWithFacebook();
    }
    catch(e){
      rethrow;
    }
    finally{
      _setIsLoading(false);
    }
  }
}