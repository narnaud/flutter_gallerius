import 'package:flutter/material.dart';
import 'package:flutter_gallerius/widgets/gallery_home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: const GalleryHome(title: 'Gallerius'),
    );
  }
}
