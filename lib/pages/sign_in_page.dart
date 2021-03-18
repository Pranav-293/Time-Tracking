import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignInPage extends StatelessWidget {
  const MySignInPage({Key key, @required this.onSignIn}) : super(key: key);

  //A callback when user click on sign in button
  final void Function(User) onSignIn;

  //A function for Signing In Anonymously
  Future<void> signInAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Welcome",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Sign In",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(
              height: 50,
            ),

            //Sign In using google
            ElevatedButton(
              onPressed: () {},
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
              onPressed: () {},
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
            ElevatedButton(onPressed: (){},
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
              onPressed: signInAnonymously,
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
}