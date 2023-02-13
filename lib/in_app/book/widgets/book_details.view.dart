import 'dart:typed_data';

import 'package:OtakuLibrary/core/models/books/book_chapters.dart';
import 'package:OtakuLibrary/core/models/chapters/chapter.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/books/book.service.dart';
import 'package:OtakuLibrary/in_app/book/widgets/card_chapter.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/recall_back_button.dart';
import 'package:OtakuLibrary/shared/widgets/otaku_error.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatefulWidget {
  final String bookId;
  const BookDetailsView({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  Widget build(BuildContext context) {
    final String bookId = widget.bookId;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
            future: _fetchBook(bookId),
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

              if (widget.data == null) {
                return const OtakuError();
              } else {
                return widget.data!;
              }
            }),
      ],
    );
  }

  Future<Widget> _fetchBook(String bookId) async {
    final responses = await Future.wait([
      BookService.getBookChapters(bookId),
      BookService.getBookImage(bookId)
    ]);

    ServiceResponse<BookChapters> bookChaptersResponse =
    responses[0] as ServiceResponse<BookChapters>;
    ServiceResponse<Uint8List> imageResponse =
    responses[1] as ServiceResponse<Uint8List>;

    if (bookChaptersResponse.hasError || imageResponse.hasError) {
      return const OtakuError();
    }

    if (bookChaptersResponse.data == null || imageResponse.data == null) {
      return const OtakuError();
    }

    BookChapters bookChapters = bookChaptersResponse.data!;
    Uint8List image = imageResponse.data!;

    return _buildBody(bookChapters, image);
  }

  Widget _buildBody(BookChapters bookChapters, Uint8List image) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView(
        children: _buildHead(bookChapters, image) +
            _buildChapters(bookChapters.chapters),
      ),
    );
  }

  List<Widget> _buildHead(BookChapters bookChapters, Uint8List image) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.memory(
            image,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  bookChapters.book.title,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Text(bookChapters.book.author),
            ],
          ),
        ],
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          bookChapters.book.synopsis,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ];
  }

  List<Widget> _buildChapters(List<Chapter> chapters) {
    return chapters.map((chapter) => CardChapter(chapter: chapter)).toList();
  }
}
