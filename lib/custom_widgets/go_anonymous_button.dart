import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignInAnonymously extends StatelessWidget {
  Future<void> signInAnonymously() async {
    try{
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("${userCredential.user.uid}");
    }
   catch(e){
      print(e.toString());
   }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: signInAnonymously,
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
                style: (
                    TextStyle(
                      color: Colors.black,
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
