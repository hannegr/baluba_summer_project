import 'dart:ui';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io';

import 'package:profile_page_test/profile/finished_profile_page.dart';
import 'package:profile_page_test/profile/image_input.dart';
import 'package:profile_page_test/workouts/sports/sport_types.dart';

//import 'package:profile_page_test/profile/save_image_sql.dart';

class ProfilePage extends StatefulWidget {
  static const profilePageName = '/profilepage';
  static List<int>? mySports;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImage;
  String? imageUrl;

  void _selectImage(File pickedImage) async {
    _pickedImage = pickedImage;
    var uploadPic = await FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('pic'
            //userCredentials.user.uid + //vil ha dette med når vi har brukerid
            '.jpg')
        .putFile(_pickedImage);

    var downloadUrl = await uploadPic.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
  }

  void _sendDataToProfilePage(
      BuildContext context,
      TextEditingController locationInput,
      TextEditingController descriptionInput) async {
    //var imageData = await DBHelper.getData(DBHelper.tableName);
    //DBHelper.getData(DBHelper.tableName); FJERNET HER
    //File imageText = await imageData[0][
    //   'image']; //Denne gir en null-verdi. Hvordan skal jeg vite hvor den skal settes?
    //print(imageText);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishedProfilePage(
            location: locationInput.text,
            description: descriptionInput.text,
            profileImage: imageUrl!,
            //imageFile: imageText,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
                      'Her kan du legge til en liten beskrivelse av deg selv (valgfritt).',
                ),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Text(
                'Trening du liker',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SportItems(),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                  //onSurface: Colors.grey,
                ),
                onPressed: () {
                  FirebaseFirestore.instance.collection('Baluba_profiles').add({
                    'location': locationInput.text,
                    'description': descriptionInput.text,
                    'imageUrl': imageUrl,
                    'sports': ProfilePage.mySports,
                    'userID': user.uid,
                  });

                  _sendDataToProfilePage(
                    context,
                    locationInput,
                    descriptionInput,
                  );
                }, //lagre profilen i en eller annen database

                child: Text(
                  'Lagre din profil',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
