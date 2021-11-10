import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:picture_note/page/camera.dart';
import 'package:picture_note/page/home.dart';
import 'package:picture_note/page/takepicture.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: home.routeName,
      routes: {
        home.routeName: (context) => const home(),
        TakePictureScreen.routeName: (context) => TakePictureScreen(
          camera: camera,
        ),
        CameraApp.routeName:(context) => CameraApp(
          camera: camera,
        ),
      },
    );
  }
}