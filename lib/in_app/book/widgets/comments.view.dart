import 'package:OtakuLibrary/core/models/comments/comment.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/comments/comments.service.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_text_form_field.dart';
import 'package:OtakuLibrary/shared/widgets/otaku_error.dart';
import 'package:OtakuLibrary/shared/widgets/toast.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  final String bookId;

  const CommentView({Key? key, required this.bookId}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final _focusComment = FocusNode();
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: FutureBuilder(
            future: _fetchComments(widget.bookId),
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
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: OtakuTextFormField(
                hint: "Ecrire un commentaire",
                icon: Icons.comment,
                fillColor: Theme.of(context).colorScheme.secondary,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                focusNode: _focusComment,
                controller: _commentController,
                validator: (String? value) {
                  return value;
                },
              ),
            ),
            IconButton(
              onPressed: _sendComment,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            )
          ],
        )
      ],
    );
  }

  Future<Widget> _fetchComments(String bookId) async {
    ServiceResponse<List<Comment>> serviceResponse =
        await CommentsService.getCommentsByBookId(bookId);
    if (serviceResponse.hasError) {
      return const OtakuError();
    }
    if (serviceResponse.data == null) {
      return const OtakuError();
    }
    List<Comment> comments = serviceResponse.data!;
    if (comments.isEmpty) {
      return Center(
        child: Text(
          'Pas de commentaires pour le moment\nSois le premier à en laisser un !',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(comments[index].comment),
            subtitle: Text(comments[index].author),
          ),
        );
      },
    );
  }

  void _sendComment() async {
    String comment = _commentController.text;
    if (comment.isEmpty) {
      return;
    }
    ServiceResponse<Comment> serviceResponse =
        await CommentsService.createComment(comment, widget.bookId);
    if (serviceResponse.hasError) {
      _displayError(serviceResponse.error ?? "Impossible d'enregistrer votre commentaire");
      return;
    }
    _commentController.clear();
    setState(() {
      _focusComment.unfocus();
    });
  }

  void _displayError(String error) {
    Toast.show(
      error,
      context,
      backgroundColor: Colors.red,
    );
  }
}
