import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kidney_cancer_detection/screens/utility_screens/background.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _image;

  Future getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
        ),
        body: background_body(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? Text('No image selected.')
                    : Image.file(
                        _image!,
                        height: 200,
                      ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: getImage,
                  child: Text('Select Image'),
                ),
              ],
            ),
          ),
        ));
  }
}

void main() {
  runApp(MaterialApp(
    home: UploadPage(),
  ));
}
