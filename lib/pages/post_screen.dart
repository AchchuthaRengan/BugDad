import 'package:flutter/material.dart';
import 'package:bugdad/home.dart';
import 'package:bugdad/widgets/post.dart';
import 'package:bugdad/widgets/progress.dart';


class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;

  PostScreen({this.userId, this.postId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef
          .document(userId)
          .collection('userPosts')
          .document(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Post post = Post.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            appBar: AppBar(title: 
            Text("Posts",
            style: TextStyle(color: Colors.blue,
            fontFamily: "ITCKRIST",
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            ),
            ),
            centerTitle: true,
            elevation: 250.0,
            backgroundColor: Color(0xFFB4C56C).withOpacity(0.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
            ),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
