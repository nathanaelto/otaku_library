import 'package:OtakuLibrary/core/models/books/book.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/books/book.service.dart';
import 'package:OtakuLibrary/in_app/home/widgets/card_manga.dart';
import 'package:OtakuLibrary/shared/widgets/otaku_error.dart';
import 'package:flutter/material.dart';

class MangasView extends StatefulWidget {
  const MangasView({Key? key}) : super(key: key);

  @override
  State<MangasView> createState() => _MangasViewState();
}

class _MangasViewState extends State<MangasView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _fetchMangas(),
        builder: (BuildContext context, AsyncSnapshot<Widget> widget) {
          if (widget.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return widget.data!;
        },
      ),
    );
  }

  Future<Widget> _fetchMangas() async {
    ServiceResponse<List<Book>> serviceResponse = await BookService.getBooks();
    if (serviceResponse.hasError) {
      return const OtakuError();
    }

    if (serviceResponse.data == null) {
      return const OtakuError();
    }

    List<Book> books = serviceResponse.data!;
    return _buildMangas(books);
  }

  Widget _buildMangas(List<Book> books) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CardManda(book: books[index]);
      },
    );
  }
}
