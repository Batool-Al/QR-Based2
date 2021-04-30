
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Teacher/Home/TeacherProfile/TeacherProfile.dart';
import 'ScanGenerate/Screens/DisplayCourses.dart';


class TeacherHomePage extends StatefulWidget {
  final String contactKey;
  final Map user;
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState();
  const TeacherHomePage({Key key, this.contactKey, this.user, }) : super(key: key);

}

class _TeacherHomePageState extends State<TeacherHomePage> {

  @override
  Widget build(BuildContext context) =>
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Hello ${widget.user['FullName']}", style: TextStyle(fontSize: 20),),
            //centerTitle: true,
            actions: [

            ],
            //backgroundColor: Colors.purple,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo[400], Colors.indigo[500]],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            bottom: TabBar(
              //isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: [
                Tab(icon: Icon(Icons.menu_book_outlined), text:  'Courses'),
                Tab(icon: Icon(Icons.face), text: 'Profile'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [

              buildPage1(
                  Scaffold(
                    body: TeacherCourses(),
                  )
              ),

              buildPage2(
               Scaffold(
                 body: TeacherProfile(user: widget.user, contactKey: widget.contactKey),
               )
              ),
            ],
          ),
        ),
      );


  Widget buildPage1(Scaffold scaffold) =>
  Scaffold(
    body: scaffold,
  );
  Widget buildPage2(Scaffold scafold) =>
      Scaffold(
        body: scafold,
      );
}

