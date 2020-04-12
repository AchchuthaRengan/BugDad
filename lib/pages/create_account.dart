import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';


class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  
  
  

  submit() {
   final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(content: Text("Welcome $username..!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }


  @override
  Widget build(BuildContext parentContext,) {
    const List<String> images =[
      'assets/images/artwork.png',
      'assets/images/debug.png',
      'assets/images/like.png',
      'assets/images/program.png',
      'assets/images/comments.png',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Welcome to BugDad.!',
      style: TextStyle(fontFamily: "ITCKRIST",
      fontWeight: FontWeight.w900,
      color: Colors.blue,
      letterSpacing: 0.5,
      fontSize: 23.0,
          ),
        ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50.0)
      ),
    ),
    backgroundColor: Colors.white,
        ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            
            height: 320.0,
            width: 500.0,
            child:Swiper(
              fade: 50.0,
              layout: SwiperLayout.TINDER,
              indicatorLayout: PageIndicatorLayout.NONE,
              autoplay: true,
              itemCount:images.length,
              itemHeight: 600.0,
              itemWidth: 600.0,
              viewportFraction: 2.8,
              scale: 1.9,
              curve: Curves.easeIn,
              itemBuilder: (BuildContext context, int index){
                return Image.asset(images[index],fit: BoxFit.fill);
                },
              pagination: null,
              control: new SwiperControl(color: Colors.lightBlueAccent,iconNext: null,iconPrevious: null),
            ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      "Create Your Username Here..!",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: "ITCKRIST",
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                        ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (val) {
                          if (val.trim().length < 3) {
                            return "Username too short";
                          } else if (val.trim().length > 12) {
                            return "Username too long";
                          }else if(val.isEmpty){
                            return "Don't Leave it Empty..!";
                          } 
                          else {
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                          labelText: "Usernames Here..!",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black),
                          hintText: "Must be at least 3 characters",
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submit,
                  child: Container(
                    height: 50.0,
                    width: 350.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ITCKRIST"),
                      ),
                    ),
                  ),
                ),
                Text("     \n\n\tIf this page shows again, Please enter your username again.\n(Max 2)",style: TextStyle(fontSize: 19.0,fontFamily:"ITCKRIST",color: Colors.lightBlueAccent,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
