import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditCourses extends StatefulWidget {
  final DocumentSnapshot contactKey;
  EditCourses({this.contactKey});

  @override
  _EditCoursesState createState() => _EditCoursesState();
}

class _EditCoursesState extends State<EditCourses> {
  TextEditingController
  _courseController, _majorController;



  @override
  void initState() {

    super.initState();
    _courseController = TextEditingController();
    _majorController = TextEditingController();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Course'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _courseController,
              decoration: InputDecoration(
                hintText: 'Enter Course',
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
                hintText: 'Enter Major',
                prefixIcon: Icon(
                  Icons.phone_iphone,
                  size: 30,
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                child: Text(
                  'Update Course',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
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
  void saveContact() async{
    String name = _courseController.text;
    String number = _majorController.text;
    await FirebaseFirestore.instance.collection('Courses').doc(widget.contactKey.id).update({
      'Course': name,
      'Major':  number,
    }).then((value) {
      print('Done');
    });
  }

}