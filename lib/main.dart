import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() async {
  runApp(MaterialApp(
    title: "OCR",
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: Colors.red,
    ),
  ));
}
