import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.camera_alt,
        ),
        onPressed: () {
          pickImage(ImageSource.camera);
        },
      ),
      body: Builder(
        builder: (context) {
          if (pic != null) {
            Uint8List imageBytes = base64Decode(pic);
            return Center(
              child: Container(
                child: Image.memory(imageBytes),
              ),
            );
          }
          return Center(
            child: Container(
              child: Text("No Image is here"),
            ),
          );
        },
      ),
    );
  }

  File? image;
  dynamic path;
  dynamic pic;
  pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
    }
    setState(
      () {
        if (image != null) {
          path = image.path;
        }
      },
    );
  }
}
