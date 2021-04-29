import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ExcusesManager extends StatefulWidget {
  @override
  _ExcusesManagerState createState() => _ExcusesManagerState();
}

class _ExcusesManagerState extends State<ExcusesManager> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  QuerySnapshot excuses;


  @override
  void initState() {
    getUserExcuses();
    super.initState();
  }

  getUserExcuses()async{
    await FirebaseFirestore.instance.collection('Excuses')
        .where('ExcuseStatus',isEqualTo: 'Pending')
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 5,),
            Text(
              'Tap on excuse to view excuse detail. ',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 15
              ),
            ),
            SizedBox(height: 5,),
            Expanded(flex:1,child: excusesFlowList(context)),
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
          return GestureDetector(
            child: Card(
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
                                color: Colors.orange,
                                fontSize: 15
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            onTap: (){
              showMaterialModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  builder: (context){
                    return Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 25),
                      child: SingleChildScrollView(
                        controller: ModalScrollController.of(context),
                        child: Container(
                          height: 700,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               Container(
                                 width: double.maxFinite,
                                 height: 370,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   image: DecorationImage(
                                     image: NetworkImage(
                                         excuses.docs[i].data()['ExcuseImageURL'],
                                     ),
                                     fit: BoxFit.fill
                                   )
                                 ),
                               ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Excuse Message: ',
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    excuses.docs[i].data()['ExcuseMessage'],
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      child: Container(
                                        height: 35,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Approve Excuse',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: ()async{
                                        await FirebaseFirestore.instance.collection('Excuses').doc(excuses.docs[i].id)
                                            .update({
                                          'ExcuseStatus':'Approved',
                                        }).then((value) {
                                          getUserExcuses();
                                          Navigator.of(context).pop();
                                          showInSnackBar('Excuse Approved', Colors.green, 2);
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        height: 35,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Reject Excuse',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: ()async{
                                        await FirebaseFirestore.instance.collection('Excuses').doc(excuses.docs[i].id)
                                            .update({
                                          'ExcuseStatus':'Rejected',
                                        }).then((value) {
                                          getUserExcuses();
                                          Navigator.of(context).pop();
                                          showInSnackBar('Excuse Rejected', Colors.green, 2);
                                        });
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            },
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
              'No Pending Excuses',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 23,
              ),
            ),
          ),
        ],
      );
    }
  }

  giveDateTimeStampFromFireBase(pTimeStamp) {
    var tDateString=new DateFormat("dd/MM/yyyy HH:mm:ss").format(pTimeStamp.toDate());
    return tDateString;
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
