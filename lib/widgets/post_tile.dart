import 'package:flutter/material.dart';
import 'package:bugdad/pages/post_screen.dart';
import 'package:bugdad/widgets/custom_image.dart';
import 'package:bugdad/widgets/post.dart';

import 'custom_image.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile(this.post, {String userId, String postId});

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: post.postId,
          userId: post.ownerId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
