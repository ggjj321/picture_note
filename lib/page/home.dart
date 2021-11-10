import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:picture_note/page/takepicture.dart';
import 'package:picture_note/page/camera.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class home extends StatefulWidget {
  static const routeName = '/home';
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {

  static const List<String> entries = <String>['A', 'B', 'C'];
  static const List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, index) {
          return ElevatedButton(
            onPressed: () async{
              var status = await Permission.storage.status;
              if (!status.isGranted) {
                await Permission.storage.request();
              }
              final ImagePicker _picker = ImagePicker();
              var image = await _picker.pickImage(source: ImageSource.camera);
              String? picture_name = image?.name;
              Directory? appDocDir = await getExternalStorageDirectory();
              String? appDocPath = appDocDir?.path;
              print(appDocPath);
              await image?.saveTo("/storage/emulated/0/Pictures/" + picture_name!);
              setState(() {});
            },
            child: const Text('Enabled'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}

// class home extends StatelessWidget {
//   static const routeName = '/home';
//   static const List<String> entries = <String>['A', 'B', 'C'];
//   static const List<int> colorCodes = <int>[600, 500, 100];
//
//   const home({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null,
//       body:ListView.separated(
//         padding: const EdgeInsets.all(8),
//         itemCount: entries.length,
//         itemBuilder: (BuildContext context, index) {
//           return ElevatedButton(
//             onPressed: () async{
//               final ImagePicker _picker = ImagePicker();
//               var image = await _picker.pickImage(source: ImageSource.camera);
//               setState(() {});
//             },
//             child: const Text('Enabled'),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) => const Divider(),
//       ),
//     );
//   }
// }


