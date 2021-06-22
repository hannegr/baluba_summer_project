import 'package:flutter/material.dart';
import 'package:profile_page_test/profile/image_input.dart';

import 'dart:io';

class ProfilePage extends StatelessWidget {
  static const profilePageName = '/profilepage';
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Din profil',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
      body: ImageInput(_selectImage),
    );
  }
}
