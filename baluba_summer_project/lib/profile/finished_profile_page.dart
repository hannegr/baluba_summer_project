import 'package:flutter/material.dart';
//import 'package:profile_page_test/profile/image_input.dart';

import 'dart:io';

class FinishedProfilePage extends StatelessWidget {
  final String name;
  final String location;
  final String description;
  final File imageFile;
  FinishedProfilePage(
      {required this.name,
      required this.location,
      required this.description,
      required this.imageFile});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Min profil'),
      ), //add action in appbar and a button where you can change your profile or something.
      body: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: CircleAvatar(
                minRadius: 60.0,
                child: Image.file(imageFile,
                    fit: BoxFit.cover, width: double.infinity),
              ))
        ],
      ),
    );
  }
}
