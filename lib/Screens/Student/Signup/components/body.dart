import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Signup/components/or_divider.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../logInScreen/components/body.dart';



class StudentSignUp extends StatefulWidget {
  StudentSignUp({this.app});
  final FirebaseApp app;

  @override
  _StudentSignUpState createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  // SignUP
  TextEditingController email= new TextEditingController();
  TextEditingController password= new TextEditingController();
  bool _showPassword = true;
  var result;


  Future<bool> _createUser() async {
    bool completed=false;
    try {
      result = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text))
          ;
      await FirebaseFirestore.instance
          .collection('UsersAccounts')
          .doc(result.user.uid)
          .set({
        "Email": emailController.text,
        "FullName": fullNameController.text,
        'Major': dropdownValue,
        "UserID": result.user.uid,
        "Role": "Student",
        "AccountCreatedDate":DateTime.now(),
        "AlternativeID":idController.text
      }).then((value) {
        completed=true;
      });
    } on FirebaseAuthException catch (e) {
      print("error $e");
    } catch (e) {
      print("error $e");
    }
    return completed;
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final listOfMajors = ["ITC", "Business", "English"];
  String dropdownValue = 'ITC';

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final idController = TextEditingController();
  final fullNameController = TextEditingController();
  final majorController = TextEditingController();
  final confirmPasswordController=TextEditingController();

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
            /// Full name
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
              ),
            ),
            SizedBox(height: 6,),
            /// Major
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonFormField(
                dropdownColor: Colors.indigo[100],
                icon: Container(
                    padding: EdgeInsets.only(right: 20,),
                    child: Icon(Icons.arrow_downward, color: Colors.white, size: 30,)),
                decoration: InputDecoration(
                  hintText: "Select Your Major",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 17,fontFamily: "NotoSerif-Bold"),
                  border: InputBorder.none,
                ),
                items: listOfMajors.map((major) {
                  return DropdownMenuItem(
                    value: major,
                    child: Container(
                        padding: EdgeInsets.only(left: 15),
                        child:
                        Text('$major', style: TextStyle(color: Colors.white),)),
                  );
                }).toList(),
                onChanged: (String stored){
                  setState((){
                    dropdownValue = stored;
                  });
                },
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
            SizedBox(height: size.height * 0.01,),
            Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[500].withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: _showPassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.white, size: 20,),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.grey : Colors.redAccent,
                      ),
                      onPressed: () {
                        setState(() => this._showPassword = !this._showPassword);
                      },
                    ),
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.white,fontFamily: "NotoSerif-Bold")
                ),

              ),
            ),

            SizedBox(height: size.height * 0.04,),
            // Button
            Container(
               margin: EdgeInsets.symmetric(vertical: 10),
               width: size.width * 0.5,
               child: ClipRRect(
                   borderRadius: BorderRadius.circular(29),
                   child: RaisedButton(
                     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                     color: Colors.indigo[400],
                     onPressed: () {
                       _createUser();
                       validator().then((value) {
                         if(value==true){
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) {
                                 return LogInPage();
                               },
                             ),
                           );
                         }
                       });
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LogInPage();
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

  Future<bool> validator() async {
    bool validated = false;
    if (emailController.text.isEmpty ||
        emailController.text.contains('@') == false) {
      showInSnackBar('Email is Invalid or Empty', Colors.red, 2);
    } else if (passwordController.text.length < 8 ||
        passwordController.text.isEmpty) {
      showInSnackBar('Password is Invalid or Empty', Colors.red, 2);
    } else if (confirmPasswordController.text.isEmpty ||
        passwordController.text != confirmPasswordController.text) {
      showInSnackBar('Passwords do not match!', Colors.red, 2);
    } else if (idController.text.isEmpty ||
        idController.text.length > 9 ||
        idController.text.length < 9) {
      showInSnackBar('ID should not be Empty or Less or Greater than 9',
          Colors.red, 2);
    } else {
      validated = true;
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
        style: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: "NotoSerif-Bold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    ));
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
