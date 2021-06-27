import 'dart:async';
import 'package:time_tracker/sign_in/sign_in_with_email_model.dart';

class SignInWithEmailBloc{
  final StreamController<SignInWithEmailModel> _emailModelController = new StreamController();
   Stream get emailModelStream => _emailModelController.stream;

   void dispose(){
     _emailModelController.close();
   }
}