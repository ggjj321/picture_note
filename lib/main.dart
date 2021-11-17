import 'package:flutter/material.dart';
import 'package:picture_note/page/home.dart';


Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: home.routeName,
      routes: {
        home.routeName: (context) => const home(),
        // TakePictureScreen.routeName: (context) => TakePictureScreen(
        //   camera: camera,
        // ),
        // CameraApp.routeName:(context) => CameraApp(
        //   camera: camera,
        // ),
      },
    );
  }
}