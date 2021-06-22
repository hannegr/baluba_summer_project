import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final picker = ImagePicker();

  Future<void> _findPicture() async {
    final imageFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile as File;
    });
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); //this is where we can store data.
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> _takePicture() async {
    final imageFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile as File;
    });
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); //this is where we can store data.
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Container(
            width: 90,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: _storedImage == null
                ? Text(
                    'Du har ikke profilbilde ennå :(',
                    textAlign: TextAlign.center,
                  )
                : Image.file(_storedImage!,
                    fit: BoxFit.cover, width: double.infinity),
            alignment: Alignment.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Flexible(
          child: TextButton.icon(
            onPressed: _findPicture,
            icon: Icon(Icons.image),
            label: Text(
              'Velg profilbilde',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        Flexible(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text(
              'Ta profilbilde',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
