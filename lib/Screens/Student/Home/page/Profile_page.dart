import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/EditProfile/EditEmail.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/EditProfile/EditName.dart';
import 'package:qr_based_attendance_system/Screens/logInScreen/components/body.dart';

class ProfilePage extends StatefulWidget {
  final String studentuid;

  const ProfilePage({Key key, this.studentuid}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var userData = FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.studentuid).get;

    return Scaffold(
      floatingActionButton: null,
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: FutureBuilder(
        future: userData(),
        builder: (context, snapshot){
          if ( snapshot.connectionState == ConnectionState.done){
            return Container(
              height: double.infinity,
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.drive_file_rename_outline,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Name: ${snapshot.data["FullName"]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 160,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return EditName( studentID: widget.studentuid,);
                                      }),);},
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit,
                                        color: Theme.of(context).primaryColor,),
                                      SizedBox(width: 6,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.card_travel,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Email: ${snapshot.data["Email"]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 120,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: (){

                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return EditEmail( studentID: widget.studentuid,);
                                      }),);},
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit,
                                        color: Theme.of(context).primaryColor,),
                                      SizedBox(width: 6,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        color: Colors.white,
                        child: Row(

                          children: [
                            Icon(
                              Icons.credit_card_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'ID: ${snapshot.data["AlternativeID"]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 60,
                        color: Colors.white,
                        child: Row(

                          children: [
                            Icon(
                              Icons.credit_card_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Major: ${snapshot.data["Major"]}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 7),
                        width: size.width * 0.4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: Colors.indigo[400],
                            onPressed: () {
                              _signout();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "SignOut",
                              style: TextStyle(color: Colors.white ,fontFamily: "NotoSerif-Bold"),
                            ),
                          ),
                        ),
                      ),
                      ],),
                ],
              ),
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future _signout()async{
    await FirebaseAuth.instance.signOut();
    return LogInPage();
  }
}
