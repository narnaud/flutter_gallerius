import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gallerius/widgets/image_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallerius',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GalleryScreen(title: 'Gallerius'),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String? _currentDirectory;
  List<String> _pictureFileNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentDirectory ?? widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: 'Open folder',
            onPressed: () async {
              String? selectedDirectory =
                  await getOpenPictureFolder(_currentDirectory);
              if (selectedDirectory != null) {
                setState(
                  () {
                    _currentDirectory = selectedDirectory;
                    _pictureFileNames = getPicturePaths(selectedDirectory);
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: GridView.extent(
          primary: false,
          padding: const EdgeInsets.all(16),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          maxCrossAxisExtent: 200.0,
          children: _pictureFileNames
              .map(
                (path) => GestureDetector(
                  onTap: () => (String path) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ImageScreen(
                          path: path,
                        );
                      },
                    ));
                  }(path),
                  child: Hero(
                    tag: path,
                    child: Center(
                      child: PhysicalModel(
                        color: Colors.black,
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Image.file(File(path)),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

Future<String?> getOpenPictureFolder(String? current) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
    dialogTitle: "Open Picture Folder",
    lockParentWindow: true,
    initialDirectory: current ?? appDocDir.path,
  );
  return selectedDirectory;
}

List<String> getPicturePaths(String path) {
  final pictureDir = Directory(path);
  return pictureDir
      .listSync(recursive: false)
      .map((item) => item.path)
      .where((item) => (item.endsWith(".jpg") || item.endsWith(".png")))
      .toList(growable: false);
}
