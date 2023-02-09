import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';

class CBZReader extends StatefulWidget {
  final String filePath;

  CBZReader({required this.filePath});

  @override
  _CBZReaderState createState() => _CBZReaderState();
}

class _CBZReaderState extends State<CBZReader> {
  List<Widget> images = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final directory = await getApplicationDocumentsDirectory();
    final targetPath = directory.path;
    final byteData = await rootBundle.load('assets/cbz/Chapitre_4.cbz');
    final buffer = byteData.buffer;
    final archive = ZipDecoder().decodeBytes(buffer.asUint8List(), verify: true);
    for (var file in archive) {
      if (!file.isFile) {
        continue;
      }
      final fileName = file.name;
      final data = file.content;
      final targetFile = File("$targetPath/$fileName")
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
      final image = Image.file(targetFile);
      images.add(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return PageView(
            children: images,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}