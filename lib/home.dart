import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bugdad/pages/activity_feed.dart';
import 'package:bugdad/pages/create_account.dart';
import 'package:bugdad/pages/profile.dart';
import 'package:bugdad/pages/search.dart';
import 'package:bugdad/pages/timeline.dart';
import 'package:bugdad/pages/upload.dart';
import 'package:bugdad/widgets/ThemeSelectorPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bugdad/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = Firestore.instance.collection('users');
final postsRef = Firestore.instance.collection('posts');
final commentsRef = Firestore.instance.collection('comments');
final activityFeedRef = Firestore.instance.collection('feed');
final followersRef = Firestore.instance.collection('followers');
final followingRef = Firestore.instance.collection('following');
final timelineRef = Firestore.instance.collection('timeline');
final DateTime timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
 

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

  googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) async {
    if (account != null) {
      await createUserInFirestore();
      setState(() {
        isAuth = true;
      });
      configPushNotifications();
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }
  configPushNotifications(){
      final GoogleSignInAccount user = googleSignIn.currentUser;
      if(Platform.isIOS) getiOSPermission();
      _firebaseMessaging.getToken().then((token){
       
        usersRef
        .document(user.id)
        .updateData({"androidNotificationToken": token});
      });

      _firebaseMessaging.configure(
        onLaunch: (Map<String,dynamic> message) async {},
        onResume:  (Map<String,dynamic> message) async {},
        onMessage:  (Map<String,dynamic> message) async {
        
          final String recipientId = message['data']['recipient'];
          final String body = message['notification']['body'];
          if(recipientId == user.id){
           
            SnackBar snackbar = SnackBar(content:  Text(body, overflow: TextOverflow.ellipsis,),);
            _scaffoldKey.currentState.showSnackBar(snackbar);
          }
          
        },
      );

  }
  getiOSPermission(){
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(alert: true, badge: true, sound: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((settings){
     
    });
  
  }

  newLogo(){ 
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      alignment: Alignment.topCenter,
      child: Image.asset('assets/images/bugdadnew.gif',fit: BoxFit.contain,
      height: orientation == Orientation.portrait ? 400.0 : 100.0,
      ),
    );
  }
  
  

  createUserInFirestore() async {
    
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();
    
 
   
    if (!doc.exists) {
      
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));
      

      
      usersRef.document(user.id).setData({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });

      await followersRef
      .document(user.id)
      .collection('userFollowers')
      .document(user.id)
      .setData({});

      doc = await usersRef.document(user.id).get();
    }

    currentUser = User.fromDocument(doc);
  }

  

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
  
 

 Scaffold buildAuthScreen() {
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.black,
      body: PageView(
        children: <Widget>[
          Timeline(currentUser: currentUser),
          ActivityFeed(),
          Upload(currentUser: currentUser),
          Search(),
          Profile(profileId: currentUser?.id),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: ()=> ThemeBuilder.of(context).changeTheme(),
        child: Icon(Icons.color_lens),
        mini: true,
        backgroundColor: Colors.lightBlueAccent),
        
        bottomNavigationBar: 
                  CurvedNavigationBar(
          index: pageIndex,
          height: 45.0,
          items: <Widget>[
            Icon(FontAwesomeIcons.bug,size: 22),
            Icon(FontAwesomeIcons.solidBell,size: 22,),
            Icon(FontAwesomeIcons.cameraRetro,size: 22,),
            Icon(FontAwesomeIcons.search,size: 22),
            Icon(FontAwesomeIcons.userTie,size: 22),
          ],
          backgroundColor: Colors.lightBlue,
          color: Colors.lightBlueAccent,
          buttonBackgroundColor: Colors.lightBlue,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: onTap,
        ),
    );
  }

  
   

  
  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurpleAccent,
              Colors.blue,
              Colors.lightBlueAccent,
            ],           
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 90.0,height: 50.0),
            FadeAnimatedTextKit(
              alignment: Alignment.topCenter,
              text:['Analyze','Design','Debug','BugDad'],
              textAlign: TextAlign.right,
              textStyle: TextStyle(
                fontFamily: "Adventure",
                fontSize: 85.0,
                color: Colors.amber,
                shadows: <Shadow>[
                  Shadow(color: Colors.black.withOpacity(0.7),
                  blurRadius: 10.0,
                  offset: Offset(1.0, 9.0),
                  ),
                ]
              ),
            ),newLogo(),
              GestureDetector(
              onTap: login,
              child: Container(
                width: 300.0,
                height: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/google_signin_button.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
 


  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
    }
  
  
}
