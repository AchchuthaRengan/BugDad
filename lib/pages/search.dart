import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bugdad/models/user.dart';
import 'package:bugdad/pages/activity_feed.dart';
import 'package:bugdad/home.dart';
import 'package:bugdad/widgets/progress.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users = usersRef
        .where("displayName", isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Color(0xFFB4C56C).withOpacity(0.0),
      elevation: 25.0,
      bottomOpacity: 25.0,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.lightBlue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.lightBlue)
          ),
          hintText: "Search fOr a user...",
          filled: true,
          fillColor: Color(0xFF87CEFA).withOpacity(0.5),
          prefixIcon: Icon(
            FontAwesomeIcons.users,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearSearch,
          ),
        ),
        onFieldSubmitted: handleSearch,
      ),
      brightness: Brightness.light,
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 250.0 : 200.0,
            ),
            Text(
              "Find yOur Bugbuddies",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 40.0,
                fontFamily: "ITCKRIST",
                shadows: <Shadow>[
                  Shadow(
                  color: Colors.lightBlue,
                  blurRadius: 25.0,
                  offset: Offset(1.0, 1.0),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration( color: Colors.lightBlueAccent,borderRadius: new BorderRadius.circular(35.0)),
       padding: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => showProfile(context, profileId: user.id),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(
                user.displayName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
              ),
              subtitle: Text(
                user.username,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
