import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:external_path/external_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> listImagePath = <dynamic>[];
  Future? _futureGetPath;


  @override
  void initState() {
    _getPermission();
    super.initState();
    _futureGetPath = getImage();
  }
  Widget buildButton({
    required String title,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: onClicked,
        child:Row(
          children: [
            Icon(icon, size: 30),
            const SizedBox(width: 18),
            Text(title),
          ],
        ),
      );

  void _getPermission() async {
    await Permission.storage.request().isGranted;
    setState(() {});
  }

  Future<String> getImage() {
    return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  }

  _fetchFiles(Directory dir) {
    List<dynamic> listImage = [];
    dir.list().forEach((element) {
      RegExp regExp = RegExp(
          "(tiff?|png|webp|bmp|gif|jpe?g)", caseSensitive: false);
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Benting-Activity 5'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                future: _futureGetPath,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    if (true) _fetchFiles(dir);
                    return Text(snapshot.data);
                  } else {
                    return const Text("Please wait");
                  }
                },
              ),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: ElevatedButton.icon(
                    label: const Text('Take a Photo'),
                    icon: const Icon(
                      Icons.camera_alt,
                    ),
                    onPressed: () => {},
                  )
              ),
              Expanded(
                flex: 19,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(25),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: _getImage(listImagePath),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> _getImage(List<dynamic> listImagePath) {
    List<Widget> listImages = [];
    for (var imgPath in listImagePath) {
      listImages.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: Image.file(imgPath, fit: BoxFit.cover),
        ),
      );
    }
    return listImages;
  }
}