import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bugdad/models/user.dart';



class Dashboard extends StatefulWidget {
  final User currentUser;

  Dashboard({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin<Dashboard> {
 
  File file;
 Container buildSplashScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
        return Container(
         decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple,
              Colors.blue,
              Colors.lightBlueAccent,
              Colors.cyanAccent,
              Colors.lightBlueAccent,
              Colors.blue,
              Colors.deepPurple,
            ],           
          ),
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        textBaseline: TextBaseline.ideographic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/bugdadnew.gif', height: orientation == Orientation.portrait ? 250.0 : 100.0,fit: BoxFit.contain),
          Text("This is a prOduction frOm Omega X",
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontFamily: "ITCKRIST"
            ),
            ),
            Text("Version: 1.O",style: TextStyle(decoration: TextDecoration.none,fontSize: 15.0,color: Colors.black.withOpacity(0.6),fontFamily: "ITCKRIST"),),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              splashColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Text(
                  "BugDad",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontFamily: "ITCKRIST",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.amberAccent,
                onPressed: (){
                  shownew(context);
                }
            )),
            Text("BugDad was created by THE HAK and HOO TEAM, the computer science engineering students. BugDad is built to operate as a solution seeker for coding based problems by connecting the experienced programmers across the world.\n \n Thank You For Installing BugDad",
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 18.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              fontFamily: "ITCKRIST"
              ),
              textAlign: TextAlign.center,),
        ],
        ),
      );
  }
  void shownew(BuildContext context){
    var alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      backgroundColor: Colors.lightBlueAccent,
      title: Text('ThankYOu \n For YOur LOve..!',textAlign: TextAlign.center,style: TextStyle(fontFamily: 'ITCKRIST',fontWeight: FontWeight.bold),),
      actions: <Widget>[
        Text('Regards \n -Hak and HOO Team',style: TextStyle(letterSpacing: 5.0,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),
        Icon(Icons.favorite,color: Colors.redAccent,)
      ],
      content: Text('Stay cOnnected with us to get exciting surprises upcOming..!',style: TextStyle(fontFamily: 'ITCKRIST',fontWeight: FontWeight.bold),),
    );
    showDialog(
      context: context,
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }
  

  
  

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return buildSplashScreen();
  }
}
