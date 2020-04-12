import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(String mediaUrl) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30.0),
    child: CachedNetworkImage(
    alignment: Alignment.center,
    height: 380.0,
    width: 380.0,
    imageUrl: mediaUrl,
    fit: BoxFit.cover,
    placeholder: (context, url) => Padding(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.all(20.0),
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  ),
  );
}
