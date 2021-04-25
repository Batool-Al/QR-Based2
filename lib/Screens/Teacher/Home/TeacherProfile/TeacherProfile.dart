import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TeacherProfile extends StatefulWidget {
  final Map user;
  final String contactKey;

  const TeacherProfile({Key key, this.user, this.contactKey}) : super(key: key);
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.contactKey).get;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: null,
      body: Container(
        height: double.infinity,
        child: FutureBuilder(
          future: userData(),
          builder: (context, snapshot){
            if ( snapshot.connectionState == ConnectionState.done){

              return ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 80),
                    height: 200,
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
                          height: 15,
                        ),
                      ],),),
                ],
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
