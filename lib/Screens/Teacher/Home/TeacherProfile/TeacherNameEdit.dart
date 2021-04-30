import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class TeacherNameEdit extends StatefulWidget {
  final String contactKey;
  TeacherNameEdit({this.contactKey});

  @override
  _TeacherNameEditState createState() => _TeacherNameEditState();
}

class _TeacherNameEditState extends State<TeacherNameEdit> {
  TextEditingController _nameController;
  String name;

  @override
  void initState() {

    super.initState();
    _nameController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Info'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  prefixIcon: Icon(
                    Icons.face,
                    size: 30,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                ),
                onChanged: (value){
                  name = value;
                },
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Edit Info',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    saveContact();
                    Navigator.of(context).pop();
                  },
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void saveContact() async{
    await FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.contactKey).update({
      'FullName': name,


    });
  }

}