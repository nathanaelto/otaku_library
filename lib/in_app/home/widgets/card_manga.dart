import 'dart:typed_data';

import 'package:OtakuLibrary/core/models/books/book.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/books/book.service.dart';
import 'package:OtakuLibrary/in_app/book/book.screen.dart';
import 'package:OtakuLibrary/shared/widgets/otaku_error.dart';
import 'package:flutter/material.dart';

class CardManda extends StatelessWidget {
  final Book book;

  const CardManda({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchImage(context),
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
          return _buildCard(context, widget.data!);
        }
      },
    );
  }

  Future<Widget> _fetchImage(BuildContext context) async {
    ServiceResponse<Uint8List> serviceResponse =
        await BookService.getBookImage(book.id);
    if (serviceResponse.hasError) {
      return const OtakuError();
    }
    if (serviceResponse.data == null) {
      return const OtakuError();
    }
    Uint8List image = serviceResponse.data!;
    return Image.memory(
      image,
      fit: BoxFit.contain,
    );
  }

  Widget _buildCard(BuildContext context, Widget image) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () => _navigateToBook(context),
        child: Card(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: image,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    book.title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToBook(BuildContext context) {
    Navigator.of(context).pushNamed(BookScreen.routeName, arguments: book.id);
  }
}
