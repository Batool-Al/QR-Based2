import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Welcome/components/background.dart';
import 'package:qr_based_attendance_system/components/rounded_button.dart';

import 'package:lottie/lottie.dart';
import '../../../constants.dart';
import '../../../constants.dart';
import '../../Student/Signup/components/body.dart';
import '../../Teacher/TeacherSignUp/components/body.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 45 ,),
          Container(
            width: 350,
            child: Lottie.asset('assets/images/5.json'),
          ),
          SizedBox(height: 30,),
          Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: 30),
              child:
              Text("Choose what you are: ", style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontFamily: "NotoSerif-Bold" ),
              )
          ),
          SizedBox(height: 25,),
          RoundedButton(
            text: "Teacher",
            color: kPrimaryColorButton,
            textColor: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TeacherSignup();
                  },
                ),
              );
            },
          ),
          RoundedButton(
            text:"Student",
            color: kPrimaryColorButton,
            textColor: Colors.white,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return StudentSignUp();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}