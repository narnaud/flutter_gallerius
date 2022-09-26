import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Handles the key events from the Focus widget and updates the
  // _message.
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    setState(() {
      if (event is KeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
          widget.gallery.focusPrevious();
        } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
          widget.gallery.focusNext();
        } else if (event.logicalKey == LogicalKeyboardKey.enter) {
          widget.onImageClicked(widget.gallery.currentItemPath);
        } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          // ??
        } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          // ??
        }
      }
    });
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: GridView.extent(
        primary: false,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        maxCrossAxisExtent: 200.0,
        children: widget.gallery.items
            .map(
              (item) => GestureDetector(
                onTap: () {
                  widget.gallery.setCurrentItemPath(item.path);
                  widget.onImageClicked(item.path);
                },
                child: GalleryImage(
                  path: item.path,
                  selected: item.path == widget.gallery.currentItemPath,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  const GalleryImage({
    Key? key,
    required this.path,
    required this.selected,
  }) : super(key: key);

  final String path;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Theme.of(context).focusColor : Colors.transparent,
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
    );
  }
}
