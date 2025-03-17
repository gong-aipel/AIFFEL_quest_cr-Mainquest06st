import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  XFile? _image;

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Picker")),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: (<Widget>[
              ElevatedButton(
                  onPressed: getGalleryImage,
                  child: Text('gallery')
              ),
              Center(
                child: _image == null
                  ? Text(
                    'No image selected.',
                    style: TextStyle(color: Colors.white),
                  )
                  : CircleAvatar(
                    backgroundImage: FileImage(File(_image!.path)),
                    radius: 100,
                  ),
              ),
              ElevatedButton(
                  onPressed: getCameraImage,
                  child: Text('camera'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}