import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/sign_in/sign_in_with_email_model.dart';

class SignInWithEmailBloc {
  SignInWithEmailBloc({@required this.auth});

  final AuthClass auth;
  final StreamController<SignInWithEmailModel> _emailModelController =
      new StreamController();
  SignInWithEmailModel _model = new SignInWithEmailModel();

  Stream get emailModelStream => _emailModelController.stream;

  void dispose() {
    _emailModelController.close();
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    _emailModelController.add(_model);
  }

  Future<void> submit() async {
    _model.copyWith(isLoading: true);
    try {
      (_model.formType == EmailSignInFormType.signIn)
          ? await auth.signInWithEmail(_model.email, _model.password)
          : await auth.createAccountWithEmail(_model.email, _model.password);
    } catch (e) {
      throw Exception(e.toString());
      rethrow;
    } finally {
      _model.copyWith(isLoading: false);
    }
  }
}
