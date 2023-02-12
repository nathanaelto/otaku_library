import 'dart:io';
import 'dart:typed_data';

import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/chapters/chapters.service.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/recall_back_button.dart';
import 'package:OtakuLibrary/shared/widgets/otaku_error.dart';
import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ChapterReaderScreen extends StatelessWidget {
  static const String routeName = '/chapterReader';
  List<String> _files = [];

  ChapterReaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String chapterId = ModalRoute.of(context)!.settings.arguments as String;
    return WillPopScope(
      onWillPop: () async {
        _removeFilesChapters();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  children: [
                    RecallBackButton(
                      onBack: () {
                        _removeFilesChapters();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              FutureBuilder(
                future: _fetchChapter(chapterId),
                builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
                  if (widget.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }

                  if (widget.hasError) {
                    return const OtakuError();
                  }

                  return Expanded(
                    child: widget.data!,
                  );
                },
              )
            ],
          )
        )
      ),
    );
  }

  Future<Widget> _fetchChapter(String chapterId) async {
    ServiceResponse<Uint8List> serviceResponse = await ChaptersService.getChapterBuffer(chapterId);
    if (serviceResponse.hasError) {
      return const OtakuError();
    }
    if (serviceResponse.data == null) {
      return const OtakuError();
    }
    return await _buildReader(chapterId, serviceResponse.data!);
  }

  Future<Widget> _buildReader(String chapterId, Uint8List data) async {
    List<Widget> images = [];
    final directory = await getApplicationDocumentsDirectory();
    final targetPath = directory.path;
    final archive = ZipDecoder().decodeBytes(data, verify: true);
    for (var file in archive) {
      if (!file.isFile) {
        continue;
      }
      final fileName = file.name;
      final data = file.content;
      final path = "$targetPath/$chapterId/$fileName";
      _files.add(path);
      final targetFile = File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
      final image = Image.file(targetFile);
      images.add(image);
    }
    return PageView(
      children: images,
    );
  }

  void _removeFilesChapters() {
    for (var file in _files) {
      File(file).deleteSync();
    }
  }
}
