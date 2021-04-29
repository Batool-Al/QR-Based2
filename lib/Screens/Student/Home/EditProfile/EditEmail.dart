import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class EditEmail extends StatefulWidget {
  final String studentID;
  EditEmail({this.studentID});

  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  TextEditingController _emailController;
  String  email;

  @override
  void initState() {

    super.initState();
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
                onChanged: (value){
                  email = value;
                },
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
    await FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.studentID).update({
      'Email': email,

    });
  }

}