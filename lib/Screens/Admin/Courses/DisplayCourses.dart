import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'EditCourses.dart';

class Courses extends StatefulWidget {
  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {


  @override
  void initState() {
    super.initState();
  }

  _showDeleteDialog(DocumentSnapshot course) {
    showDialog(
        context: context,
        builder: (context) {

          return AlertDialog(
            title: Text('Delete ${course["Course"]}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('Courses')
                        .doc(course.id)
                        .delete().then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Delete"))
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: null,
      body: Container(
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children:
              snapshot.data.docs.map((contact)
              {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
                height: 130,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.code,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          contact["Course"],
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
                          color: Theme.of(context).accentColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          contact["Major"],
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){

                            Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                                return EditCourses( contactKey: contact);
                              }),);},
                          child: Row(
                            children: [
                              Icon(Icons.edit,
                                color: Theme.of(context).primaryColor,),
                              SizedBox(width: 6,),
                              Text("Edit",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w600,),)
                            ],
                          ),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            print(contact.id);
                            _showDeleteDialog(contact);
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red[700],
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text("Delete",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )

                  ],
                ),
              );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
