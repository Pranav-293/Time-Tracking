
enum EmailSignInFormType { signIn, register }

class SignInWithEmailModel {
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

  SignInWithEmailModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return SignInWithEmailModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
