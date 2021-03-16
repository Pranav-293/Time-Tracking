import 'package:flutter/material.dart';
class LoginGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(12),
        shape: MaterialStateProperty.all(StadiumBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image(image: AssetImage(
              "assets/images/g-logo.png",
            ),
              fit: BoxFit.scaleDown,),
          ),
          Text(
            "Login with Google",
            style: (
                TextStyle(
                  color: Colors.black,
                )
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image(image: AssetImage(
                "assets/images/g-logo.png",
              ),
                fit: BoxFit.scaleDown,),
            ),
          ),
        ],
      ),
    );
  }
}
