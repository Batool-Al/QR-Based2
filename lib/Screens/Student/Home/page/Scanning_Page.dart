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
  Color qrStringColor = Colors.blue;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    student = widget.studentuid;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("Hello  ${widget.studentuid}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("${widget.user['FullName']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                qrString,
                style: TextStyle(
                    color: qrStringColor, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: scanQR,
              child: Text("Scan QR Code"),
            ),
            SizedBox(width: width),
          ],
        ),
      ),
    );
  }

  Future <void> scanQR() async {

    try {
      FlutterBarcodeScanner.scanBarcode("#2A99CF", "Cancel", true, ScanMode.QR,)
          .then((qrValue) async {
              if(qrValue.length>20){
                String courseID = qrValue.substring(0, 20);
                await FirebaseFirestore.instance.collection('CoursesQR')
                    .where('QRValue', isEqualTo: qrValue)
                    .get()
                    .then((courseData) async{
                  if(courseData.docs.isNotEmpty==true){
                    // Checking if already scanned
                    if(courseData.docs[0].data()['Validated']==true){
                      await FirebaseFirestore.instance.collection('AttendanceDetail')
                          .where('AttendanceCourseID',isEqualTo: courseID)
                          .where('QRValue',isEqualTo: qrValue)
                          .where('AttendanceID',isEqualTo: widget.studentuid).get().then((value) async{
                        if (value.docs.isEmpty==true){
                          FirebaseFirestore.instance.collection('AttendanceDetail').doc().set(
                              {
                                'AttendanceTime': DateTime.now(),
                                'AttendanceID': widget.studentuid,
                                'AttendanceName': widget.user['FullName'],
                                'AttendanceCourseID': courseID,
                                'QRValue': qrValue,
                              }).then((value) {
                            setState(() {
                              qrString = 'Attended successfully.';
                              qrStringColor=Colors.green;
                            });
                            showInSnackBar('Attended successfully .',Colors.green ,2);
                          });
                        }else{
                          setState(() {
                            qrString = 'Already attended this session.';
                            qrStringColor=Colors.red;
                          });
                          showInSnackBar('Already attended this session.',Colors.red ,2);
                        }
                      });
                    }else{
                      setState(() {
                        qrString = 'QR Expired, Ask the tutor for the new one.';
                        qrStringColor=Colors.red;
                      });
                      showInSnackBar('QR Expired, Ask the tutor for the new one.',Colors.red ,2);
                    }
                  }else{
                    setState(() {
                      qrString = 'QR is invalid';
                      qrStringColor=Colors.red;
                    });
                    showInSnackBar('QR is invalid',Colors.red ,2);
                  }
                });
              }else{
                setState(() {
                  qrString = 'QR is invalid';
                  qrStringColor=Colors.red;
                });
                showInSnackBar('QR is invalid',Colors.red ,2);
              }
            });
    } catch (e) {
      setState(() {
        qrString = "QR is invalid";
        qrStringColor=Colors.red;
      });
    }

  }

  void showInSnackBar(String value, Color color, int duration) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Container(
        height: 50,
        color: Colors.transparent,
        child: new Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
        ),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    )
    );
  }
}