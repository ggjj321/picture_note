import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class table extends StatelessWidget {
  static const routeName = '/table';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: WeekView(),
    );
  }
}

class WeekView extends StatefulWidget {
  const WeekView({Key? key}) : super(key: key);

  @override
  _WeekViewState createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  Color myColor = Color(0xff00bfa5);

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void createNewRoute(String routeName, int id) async {
    String keyId = id.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyId, routeName);

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    new Directory('/storage/emulated/0/' + routeName).create()
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

  openInputtBox(int index) {
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
                          onPressed: () {
                            Navigator.pop(context);
                            createNewRoute(myController.text, index);
                          },
                          child: Text('增加'),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  selectAlbumAndCameraBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.tealAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)))),
                  onPressed: () {},
                  child: const Text('拍照'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.white)))),
                  onPressed: () {},
                  child: const Text('相簿'),
                )
              ],
            ),
          );
        });
  }

  Future<String?> throwIdGetData(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyId = id.toString();
    String? text = prefs.getString(keyId);
    if (text == null){
      return "";
    }
    return prefs.getString(keyId);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      childAspectRatio: 2 / 3,
      children: List.generate(56, (index) {
        int pressState = 0;

        return Container(
          color: Colors.white,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (pressState == 0) {
                    return Colors.white;
                  } else {
                    return Color.fromRGBO(
                        100 + index * 3, 200 - index * 2, 180, 0.5);
                  }
                }),
              ),
              onPressed: () {
                switch (pressState) {
                  case 0:
                    openInputtBox(index);
                    pressState = 1;
                    break;
                  case 1:
                    selectAlbumAndCameraBox();
                    break;
                }
              },
              child: FutureBuilder(
                future: throwIdGetData(index),
                initialData: "",
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> text) {
                      return Text(
                        text.data,
                      );
                    },
              )),
        );
      }),
    );
  }
}


