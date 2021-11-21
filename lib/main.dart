import 'package:flutter/material.dart';
import 'package:picture_note/page/home.dart';
import 'package:picture_note/page/table.dart';


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
      initialRoute: table.routeName,
      routes: {
        home.routeName: (context) => const home(),
        table.routeName:(context) => table(),
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