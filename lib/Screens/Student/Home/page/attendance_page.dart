import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StudentScan extends StatefulWidget {
  final String studentuid;
  final Map user;

  const StudentScan({Key key, this.studentuid, this.user}) : super(key: key);
  @override
  _StudentScanState createState() => _StudentScanState();
}

class _StudentScanState extends State<StudentScan> {
  String student;
  double height, width;
  String qrString = "Not Scanned";

  @override
  Widget build(BuildContext context) {
    student = widget.studentuid;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("Hello  ${widget.studentuid}");
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user['FullName']}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            qrString,
            style: TextStyle(color: Colors.blue, fontSize: 30),
          ),
          ElevatedButton(
            onPressed: scanQR,
            child: Text("Scan QR Code"),
          ),
          SizedBox(width: width),
        ],
      ),
    );
  }

  Future <void> scanQR() async {

    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR,)
          .then((qrValue) {
        String courseID = qrValue.substring(0, 19);
            setState(() {
              FirebaseFirestore.instance.collection('CoursesQR').where(
                'CourseID', isEqualTo: courseID)
                  .get()
                  .then((mom) {

                FirebaseFirestore.instance.collection('CoursesQR').where(
                  'Validated', isEqualTo: 'True'
                ).get().then((value) {
                  FirebaseFirestore.instance.collection('AttendanceDetail').doc().set(
                      {
                        'AttendanceTime': DateTime.now(),
                        'AttendanceID': widget.studentuid,
                        'AttendanceName': widget.user['FullName'],
                        'AttendanceCourseID': courseID,
                        'QRValue': qrValue,
                      });
                });
              });
            });
      });
      qrString = 'Attended Successfully';
    } catch (e) {
      setState(() {
        qrString = "Unable to read the QR";
      });
    }

  }
}