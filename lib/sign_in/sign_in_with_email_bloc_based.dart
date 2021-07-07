import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/sign_in/sign_in_with_email_bloc.dart';
import 'package:time_tracker/sign_in/sign_in_with_email_model.dart';


class SignInWithEmailBlocBased extends StatefulWidget {
  SignInWithEmailBlocBased({@required this.bloc});
  final SignInWithEmailBloc bloc;

  static Widget create(BuildContext context){
    final auth = Provider.of<AuthBase>(context,listen: false);
    return Provider<SignInWithEmailBloc>(
      create: (_) => SignInWithEmailBloc(auth: auth),
      child: Consumer<SignInWithEmailBloc>(
        builder: (_,bloc,__) => SignInWithEmailBlocBased(bloc: bloc),
      ),
      dispose: (_,bloc) =>bloc.dispose(),
    );
  }

  @override
  _SignInWithEmailBlocBasedState createState() => _SignInWithEmailBlocBasedState();
}
class _SignInWithEmailBlocBasedState extends State<SignInWithEmailBlocBased> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
  TextEditingController();

  Future<void> _submit( SignInWithEmailModel model,AuthBase auth) async {
      try {
         widget.bloc.submit();
         setState(() {
           Navigator.of(context).pop();
         });
      }catch (e) {
        print("hello pranav");
        showCupertinoDialog(context: this.context, builder: (context)=>CupertinoAlertDialog(
          title: Text("Sign in failed"),
          content: Text((model.formType==EmailSignInFormType.signIn)?"Invalid Email or Password"
              :e.toString()),
          actions: [
            TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
          ],
        ));
        print(e.toString());
      }
    }

  void _toggleFormType( SignInWithEmailModel model) {
    widget.bloc.updateWith(formType: (model.formType == EmailSignInFormType.signIn)
        ?EmailSignInFormType.register
        : EmailSignInFormType.signIn,
      email: "",
      password: "",
      submitted: false,
      isLoading: false,
    );
    _emailEditingController.clear();
    _passwordEditingController.clear();
  }

  void showError(){
    showCupertinoDialog(context: context, builder: (context)=>CupertinoAlertDialog(
      title: Text("Sign in failed"),
      content: Text("Email or Password cannot be empty"),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
      ],
    ));
  }
  List<Widget> _loginFormListItems(SignInWithEmailModel model) {
    final _primaryText = (model.formType == EmailSignInFormType.signIn)
        ? "Sign In"
        : "Create Account";
    final _secondryText = (model.formType == EmailSignInFormType.signIn)
        ? "Need an account? Create one"
        : "Have an account? Sign in";
    return [
      TextFormField(
        controller: _emailEditingController,
        onChanged: (email)=>widget.bloc.updateWith(email: email),
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
        onEditingComplete:()=>_submit(model, widget.bloc.auth),
        onChanged:(password)=> widget.bloc.updateWith(password: password),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: "password",
        ),
        obscureText: true,
        validator: (value){
          if(value.isEmpty || value ==null){
            return "Password cannot be empty";
          }else if(model.formType==EmailSignInFormType.register && value.length<6){
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
        onPressed:()=>(_emailEditingController.text.isEmpty || _passwordEditingController.text.isEmpty) ? showError() : _submit(model,widget.bloc
        .auth),
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
          onPressed:()=> _toggleFormType(model),
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
    return StreamBuilder<SignInWithEmailModel>(
      stream: widget.bloc.emailModelStream,
      initialData: SignInWithEmailModel(),
      builder: (context, snapshot) {
        SignInWithEmailModel model = snapshot.data;
        return AbsorbPointer(
            absorbing: model.isLoading,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _loginFormListItems(model),
              ),
            ),
          );
      }
    );
  }
  @override
  void dispose() {
    super.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
  }
}
