import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String titleText}) {
  
  return AppBar(
    backgroundColor: Color(0xFFB4C56C).withOpacity(0.0),
    brightness: Brightness.light,
    title: Text(
      isAppTitle ? "  Bug Dad" : titleText,
      style: TextStyle(
        color: Colors.lightBlue,
        fontFamily: isAppTitle ? "Nightmarecodehack" : "",
        fontSize: isAppTitle ? 40.0 : 20.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(50.0)
      ),
    ),
    elevation: 250.0,
    centerTitle: false,
  );
}
