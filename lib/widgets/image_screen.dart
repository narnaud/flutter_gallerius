import 'dart:io';
import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(path)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
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
      ),
    );
  }
}
