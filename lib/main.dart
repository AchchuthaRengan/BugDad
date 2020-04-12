import 'package:bugdad/home.dart';
import 'package:bugdad/widgets/ThemeSelectorPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
void main() 
{
  Firestore.instance.settings().then((_){
    print("Timestamps enabled in snapshots\n");
  }, onError: (_){
    //print("Error enabling timestamps \n");
  });

runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return ThemeBuilder(
          builder: (context,_brightness){
            return MaterialApp(
          title: 'Bug Dad',
          theme: ThemeData(
          primaryColor:Colors.lightBlueAccent,
            brightness: _brightness,
          ),
          
          debugShowCheckedModeBanner: false,
          home: Home(),
        );
          },
        );
        
  }
}
 

