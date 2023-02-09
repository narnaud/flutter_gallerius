import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final galleryProvider = ChangeNotifierProvider((ref) => Gallery());

class GalleryItem {
  const GalleryItem({
    required this.path,
  });
  final String path;
}

class Gallery extends ChangeNotifier {
  String? currentPath;
  List<GalleryItem> items = [];

  void setCurrentPath(String path) {
    currentPath = path;
    items = _allPicturesInPath(path);
    notifyListeners();
  }

  List<GalleryItem> _allPicturesInPath(String path) {
    final pictureDir = Directory(path);
    return pictureDir
        .listSync(recursive: false)
        .where((item) => (item.path.endsWith(".jpg") || item.path.endsWith(".png")))
        .map((item) => GalleryItem(path: item.path))
        .toList(growable: false);
  }
}
