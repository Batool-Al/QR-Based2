import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'attendance_page.dart';

class ViewAttendance extends StatefulWidget {
  final String studentuid;
  final Map user;

  const ViewAttendance({Key key, this.studentuid, this.user}) : super(key: key);

  @override
  _ViewAttendanceState createState() => _ViewAttendanceState();

}

class _ViewAttendanceState extends State<ViewAttendance> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        
      ),
        floatingActionButton: null,
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('AttendanceDetail').snapshots(),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children:
              snapshot.data.docs.map((contact)
              { if(contact['AttendanceID'] == widget.studentuid){
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  height: 100,
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
                            contact["AttendanceName"],
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
                            contact["AttendanceCourseID"],
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),


                    ],
                  ),
                );
              }

              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
