import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Welcome/welcome_screen.dart';
import 'package:qr_based_attendance_system/components/already_have_an_account_acheck.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Admin/Home/appbar.dart';
import '../../Student/Home/home_screen.dart';
import '../../Student/Signup/components/background.dart';
import '../../Teacher/Home/home_screen.dart';
import 'forgotpassword.dart';


class LogInPage extends StatefulWidget {
  LogInPage({
    Key key,
  }) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _showPassword = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                height: 290,
                width: 290,
                child: Lottie.asset('assets/images/2.json'),
              ),
              //Email
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
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      hintText: "Enter Your Email",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "NotoSerif-Bold")),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              //Password
              Container(
                height: size.height * 0.08,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey[500].withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: _showPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword ? Colors.grey : Colors.redAccent,
                        ),
                        onPressed: () {
                          setState(() => this._showPassword = !this._showPassword);
                        },
                      ),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(
                          color: Colors.white, fontFamily: "NotoSerif-Bold")),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.pink[100],
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white, fontFamily: "NotoSerif-Bold"),
                    ),
                    onPressed: () {
                      validator().then((value) {
                        if(value==true){
                          signIn();
                        }
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top:15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Forgot your password?",
                      style: TextStyle(fontFamily: "NotoSerif-Bold" ,fontSize: 14, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPassword()));
                      },
                      child: Text(
                        "Recover",
                        style: TextStyle(
                            fontFamily: "NotoSerif-Bold", color: Colors.pink[400]),
                      ),
                    )
                  ],
                ),
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future <bool> validator()async{
    bool validated=false;
    if (emailController.text.isEmpty ||
        emailController.text.contains('@') == false) {
      showInSnackBar('Email is Invalid or Empty', Colors.red[300], 2);
    } else if (passwordController.text.length < 8 ||
        passwordController.text.isEmpty) {
      showInSnackBar('Password is Invalid or Empty', Colors.red[300], 2);
    }else{
      validated=true;
    }
    return validated;
  }

  Future signIn() async {
      try {
        final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        print(result.user.uid);
        String contactKey = result.user.uid;
        await FirebaseFirestore.instance
            .collection('UsersAccounts')
            .doc(result.user.uid)
            .get()
            .then((value) {
              Map user = value.data();
          print("mnxmcnvxcmn ${value.data()['Role']}");
          switch (value.data()['Role']) {
            case 'Admin':
              {
                print('.... Login As Admin');
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminHomePage(contactKey: contactKey)));
              }break;
            case 'Student':
              {
                print('.... Login As Student');
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentHomePage(contactKey: contactKey, user: user)));
              }break;
            case 'Teacher':
              {
                print('.... Login As Teacher');
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherHomePage(contactKey: contactKey, user: user)));
              }break;
          }
        });
      } on FirebaseAuthException {
      showInSnackBar('Please Enter Valid Email And Password', Colors.red, 2);
      } catch (e) {
        print("error $e");
        showInSnackBar('Please Enter Valid Email And Password', Colors.red, 2);
      }
  }
  void showInSnackBar(String value, Color color, int duration) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "NotoSerif-Bold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    )
    );
  }
}
