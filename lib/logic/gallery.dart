import 'dart:io';
import 'dart:math';

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
  String? currentItemPath;
  List<GalleryItem> items = [];

  void setCurrentPath(String path) {
    currentPath = path;
    items = _allPicturesInPath(path);
    if (items.isNotEmpty) {
      currentItemPath = items.first.path;
    }
    notifyListeners();
  }

  void setCurrentItemPath(String path) {
    currentItemPath = path;
    notifyListeners();
  }

  void navigateFocus(int delta) {
    if (currentItemPath == null) {
      return;
    }
    int index = items.indexWhere((item) => item.path == currentItemPath);
    index = max(index + delta, 0);
    currentItemPath = items[index].path;
    notifyListeners();
  }

  void focusPrevious() {
    navigateFocus(-1);
  }

  void focusNext({int distance = 1}) {
    navigateFocus(1);
  }

  List<GalleryItem> _allPicturesInPath(String path) {
    final pictureDir = Directory(path);
    return pictureDir
        .listSync(recursive: false)
        .where((item) =>
            (item.path.endsWith(".jpg") || item.path.endsWith(".png")))
        .map((item) => GalleryItem(path: item.path))
        .toList(growable: false);
  }
}
