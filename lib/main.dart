import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      shortcuts: {
        ...WidgetsApp.defaultShortcuts,

        // this will make a right arrow focus the next focus node in reading order,
        // rather than the next node that is somewhere on the right of the current.
        // (normally the tab and shift+tab traverse in reading order,
        // arrow keys in just search for the next item in that direction)
        // the `const` is really important here! at least in the activator
        const SingleActivator(LogicalKeyboardKey.arrowRight): const NextFocusIntent(),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): const PreviousFocusIntent(),
      },
    );
  }
}
