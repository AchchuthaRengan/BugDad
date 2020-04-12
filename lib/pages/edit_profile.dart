import 'package:bugdad/pages/dashboard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:bugdad/models/user.dart';
import 'package:bugdad/home.dart';
import 'package:bugdad/widgets/progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class EditProfile extends StatefulWidget {
  final String currentUserId;

  EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;
  bool _displayNameValid = true;
  bool _bioValid = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Display Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
            errorText: _displayNameValid ? null : "DisplayName Too Short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "BiO",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update BiO",
             errorText: _bioValid ? null : "Bio is Too Long",
          ),
        )
      ],
    );
  }

  updateProfileData(){
    setState(() {
      displayNameController.text.trim().length < 3 ||
      displayNameController.text.isEmpty ? _displayNameValid = false :
      _displayNameValid = true;
      bioController.text.trim().length > 100 ? _bioValid = false :
      _bioValid = true;
    });
    if(_displayNameValid && _bioValid){
      usersRef.document(widget.currentUserId).updateData({
        "displayName": displayNameController.text,
        "bio":bioController.text,
      });
      SnackBar snackbar = SnackBar(content: Text("Profile Updated..!"),);
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  logout() async {
    await googleSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Home()));
  }

  about() async{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashboard()));
  }

  
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 250.0,
            backgroundColor: Color(0xFFB4C56C).withOpacity(0.0),
            title: Text(
              "Edit PrOfile",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: "ITCKRIST",
                fontWeight: FontWeight.bold
              ),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0),)),
            actions: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.done,
                  size: 30.0,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          body: isLoading
              ? circularProgress()
              : ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 8.0,
                            ),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage:
                                  CachedNetworkImageProvider(user.photoUrl),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                buildDisplayNameField(),
                                buildBioField(),
                              ],
                            ),
                          ),
                          RaisedButton(
                            color: Colors.lightBlueAccent,
                            onPressed: updateProfileData,
                            splashColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "Update prOfile",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ITCKRIST"
                              ),
                            ),
                          ),
                          RaisedButton(
                          onPressed:()=> about(),
                          splashColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            "abOut",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ITCKRIST",
                            ),
                          ),),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: FlatButton.icon(
                              onPressed: logout,
                              icon: Icon(FontAwesomeIcons.signOutAlt, color: Colors.red),
                              label: Text(
                                "LOgOut",
                                style: TextStyle(color: Colors.red, fontSize: 20.0,fontFamily: "ITCKRIST",fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      }
    }
    
    
          

