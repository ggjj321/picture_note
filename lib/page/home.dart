import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Color myColor = Color(0xff00bfa5);
  static const List<String> entries = <String>['A', 'B', 'C'];
  openAlertBox() {
    final TextEditingController myController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "新事項",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: "新增事項",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed:  () => createNewRoute(myController.text),
                        child: Text('增加'),
                      )
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void createNewRoute(String routeName)async{
    print(routeName);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    new Directory('/storage/emulated/0/'+routeName).create()
    // The created directory is returned as a Future.
        .then((Directory directory) {
      print(directory.path);
    });
  }

  void savePhotoToSpecifyRoute() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body:ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, index) {
          return ElevatedButton(
            onPressed: () => savePhotoToSpecifyRoute(),
            child: const Text('Enabled'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAlertBox(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}



