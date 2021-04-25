import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../logInScreen/login_screen2.dart';


class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => new _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return  SplashScreen(
      backgroundColor: Color(0xFFE8EAF6),
      seconds:4,
      image: Image.asset('assets/images/animation_500_kl9sufq2.gif'),
      photoSize: 250,
      useLoader: true,
      loadingText: Text(
        '   ATS\nSystem', style: TextStyle(
          color: Colors.indigo[500], fontFamily: 'NotoSerif-Bold',fontSize: 40,
          shadows: [
            Shadow(
              offset: Offset(4.0,1.0),
              color: Colors.grey,
              blurRadius: 0.0,
            )]
      ),
      ),
      loaderColor: Colors.red[300] ,
      navigateAfterSeconds: login_screen2(),
    );
  }
}

