import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gallerius/logic/gallery.dart';
import 'package:path/path.dart' as p;

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    Key? key,
    required this.gallery,
    required this.onImageClicked,
  }) : super(key: key);

  final Gallery gallery;
  final Function onImageClicked;

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      primary: false,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      maxCrossAxisExtent: 200.0,
      children: gallery.pictureFileNames
          .map(
            (path) => GestureDetector(
              onTap: () => onImageClicked(path),
              child: GalleryImage(
                path: path,
              ),
            ),
          )
          .toList(),
    );
  }
}

class GalleryImage extends StatelessWidget {
  const GalleryImage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: path,
      child: Center(
        child: PhysicalModel(
          color: Colors.black,
          elevation: 10,
          shadowColor: Colors.black,
          child: Tooltip(
            message: p.basename(path),
            child: Image.file(File(path)),
          ),
        ),
      ),
    );
  }
}
