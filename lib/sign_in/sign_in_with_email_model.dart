import 'package:time_tracker/pages/login_with_email_page.dart';
enum EmailSignInFormType { signIn, register }
class SignInWithEmailModel{
  SignInWithEmailModel({
    this.email = " ",
    this.password = " ",
    this.isLoading = false,
    this.formType = EmailSignInFormType.signIn,
    this.submitted = false,
  });
  final String email;
  final String password;
  final bool isLoading;
  final EmailSignInFormType formType;
  final bool submitted;
}