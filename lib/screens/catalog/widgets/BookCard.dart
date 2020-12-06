import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/main.dart';
import 'package:flutter_reader/models/Book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard(this.book);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, ReaderRoute, arguments: {'book': book}),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        constraints: BoxConstraints.expand(width: 100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: _getCardContent(context),
        ),
      ),
    );
  }

  Widget _getCardContent(BuildContext context) {
    if (book.coverImagePath == null)
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                book.author,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                book.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
        ),
      );
    else
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              book.coverImagePath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "${book.author}.\n${book.title}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
  }
}
