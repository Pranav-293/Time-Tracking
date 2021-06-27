
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/pages/login_with_email_page.dart';
import 'package:time_tracker/services/auth.dart';
import 'package:time_tracker/sign_in/sign_in_bloc.dart';

class MySignInPage extends StatelessWidget {
  const MySignInPage({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context){
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_)=>SignInBloc(auth),
      dispose: (_,bloc)=>bloc.dispose(),
      child: Consumer<SignInBloc>(
      builder: (_,bloc,__)=>MySignInPage(bloc: bloc),
      ),
    );
  }

  //A function for Signing In Anonymously

  Future<void> signInAnonymously() async {
    try {
      await bloc.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      await bloc.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      await bloc.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapshot) {
          bool isLoading = snapshot.data;
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end:Alignment.bottomCenter,
                  begin:Alignment.topCenter,
                  colors: [
                    Colors.black26,
                    Colors.black38,
                    Colors.black45,
                    Colors.black87,
                  ]
                )
              ),
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    child: (isLoading)?CircularProgressIndicator():Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                  ),

                  SizedBox(
                    height: 50,
                  ),

                  //Sign In using google
                  ElevatedButton(
                    onPressed:()=> (isLoading)?null:signInWithGoogle(),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image(
                            image: AssetImage(
                              "assets/images/g-logo.png",
                            ),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Text(
                          "Sign In with Google",
                          style: (TextStyle(
                            color: Colors.black,
                          )),
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image(
                              image: AssetImage(
                                "assets/images/g-logo.png",
                              ),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),

                  //Sign In using facebook
                  ElevatedButton(
                    onPressed:()=>(isLoading)?null: signInWithFacebook(),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(Color(0xff3b5998)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image(
                            image: AssetImage(
                              "assets/images/facbook-logo.jpg",
                            ),
                            isAntiAlias: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "Sign In with Facebook",
                          style: (TextStyle(
                            color: Colors.white,
                          )),
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image(
                              image: AssetImage(
                                "assets/images/facbook-logo.jpg",
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),

                  //Sign In using Email
                  ElevatedButton(onPressed:(!isLoading)?(){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder:(context)=>LoginWithEmail(),fullscreenDialog: true)
                      );
                  }:null,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(Colors.teal[200]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child:Icon(
                              Icons.keyboard,
                              color: Colors.black,
                            )
                        ),
                        Text(
                          "Sign In with Email",
                          style: (
                              TextStyle(
                                color: Colors.black,
                              )
                          ),
                        ),
                        Opacity(
                          opacity: 0.0,
                          child:  SizedBox(
                              height: 30,
                              width: 30,
                              child:Icon(
                                Icons.keyboard,
                                color: Colors.black,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 22,
                  ),

                  Text("or"),

                  SizedBox(
                    height: 22,
                  ),

                  //Sign In Anonymously
                  ElevatedButton(
                    onPressed:()=>(isLoading)?null: signInAnonymously(),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(6),
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(Colors.yellow[50]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              "Go Anonymous",
                              style: (TextStyle(
                                color: Colors.black,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
