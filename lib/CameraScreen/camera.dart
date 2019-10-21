import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'camera_capture.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class Camera extends StatefulWidget {
  final title;
  Camera(this.title);

  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;
  var finalimage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 1080, maxWidth: 1920);

    _image = image;
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    _image = image;
  }

  Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      maxWidth: 1920,
      maxHeight: 1080,
    );
    finalimage = croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.camera_alt,
              title: "Camera",
              onclick: () async {
                await getImage();
                await _cropImage(_image);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CameraCapture(finalimage, widget.title)));
              }),
          TabData(
              iconData: Icons.folder_open,
              title: "Gallery",
              onclick: () async {
                await getImageGallery();
                await _cropImage(_image);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CameraCapture(finalimage, widget.title)));
              }),
        ],
        onTabChangedListener: (position) {
          setState(() {});
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("OCR"),
      ),
      body: Center(
        child: Text("Click Photo from Camera or Choose Image from Gallery"),
      ),
    );
  }
}
