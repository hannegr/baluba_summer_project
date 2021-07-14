import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_page_test/profile/finished_profile_page.dart';
import 'package:profile_page_test/profile/image_input.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'dart:io';

import 'package:profile_page_test/profile/save_image_sql.dart';

//import 'package:profile_page_test/profile/save_image_sql.dart';

class ProfilePage extends StatefulWidget {
  static const profilePageName = '/profilepage';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImage;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _sendDataToProfilePage(
      BuildContext context,
      TextEditingController nameInput,
      TextEditingController locationInput,
      TextEditingController descriptionInput) async {
    print('svarte');
    //var imageData = await DBHelper.getData(DBHelper.tableName);
    DBHelper.getData(DBHelper.tableName);
    //File imageText = await imageData[0][
    //   'image']; //Denne gir en null-verdi. Hvordan skal jeg vite hvor den skal settes?
    //print(imageText);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedProfilePage(
            name: nameInput.text,
            location: locationInput.text,
            description: descriptionInput.text,
            //imageFile: imageText,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final nameInput = TextEditingController();
    final locationInput = TextEditingController();
    final descriptionInput = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lag din profil',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageInput(_selectImage),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                /* onChanged: (value) {
                        amountInput = value;
                      }, */
                controller: nameInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Navn'),
                style: TextStyle(
                  fontSize: 18,
                ),
                onSubmitted: (_) => {},
                //keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                /* onChanged: (value) {
                        amountInput = value;
                      }, */
                controller: locationInput,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Lokasjon'),
                style: TextStyle(
                  fontSize: 18,
                ),
                onSubmitted: (_) => {},
                //keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(12),
              width: double.infinity,
              height: 5 * 24.0,
              child: TextField(
                controller: descriptionInput,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Beskrivelse',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  hintText:
                      'Her kan du legge til en liten beskrivelse av deg selv.',
                ),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
                //onSurface: Colors.grey,
              ),
              onPressed: () => _sendDataToProfilePage(
                context,
                nameInput,
                locationInput,
                descriptionInput,
              ), //lagre profilen i en eller annen database

              child: Text(
                'Lagre din profil',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
