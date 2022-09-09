import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final galleryProvider = ChangeNotifierProvider((ref) => new Gallery());

class Gallery extends ChangeNotifier {
  String? currentPath;
  List<String> pictureFileNames = [];

  void setCurrentPath(String path) {
    currentPath = path;
    pictureFileNames = _allPicturesInPath(path);
    notifyListeners();
  }

  List<String> _allPicturesInPath(String path) {
    final pictureDir = Directory(path);
    return pictureDir
        .listSync(recursive: false)
        .map((item) => item.path)
        .where((item) => (item.endsWith(".jpg") || item.endsWith(".png")))
        .toList(growable: false);
  }
}
