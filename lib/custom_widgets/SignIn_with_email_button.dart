import 'package:flutter/material.dart';
class SignInEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
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
    );
  }
}
