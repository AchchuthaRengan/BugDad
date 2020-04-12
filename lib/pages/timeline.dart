import 'package:bugdad/home.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bugdad/models/user.dart';
import 'package:bugdad/pages/search.dart';
import 'package:bugdad/widgets/header.dart';
import 'package:bugdad/widgets/post.dart';
import 'package:bugdad/widgets/progress.dart';


final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  final User currentUser;
  

  Timeline({this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Post> posts;
  List<String> followingList = [];
  
  
  @override
  void initState() {
    super.initState();
    getTimeline();
    getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .document(widget.currentUser.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();
    List<Post> posts =
        snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .document(currentUser.id)
        .collection('userFollowing')
        .getDocuments();
    setState(() {
      followingList = snapshot.documents.map((doc) => doc.documentID).toList();
    });
  }

  buildTimeline() {
    if (posts == null) {
      return circularProgress();
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      return ListView(children: posts);
    }
  }

  buildUsersToFollow() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.bubble_chart,
                              size: 30.0,
                              color: Colors.lightBlueAccent,
                            ),
                            SizedBox(
                              width: 9.0,
                            ),
                            Text(
                              "WelcOme tO Bug Feed..!",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontFamily: "ITCKRIST",
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: orientation == Orientation.portrait ? 300.0 : 250.0,
                        width: 500.0,
                        child:Carousel(
                          images: [
                            Image.asset('assets/images/writer.png',height: orientation == Orientation.portrait ? 300.0 : 50.0),
                            Image.asset('assets/images/bughunter.png'),
                            Image.asset('assets/images/contentedit.png'),
                            Image.asset('assets/images/Digiart.png'),
                            Image.asset('assets/images/Designers.png'),
                            Image.asset('assets/images/programmer.png'),
                            Image.asset('assets/images/word.png',alignment: Alignment.center,fit: BoxFit.scaleDown,),
                          ],
                          animationCurve: Curves.easeIn,
                          autoplay: true,
                          animationDuration: Duration(milliseconds: 1000),
                          boxFit: BoxFit.cover,
                          noRadiusForIndicator: true,
                          showIndicator: false,
                        ),
                      ),
                      Container(
                        child:Column(
                          children:<Widget>[
                            Padding(padding:EdgeInsets.only(bottom: 0.0),
                        child: RaisedButton(
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150.0),
                          ), 
                          child: Text("Click Here..! And Search fOr 'About' and FOllOw Us..!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: "ITCKRIST",
                                  ),
                                ),
                                color: Colors.lightBlueAccent,
                                onPressed:()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Search())),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text('FOllOw Us to Get Exclusive Updates..! Like This',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent,fontFamily: 'ITCKRIST',fontWeight: FontWeight.bold),),
              Icon(Icons.keyboard_arrow_down),
              SizedBox(
                height:150.0,
                width: 300.0,
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    
                   child: Column(children:<Widget>[
                     Image.asset('assets/images/showone.png'),
                     
                     
                   ],
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.end,),
                   
                  )
                                  
                ),
            ],
          ),
        );
    
  }
  

  @override
  Widget build(context) {
    return Scaffold(
        appBar: header(context, isAppTitle: true),
        body: RefreshIndicator(
            onRefresh: () => getTimeline(), child: buildTimeline()));
  }
}
