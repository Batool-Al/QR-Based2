import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Signup/components/or_divider.dart';
import 'package:qr_based_attendance_system/Screens/logInScreen/components/body.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../logInScreen/login_screen2.dart';




class TeacherSignup extends StatefulWidget {
  TeacherSignup({this.app});
  final FirebaseApp app;

  @override
  _TeacherSignupState createState() => _TeacherSignupState();
}

class _TeacherSignupState extends State<TeacherSignup> {
  // SignUP
  Future<bool> _createUser() async {
    bool completed=false;
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text))
          .user;
      await FirebaseFirestore.instance
          .collection('UsersAccounts')
          .doc(user.uid)
          .set({
        "Email": emailController.text,
        "FullName": fullNameController.text,
        "UserID": user.uid,
        "Role": "Teacher",
        "AccountCreatedDate": DateTime.now(),
        "AlternativeID":idController.text
      }).then((value) {
        completed=true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LogInPage();
            },
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      print("error $e.");
      showInSnackBar(e.message,Colors.red,3);
    } catch (e) {
      print("error $e");
    }
    return completed;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final listOfMajors = ["ITC", "Business", "English"];
  String dropdownValue = 'ITC';

  @override
  void initState() {

    super.initState();
  }


  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final idController = TextEditingController();
  final fullNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Clear Method

  void clearTextInput(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    idController.clear();
    fullNameController.clear();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            /// First Name and Second Name
            Row(
              children: [
                SizedBox(width: 36,),
                Container(
                  height: size.height * 0.08,
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[500].withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    controller: fullNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.perm_identity, color: Colors.white, size: 20,),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Valid Name';
                      }
                      return null;
                    },
                  ),
                ),

              ],
            ),
            SizedBox(height: 6,),
            /// ID
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: idController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.perm_identity, color: Colors.white, size: 20,),
                    hintText: "User ID",
                    hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                ),
                // The validator receives the text that the user has entered.
                validator: (value) => value.isEmpty ? 'Enter Valid ID' : null,
              ),
            ),
            SizedBox(height: 6,),
            /// Email
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.white, size: 20,),
                    hintText: "Enter Email",
                    hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                ),
                // The validator receives the text that the user has entered.
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Email is Required';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid email Address';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 6,),
            /// Password
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: passwordController,
                autocorrect: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (_password) => _password.length <6 ? 'Please Enter Valid Password' : null,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white, size: 20,) ,
                    hintText: "Enter Password",
                    hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                ),
                // The validator receives the text that the user has entered.
              ),
            ),
            SizedBox(height:6),
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white, size: 20,) ,
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                ),
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return 'Confirming password is Required';
                  }
                  print(passwordController.text);
                  print(confirmPasswordController.text);
                  if (value != passwordController.value.text) {
                    return 'Passwords do not match!';
                  }
                  return null;
                },

              ),
            ),
            SizedBox(height: size.height * 0.02,),
            // Button
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  color: Colors.indigo[400],
                  onPressed: () {
                    validator();
                  },
                  child: Text(
                    "SIGNUP",
                    style: TextStyle(color: Colors.white ,fontFamily: "NotoSerif-Bold"),
                  ),
                ),
              ),
            ),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return login_screen2();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
          ],
        ),
      ),
    );
  }

  Future <bool> validator()async{
    bool validated=false;
    if(emailController.text==null||emailController.text.contains('@')==false){
      showInSnackBar('Email is Invalid', Colors.red, 2);
    }else if(passwordController.text.length<8){
      showInSnackBar('Password is Invalid', Colors.red, 2);
    }else{
      validated=true;
      _createUser();
    }
    return validated;
  }

  void showInSnackBar(String value, Color color, int duration) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    )
    );
  }
  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
  }
}

