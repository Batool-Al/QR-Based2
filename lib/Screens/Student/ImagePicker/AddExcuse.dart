import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
class AddExcuse extends StatefulWidget {
  @override
  _AddExcuseState createState() => _AddExcuseState();
  final String userID;
  AddExcuse({this.userID});
}

class _AddExcuseState extends State<AddExcuse> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  File image;
  String imageURL;
  QuerySnapshot excuses;
  bool showNewExcuse=false;
  TextEditingController excuseCourseNameController = TextEditingController();
  TextEditingController excuseMessageController = TextEditingController();

  @override
  void initState() {
    getUserExcuses();
    super.initState();
  }

  getUserExcuses()async{
    await FirebaseFirestore.instance.collection('Excuses')
        .where('ExcuseStudentID',isEqualTo: widget.userID)
        .orderBy('ExcuseDate',descending: true)
        .get().then((value) {
          setState(() {
            excuses=value;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Excuse'),
        actions: [
          TextButton(
              onPressed: () {
                if(showNewExcuse==false){
                  setState(() {
                    showNewExcuse=true;
                  });
                }else{
                  setState(() {
                    showNewExcuse=false;
                  });
                }
              },
              child: Text(
                'New',
                style: TextStyle(color: Colors.pinkAccent[100], fontFamily: 'NotoSerif-Bold'),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Visibility(
                visible: showNewExcuse,
                child: newExcuseForm(context),
              replacement: Expanded(flex:1,child: excusesFlowList(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget excusesFlowList(BuildContext context){
    if(excuses!=null&&excuses.docs.length>=1){
      return ListView.builder(
        shrinkWrap: true,
        itemCount: excuses.docs.length,
        itemBuilder: (context,i){
          return Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Excuse Date: ',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 15
                        ),
                      ),
                      Text(
                        giveDateTimeStampFromFireBase(excuses.docs[i].data()['ExcuseDate']),
                        style: TextStyle(
                          color: Colors.indigo,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Course Name: ',
                        style: TextStyle(
                          color: Colors.indigo,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        excuses.docs[i].data()['ExcuseCourseName'],
                        style: TextStyle(
                          color: Colors.indigo,
                            fontSize: 15
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Excuse Status: ',
                        style: TextStyle(
                          color: Colors.indigo,
                            fontSize: 15
                        ),
                      ),
                      Text(
                        excuses.docs[i].data()['ExcuseStatus'],
                        style: TextStyle(
                          color: checkStatus(excuses.docs[i].data()['ExcuseStatus']),
                            fontSize: 15
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No Excuses',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            child: Container(
              height: 35,
              width: 135,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'New Excuse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            onTap: (){
              if(showNewExcuse==false){
                setState(() {
                  showNewExcuse=true;
                });
              }else{
                setState(() {
                  showNewExcuse=false;
                });
              }
            },
          )
        ],
      );
    }
  }

  giveDateTimeStampFromFireBase(pTimeStamp) {
    var tDateString=new DateFormat("dd/MM/yyyy HH:mm:ss").format(pTimeStamp.toDate());
    return tDateString;
  }
  
  Color checkStatus(String value){
    switch (value){
      case 'Pending':{
        return Colors.orange;
      }break;
      case 'Rejected':{
        return Colors.red;
      }break;
      case 'Approved':{
        return Colors.green;
      }break;
      default :{
        return Colors.orange;
      }
    }
  }

  Widget newExcuseForm(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              imageURL==null?GestureDetector(
                child: Container(
                  height: 250,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text(
                      'Tap here to upload image',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.indigo
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  getNewImage(context);
                },
              ):Container(
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(image),
                    fit: BoxFit.fill
                  )
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: excuseCourseNameController, // Variable that hold typed value
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 16,
                height: 1,
              ),
              obscureText: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.indigo,
                        width: 2.0, style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.indigo,
                        width: 2.0, style: BorderStyle.solid)),
                labelText: 'Course Name',
                labelStyle: TextStyle(color: Colors.indigo),
                focusColor: Colors.indigo,
                hoverColor: Colors.indigo,
                isDense: true,
                counterStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: excuseMessageController,
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 16,
                height: 1,
              ),
              maxLines: 4,
              maxLength: 200,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.indigo, width: 2.0, style: BorderStyle.solid)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.indigo, width: 2.0, style: BorderStyle.solid)),
                labelText: 'Excuse Message',
                labelStyle: TextStyle(color: Colors.indigo),
                focusColor: Colors.indigo,
                hoverColor: Colors.indigo,
                isDense: true,
                counterStyle: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Submit Excuse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            onTap: (){
              newExcuseFormValidation();
            },
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            onTap: (){
              setState(() {
                excuseCourseNameController.clear();
                excuseMessageController.clear();
                imageURL=null;
                showNewExcuse=false;
              });
            },
          )
        ],
      ),
    );
  }

  newExcuseFormValidation()async{
    if(imageURL==null && image==null){
      showInSnackBar('Please choose excuse image', Colors.red, 2);
    }else if(excuseCourseNameController.text.length<=2){
      showInSnackBar('Excuse Course Name cannot be empty', Colors.red, 2);
    }else if(excuseMessageController.text.length<=10){
      showInSnackBar('Excuse message is too short', Colors.red, 2);
    }else{
      showInWaitingSnackBar('Submitting your excuse, Please wait...');
      Future.delayed(Duration(seconds: 2),()async{
        await FirebaseFirestore.instance.collection('Excuses').add({
          'ExcuseDate':DateTime.now(),
          'ExcuseCourseName':excuseCourseNameController.text,
          'ExcuseMessage':excuseMessageController.text,
          'ExcuseStudentID':widget.userID,
          'ExcuseImageURL':imageURL,
          'ExcuseStatus':'Pending'
        }).then((value) {
          _scaffoldKey.currentState.hideCurrentSnackBar();
          showInSnackBar('Excuse Submitted Successfully.', Colors.green, 2);
          getUserExcuses();
          setState(() {
            excuseCourseNameController.clear();
            excuseMessageController.clear();
            imageURL=null;
            showNewExcuse=false;
          });
        });
      });
    }
  }

  Future getNewImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      uploadNewImage(context);
      showInWaitingSnackBar('Uploading, Please Wait....');
    }
  }

  Future uploadNewImage(BuildContext context) async {
    if (image != null) {
      String fileName = path.basename(image.path);
      await FirebaseStorage.instance.refFromURL('gs://qr-based-attendance-syst-dff32.appspot.com/images')
          .child(fileName).putFile(image).then((value) async {
        await value.ref.getDownloadURL().then((value) {
          print(value.toString());
          setState(() {
            imageURL = value;
            _scaffoldKey.currentState.removeCurrentSnackBar();
            showInSnackBar('Excuse Image Uploaded', Colors.green, 2);
          });
        });
      });
    } else {
      getNewImage(context).whenComplete(() {
        uploadNewImage(context);
      });
    }
  }

  void showInSnackBar(String value, Color color, int duration) {
    FocusScope.of(context).requestFocus(new FocusNode());
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    ));
  }

  void showInWaitingSnackBar(String value,) {
    FocusScope.of(context).requestFocus(new FocusNode());
    // ignore: deprecated_member_use
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.indigo,
      duration: Duration(seconds: 300),
    ));
  }
}
