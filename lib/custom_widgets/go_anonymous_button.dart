import 'package:flutter/material.dart';
class SignInAnonymously extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(6),
        shape: MaterialStateProperty.all(StadiumBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
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
