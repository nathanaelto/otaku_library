import 'package:OtakuLibrary/core/models/chapters/chapter.dart';
import 'package:flutter/material.dart';

class CardChapter extends StatelessWidget {
  final Chapter chapter;

  const CardChapter({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _goToReadChapter,
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

  void _goToReadChapter() {
    print("read chapter");
  }

  void _download() {
    print("download chapter");
  }
}
