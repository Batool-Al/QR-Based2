import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:random_string/random_string.dart';

// ignore: must_be_immutable

class CreateScreen extends StatefulWidget {
  final String contactKey;
  final Map contactInfo;
  CreateScreen({this.contactKey, this.contactInfo});
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  String qrString;
  String qrGenerated;

   var generated = FirebaseFirestore.instance.collection('CoursesQR').doc();

  @override
  Widget build(BuildContext context) {
    String random = randomAlphaNumeric(20);
    qrString = widget.contactKey;
    qrGenerated = qrString + random;

    return Scaffold(
      appBar: AppBar(
        title: Text("Create QR Code ${widget.contactInfo['Course']}", style: TextStyle(fontSize: 12),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 20,),
          // qr code
          BarcodeWidget(
            color: Colors.blue,
            data: qrGenerated ,
            height: 250,
            width: 250,
            barcode: Barcode.qrCode(),

          ),
          TextButton(
            onPressed:(){
              generated.set(
                  { 'Attended': 0,
                    'CourseID': widget.contactKey,
                    'CourseCode': widget.contactInfo['Course'],
                    'DateCreated': DateTime.now(),
                    'QRValue': qrGenerated,
                    'Validated': true,
                  });
            },
            child: Text('Create QR'),
          ),
          // link
          TextButton(
              onPressed: (){
                generated.update({
                  'Validated': false,
                });
              },
              child: Text("Pause Validation")),
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),

        ],
      ),
    );
  }
}