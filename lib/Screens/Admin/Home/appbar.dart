
import 'package:qr_based_attendance_system/Screens/Admin/Courses/AddCourses.dart';
import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Admin/Courses/DisplayCourses.dart';
import 'package:qr_based_attendance_system/Screens/Admin/VeiwExcuses/UploadExcuses.dart';


class AdminHomePage extends StatefulWidget {
  final String contactKey;
  @override
  _AdminHomePageState createState() => _AdminHomePageState();

  const AdminHomePage({Key key, this.contactKey, }) : super(key: key);

}

class _AdminHomePageState extends State<AdminHomePage> {


  @override
  Widget build(BuildContext context) =>
      DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Welcome Back", style: TextStyle(fontSize: 15),),
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
                Tab(icon: Icon(Icons.group_add_outlined), text: 'Teachers',),
                Tab(icon: Icon(Icons.menu_book_outlined), text:  'Courses'),
                Tab(icon: Icon(Icons.message_outlined), text: 'Excuses'),
                Tab(icon: Icon(Icons.face), text: 'Profile'),
              ],
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: TabBarView(
            children: [
              buildPage("Hello"),
              buildPage2(
                  Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed:  () {
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) => AddCourses())
                        );
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: BeveledRectangleBorder (borderRadius: BorderRadius.all(Radius.circular(18.0))),
                    ),
                    body: Courses(),
                  )
              ),
              buildPage3(
                Scaffold(
                  body: MainPage1(),
                )),
              buildPage4(
                Scaffold(
                  body: Container(),
                )
              ),
            ],
          ),
        ),
      );

  Widget buildPage(String text) =>
      Column(
        children: [
          Container(
            child: Text(text),
          ),
          Container(
            color: Colors.pink,
            margin: EdgeInsets.all(20),
          )
        ],
      );
  Widget buildPage2(Scaffold scaffold) =>
      Scaffold(
        body: scaffold,
      );
  Widget buildPage3(Scaffold scaffold) =>
      Scaffold(
        body: scaffold,
      );
  Widget buildPage4(Scaffold scaffold) =>
      Scaffold(
        body: scaffold,
      );
}

