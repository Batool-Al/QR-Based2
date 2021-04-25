import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'createqr.dart';

class TeacherCourses extends StatefulWidget {
  @override
  _TeacherCoursesState createState() => _TeacherCoursesState();
}

class _TeacherCoursesState extends State<TeacherCourses> {


  @override
  void initState() {
    super.initState();
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
                                  print(contact.id);
                                  return CreateScreen(contactKey: contact.id, contactInfo: contact.data());
                                }),);},
                            child: Row(
                              children: [
                                Icon(Icons.qr_code,
                                  color: Theme.of(context).primaryColor,),
                                SizedBox(width: 6,),
                                Text("Generate QR",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,),)
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),

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
