
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/pages/login_with_email_page.dart';
import 'package:time_tracker/services/auth.dart';

class MySignInPage extends StatefulWidget {

  //A function for Signing In Anonymously
  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
   bool isLoading = false;
  Future<void> signInAnonymously(AuthClass auth) async {
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInWithGoogle(AuthClass auth) async {
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInWithFacebook(AuthClass auth) async {
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithFacebook();
    } catch (e) {
      print(e.toString());
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      body: SafeArea(
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
                onPressed:()=> (isLoading)?null:signInWithGoogle(auth),
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
                onPressed:()=>(isLoading)?null: signInWithFacebook(auth),
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
                onPressed:()=>(isLoading)?null: signInAnonymously(auth),
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
      ),
    );
  }
}
