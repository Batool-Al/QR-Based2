import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/page/EditPofile.dart';

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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 100),
                    height: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Row(

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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
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
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(

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
                        SizedBox(
                          height: 10,
                        ),
                        Row(

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
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 7),
                          width: size.width * 0.4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              color: Colors.indigo[400],
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return EditProfile(studentID: widget.studentuid,);
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.white ,fontFamily: "NotoSerif-Bold"),
                              ),
                            ),
                          ),
                        ),
                        ],),),
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
}
