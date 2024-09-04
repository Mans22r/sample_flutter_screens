// ignore_for_file: library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

@override
void initState() {
  super.initState();
  availableCameras().then((cameras) {
    if (cameras.isNotEmpty) {
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _controller.initialize();
    } else {
    }
  }).catchError((e) {
  });
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Construct the path where the image should be saved using the path package.
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/Pictures/flutter_test';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${DateTime.now()}.png';

      // Attempt to take a picture and get the file where it was saved.
      final XFile picture = await _controller.takePicture();

      // Save the picture to the local directory.
      await picture.saveTo(filePath);

      // Display the taken picture.
      Navigator.push(
        context as BuildContext,
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: filePath),
        ),
      );
    } catch (e) {
      // If an error occurs, log it to the console.
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Take a Picture')),
    body: _initializeControllerFuture != null
        ? FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        : const Center(child: Text('Camera not available')),
    floatingActionButton: _controller != null
        ? FloatingActionButton(
            onPressed: _takePicture,
            child: const Icon(Icons.camera),
          )
        : null,
  );
}

}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
