import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gallerius/logic/gallery.dart';
import 'package:flutter_gallerius/widgets/gallery_widget.dart';
import 'package:flutter_gallerius/widgets/image_screen.dart';

Future<String?> _getOpenFolder(String? current) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
    dialogTitle: "Open Picture Folder",
    lockParentWindow: true,
    initialDirectory: current ?? appDocDir.path,
  );
  return selectedDirectory;
}

class GalleryHome extends ConsumerWidget {
  const GalleryHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gallery = ref.watch(galleryProvider);
    final String? path = gallery.currentPath;

    void _openGallery() async {
      String? galleryPath = await _getOpenFolder(path);
      if (galleryPath != null) gallery.setCurrentPath(galleryPath);
    }

    void _openImage(String path) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ImageScreen(
              path: path,
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(path ?? title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.folder_open),
            tooltip: 'Open Folder',
            onPressed: _openGallery,
          ),
        ],
      ),
      body: Center(
        child: path == null
            ? OutlinedButton(
                onPressed: _openGallery,
                child: const Text("Open Folder"),
              )
            : GalleryWidget(
                gallery: gallery,
                onImageClicked: _openImage,
              ),
      ),
    );
  }
}
