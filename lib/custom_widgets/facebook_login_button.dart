import 'package:flutter/material.dart';
class LoginFacebook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){},
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(12),
        shape: MaterialStateProperty.all(StadiumBorder()),
        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
        backgroundColor: MaterialStateProperty.all(Color(0xff3b5998)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image(image: AssetImage(
              "assets/images/facbook-logo.jpg",
            ),
              fit: BoxFit.fill,),
          ),
          Text(
            "Login with Facebook",
            style: (
                TextStyle(
                  color: Colors.white,
                )
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: SizedBox(
              height: 30,
              width: 30,
              child: Image(image: AssetImage(
                "assets/images/facbook-logo.jpg",
              ),
                fit: BoxFit.fill,),
            ),
          ),
        ],
      ),
    );
  }
}
