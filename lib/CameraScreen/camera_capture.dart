import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';

import 'pan_response.dart';

class CameraCapture extends StatefulWidget {
  final finalImage;
  final title;

  CameraCapture(this.finalImage, this.title);

  _CameraCaptureState createState() => _CameraCaptureState();
}

class _CameraCaptureState extends State<CameraCapture> {
//  CameraController controller;
  var response;
  Map output;
  upload(File imageFile, BuildContext context) async {
    _onLoading(context);
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri =
        Uri.parse("https://sleepy-cliffs-62432.herokuapp.com/${widget.title}");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    response = await request.send();
    print(response);
    Navigator.pop(context);
    // listen for response
//    output = await response.stream.bytesToString();
//    output = JsonDecoder().convert(output);
//    print(output);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
//      output = value;
//
      output = json.decode(value);
      print(output['name']);
    });
  }

  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SpinKitWave(
          color: Colors.red,
          size: 100.0,
        );
      },
    );
  }

  sendImage(File finalImage) async {
    FormData formData = new FormData.fromMap({
      "file": await MultipartFile.fromFile(widget.finalImage,
          filename: basename(widget.finalImage.path))
    });
    response = await Dio().post(
        "https://sleepy-cliffs-62432.herokuapp.com/${widget.title}",
        data: formData);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Image.file(widget.finalImage),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: EdgeInsets.all(20.0),
                color: Colors.teal,
                child: Text("Send"),
                onPressed: () async {
                  await upload(widget.finalImage, context);
//                  await sendImage(widget.finalImage);
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PanResponse(output)));
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                padding: EdgeInsets.all(20.0),
                color: Colors.red,
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
