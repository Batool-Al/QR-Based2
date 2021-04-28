import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  final String studentuid;
  final Map user;


  const CoursesPage({Key key, this.studentuid, this.user}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();

}

class _CoursesPageState extends State<CoursesPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  DocumentSnapshot userData;
  Stream<QuerySnapshot> streamCourses=FirebaseFirestore.instance.collection('Courses').snapshots();
  Stream<DocumentSnapshot> streamUserData;
  QuerySnapshot event;
  @override
  void initState() {
    setState(() {
      streamUserData=FirebaseFirestore.instance.collection('UsersAccounts').doc(widget.studentuid).snapshots();
    });
    getCoursesData();
    getUserData();
    super.initState();
  }

 Future getUserData()async{
    streamUserData.listen((event) {
      setState(() {
        userData=event;
      });
    });
  }
  Future getCoursesData()async{
    streamCourses.listen((data) {
      setState(() {
        event=data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Courses"),
      ),
      floatingActionButton: null,
      body: Container(
        height: double.infinity,
        child: flowList(context),
      ),
    );
  }
  Widget flowList (BuildContext context){
      if(event==null){
        return SizedBox(height: 1,);
      }else{
        return ListView.builder(
          itemCount: event.docs.length,
          itemBuilder: (context,i){
            if(userData!=null){
              return userData.data().containsKey(event.docs[i].data()['Course']) ? Container(
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
                          event.docs[i].data()["Course"],
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
                          event.docs[i].data()["Major"],
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
                          onTap: ()async{
                            getUserData().then((value)async{
                              if (userData.data().containsKey(event.docs[i].data()['Course'])==true){
                                await FirebaseFirestore.instance.collection('UsersAccounts')
                                    .doc(widget.studentuid).update({
                                  event.docs[i].data()['Course']: FieldValue.delete(),
                                }).then((value) {
                                  showInSnackBar('${event.docs[i].data()['Course']} dropped successfully',Colors.green ,2);
                                });
                              }
                              else{
                                showInSnackBar('Cannot drop ${event.docs[i].data()['Course']} course ',Colors.red ,2);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.cancel_presentation,
                                color: Colors.red,),
                              SizedBox(width: 6,),
                              Text("Drop",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
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
              ) :Container(
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
                          event.docs[i].data()["Course"],
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
                          event.docs[i].data()["Major"],
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
                          onTap: ()async{
                            getUserData().then((value)async{
                              if (!(userData.data().containsKey(event.docs[i].data()['Course']))){
                                await FirebaseFirestore.instance.collection('UsersAccounts')
                                    .doc(widget.studentuid).update({
                                  event.docs[i].data()['Course']: '${event.docs[i].data()['Course']} is registered',
                                }).then((value) {
                                  showInSnackBar('${event.docs[i].data()['Course']} registered successfully',Colors.green ,2);
                                });
                              }
                              else{
                                showInSnackBar('${event.docs[i].data()['Course']} already registered',Colors.red ,2);
                                print("Registered");
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.app_registration,
                                color: Theme.of(context).primaryColor,),
                              SizedBox(width: 6,),
                              Text("Register",
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
            }else{
              return SizedBox(height: 1,);
            }
          },
        );
      }
  }
  void showInSnackBar(String value, Color color, int duration) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: duration),
    )
    );
  }
}
