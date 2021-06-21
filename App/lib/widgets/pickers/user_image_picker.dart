import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) imagePickfin;
  UserImagePicker(this.imagePickfin);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedimage;
  void pickimage() async {
    final pickedimagefile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedimage = pickedimagefile;
    });
    widget.imagePickfin(pickedimagefile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedimage != null ? FileImage(_pickedimage) : null,
        ),
        FlatButton.icon(
          onPressed: pickimage,
          icon: Icon(
            Icons.image,
          ),
          label: Text(
            'Add image',
          ),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
