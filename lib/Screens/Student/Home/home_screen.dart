import 'package:flutter/material.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/page/ViewAttendance.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/page/Scanning_Page.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/page/Profile_page.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/page/course_page.dart';
import 'package:qr_based_attendance_system/Screens/Student/Home/widget/tabbar_material_widget.dart';
import 'package:qr_based_attendance_system/Screens/Student/ImagePicker/AddExcuse.dart';

class StudentHomePage extends StatefulWidget {
  final Map user;
  final String contactKey;

  const StudentHomePage({@required this.contactKey, this.user});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int index = 0;


  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ViewAttendance(studentuid: widget.contactKey, user: widget.user),
      StudentScan(studentuid: widget.contactKey, user: widget.user),
      CoursesPage(studentuid: widget.contactKey, user: widget.user),
      ProfilePage(studentuid: widget.contactKey),
    ];
    return Scaffold(
      extendBody: true,
      body: pages[index],
      bottomNavigationBar: TabBarMaterialWidget(
        index: index,
        onChangedTab: onChangedTab,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.menu_book_outlined),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExcuse()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
