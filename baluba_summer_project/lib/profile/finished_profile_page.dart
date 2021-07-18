import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
//import 'package:profile_page_test/profile/image_input.dart';

class FinishedProfilePage extends StatelessWidget {
  final String location;
  final String description;
  final String profileImage;
  FinishedProfilePage({
    required this.location,
    required this.description,
    required this.profileImage,
  });
  //required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Min profil'),
      ), //add action in appbar and a button where you can change your profile or something.
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Container(
              alignment: Alignment.center,
              height: 300,
              width: MediaQuery.of(context).size.width - 10,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                child: Image(
                  image: NetworkImage(profileImage),
                ),
              ),
            ),
            /*child: CircleAvatar(
              minRadius: 60.0,
              backgroundImage: NetworkImage(profileImage),
            ),
            */
          ),
          Container(
            child: Text(location),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
