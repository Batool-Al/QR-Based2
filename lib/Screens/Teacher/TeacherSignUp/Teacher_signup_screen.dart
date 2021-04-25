import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Signup/components/body.dart';
import 'package:qr_based_attendance_system/Screens/Teacher/TeacherSignUp/components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TeacherSignup(),
    );
  }
}