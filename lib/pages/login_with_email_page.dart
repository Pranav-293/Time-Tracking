import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType { signIn, register }

class LoginWithEmail extends StatefulWidget {
  @override
  _LoginWithEmailState createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool inDelay = false;
  String get _email => _emailEditingController.text;

  String get _password => _passwordEditingController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    final auth = Provider.of<AuthClass>(context, listen:false);
    if(_formKey.currentState.validate()){
      setState(() {
        inDelay = true;
      });
      try {
        (_formType == EmailSignInFormType.signIn)
            ? await auth.signInWithEmail(_email, _password) : await auth.createAccountWithEmail(_email, _password);
        if (auth.currentUser != null) {
          Navigator.of(context).pop();
        }
      }catch (e) {
        showCupertinoDialog(context: context, builder: (context)=>CupertinoAlertDialog(
          title: Text("Sign in failed"),
          content: Text((_formType==EmailSignInFormType.signIn)?"Invalid Email or Password"
          :e.toString()),
          actions: [
            TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
          ],
        ));
        print(e.toString());
      }finally{
        setState(() {
          inDelay = false;
        });
      }
    }

  }

  void _toggleFormType() {
    (_formType == EmailSignInFormType.signIn)
        ? _formType = EmailSignInFormType.register
        : _formType = EmailSignInFormType.signIn;
    _emailEditingController.clear();
    _passwordEditingController.clear();
    setState(() {});
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
        onChanged: (string){setState(() {
        });},
        decoration:
            InputDecoration(labelText: "Email", hintText: "test@test.com"),
        textInputAction: TextInputAction.next,
        validator: (value){
          if(value.isEmpty|| value ==null){
            return "Email cannot be empty";
          }else{
            return null;
          }
        },
      ),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        controller: _passwordEditingController,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        onEditingComplete:_submit,
        onChanged: (string){setState(() {
        });},
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "password",
        ),
        obscureText: true,
        validator: (value){
          if(value.isEmpty || value ==null){
            return "Password cannot be empty";
          }else if(_formType==EmailSignInFormType.register && value.length<6){
            return "Password should not be less than 6 digits";
          }
          else{
            return null;
          }
        },
      ),
      SizedBox(
        height: 40,
      ),

//Submit button
      ElevatedButton(
        onPressed:(_emailEditingController.text.isEmpty || _passwordEditingController.text.isEmpty) ? null : _submit,
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
          )),
      SizedBox(
        height: 12,
      ),
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
      body: AbsorbPointer(
        absorbing: inDelay,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
