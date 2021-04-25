import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddCourses extends StatefulWidget {
  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {

  TextEditingController _courseController, _majorController;

  CollectionReference _ref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _courseController = TextEditingController();
    _majorController = TextEditingController();
    _ref = FirebaseFirestore.instance.collection('Courses');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Course'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _courseController,
              decoration: InputDecoration(
                hintText: 'Course Code',
                prefixIcon: Icon(
                  Icons.code,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _majorController,
              decoration: InputDecoration(
                hintText: 'Major',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),

            SizedBox(height: 25,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton(child: Text('Save Course',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),),
                onPressed: (){
                  saveContact();
                },
                color: Theme.of(context).primaryColor,
              ),
            )

          ],
        ),
      ),
    );
  }
  void saveContact(){

    Map<String,String> contact = {

      'Course': _courseController.text,
      'Major':  _majorController.text,

    };

    _ref.doc().set({
      'Course': _courseController.text,
      'Major':  _majorController.text,
    }).then((_) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Successfully Added')));
      _courseController.clear();
      _majorController.clear();
    }).catchError((onError) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(onError)));
    }).asStream();


    Navigator.pop(context);
  }
}
