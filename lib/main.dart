import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';

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
  File? _image;
  // @override
  // void initState() {
  //   requestPermission();
  //   super.initState();
  // }

  // requestPermission() async {
  //   var status = await Permission.camera.status;
  //   if (status.isGranted) {
  //     Permission.camera.request();
  //   }
  //   var status1 = await Permission.storage.status;
  //   if (status1.isGranted) {
  //     Permission.storage.request();
  //   }
  // }

  pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    setState(
      () {
        if (image != null) {
          _image = File(image.path);
          GallerySaver.saveImage(_image!.path, albumName: "My images");
        }
      },
    );
  }

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
          return Center(
            child: Container(
              child:
                  _image == null ? Text("Take New Image") : Image.file(_image!),
            ),
          );
        },
      ),
    );
  }
}
