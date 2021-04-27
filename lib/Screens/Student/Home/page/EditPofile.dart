import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String studentID;
  EditProfile({this.studentID});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController, _emailController;

  @override
  void initState() {

    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();

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
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
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

    await FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.studentID).update({
      'FullName': _nameController.text,
      'Email':  _emailController,

    }).then((value) {
      print('Done');
    });
  }

}