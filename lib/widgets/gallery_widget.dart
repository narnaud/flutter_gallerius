import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gallerius/logic/gallery.dart';
import 'package:path/path.dart' as p;

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({
    Key? key,
    required this.gallery,
    required this.onImageClicked,
  }) : super(key: key);

  final Gallery gallery;
  final Function onImageClicked;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      autofocus: true,
      child: GridView.extent(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200.0,
        children: [
          for (final item in widget.gallery.items)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GalleryImage(
                path: item.path,
                autofocus: widget.gallery.items.first.path == item.path,
              ),
            ),
        ],
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  const GalleryImage({
    Key? key,
    required this.path,
    this.autofocus = false,
  }) : super(key: key);

  final String path;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            Focus.of(context).requestFocus();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Focus.isAt(context) ? Theme.of(context).focusColor : Colors.transparent,
            child: Hero(
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
            ),
          ),
        );
      }),
    );
  }
}
