import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Courses"),
      ),
      floatingActionButton: null,
      body: Container(
        height: double.infinity,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Courses').snapshots(),
          builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children:
              snapshot.data.docs.map((contact)
              {
                return Container(
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
                            contact["Course"],
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
                            contact["Major"],
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
                            onTap: (){
                             FirebaseFirestore.instance.collection('UsersAccounts')
                                 .doc(widget.studentuid)
                                 .get()
                                 .then((value){
                                   if (!(value.data().containsKey(contact['Course']))){
                                     FirebaseFirestore.instance.collection('UsersAccounts')
                                         .doc(widget.studentuid).update({
                                       contact['Course']: '${contact['Course']} is registered',
                                     });
                                   }
                                   else{
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
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
