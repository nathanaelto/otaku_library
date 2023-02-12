import 'package:OtakuLibrary/core/models/chapters/chapter.dart';
import 'package:OtakuLibrary/in_app/chapter/chapter_reader.screen.dart';
import 'package:flutter/material.dart';

class CardChapter extends StatelessWidget {
  final Chapter chapter;

  const CardChapter({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToReadChapter(context),
      child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          child: Row(
            children: [
              Text(
                'Chapter ${chapter.chapterNumber}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              IconButton(
                onPressed: _download,
                icon: const Icon(
                  Icons.download,
                  size: 25.0,
                  textDirection: TextDirection.ltr,
                  semanticLabel:
                      'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
                ),
              ),
            ],
          )),
    );
  }

  void _goToReadChapter(BuildContext context) {
    print('${chapter.bookId} ${chapter.id}');
    Navigator.of(context).pushNamed(ChapterReaderScreen.routeName, arguments: chapter.id);
  }

  void _download() {
    print("download chapter");
  }
}
