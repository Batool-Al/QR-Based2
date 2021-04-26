import 'package:flutter/material.dart';


class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? " ,
          style: TextStyle(color: Colors.blueGrey[500], fontFamily: "NotoSerif-Bold", fontSize: 15),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "SignUp" : "SignIn",
            style: TextStyle(
              color: Colors.pink[400],
              fontWeight: FontWeight.bold,
              fontSize: 14, fontFamily: "NotoSerif-Bold",
            ),
          ),
        ),
        SizedBox(height: 30)
      ],
    );
  }
}