import 'package:flutter/material.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class LoginWithEmail extends StatefulWidget {
  LoginWithEmail({this.context, this.auth});
  final BuildContext context;
  final AuthClass auth;

  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  String get _email => _emailEditingController.text;
  String get _password => _passwordEditingController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit()async{
    try {
      (_formType==EmailSignInFormType.signIn)? await widget.auth.signInWithEmail(_email, _password):
        await  widget.auth.createAccountWithEmail(_email, _password);
     Navigator.of(context).pop();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType() {
    (_formType == EmailSignInFormType.signIn)
        ? _formType = EmailSignInFormType.register
        : _formType = EmailSignInFormType.signIn;
    _emailEditingController.clear();
    _passwordEditingController.clear();
    setState(() {
    });
  }

  List<Widget> _loginFormListItems() {
    final _primaryText = (_formType == EmailSignInFormType.signIn)
        ? "Sign In"
        : "Create Account";
    final _secondryText = (_formType == EmailSignInFormType.signIn)
        ? "Need an account? Create one"
        : "Have an account? Sign in";
    return [
      TextFormField(
        controller: _emailEditingController,
        decoration:
            InputDecoration(labelText: "Email", hintText: "test@test.com"),
        textInputAction: TextInputAction.next,
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        controller: _passwordEditingController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        onEditingComplete: _submit,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "password",
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 40,
      ),

//Submit button
      ElevatedButton(
        onPressed: _submit,
        child: Text(_primaryText),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
      SizedBox(
        height: 8,
      ),

// changing form type button
      TextButton(
          onPressed: _toggleFormType,
          child: Text(
            _secondryText,
          ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign in",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Card(
            elevation: 12,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _loginFormListItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
