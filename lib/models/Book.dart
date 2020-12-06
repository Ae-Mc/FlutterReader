import 'package:flutter_reader/models/Chapter.dart';

class Book {
  final String title;
  final String author;
  final String coverImagePath;
  final List<int> categoryIDs;
  List<Chapter> chapters;

  Book(this.title, this.author, this.coverImagePath, this.categoryIDs,
      {this.chapters});

  int getSize() {
    int size = title.length + author.length;
    if (chapters == null) return size;
    return size +
        chapters
            .map((Chapter chapter) => chapter.getSize())
            .toList()
            .fold(0, (previousValue, element) => previousValue + element);
  }

  String getSizeString() {
    double size = getSize().toDouble();
    if (size > 1024 * 1024 * 1024) {
      size /= 1024 * 1024 * 1024;
      return size.toStringAsFixed(1) + "GB";
    }
    if (size > 1024 * 1024) {
      size /= 1024 * 1024;
      return size.toStringAsFixed(1) + "MB";
    }
    if (size > 1024) {
      size /= 1024;
      return size.toStringAsFixed(1) + "KB";
    }
    return size.toStringAsFixed(0) + "B";
  }

  static List<Book> fetchAll() {
    return [
      Book(
        "Book 01",
        "Ae_Mc",
        "assets/images/cover_01.jpg",
        [0],
        chapters: [
          Chapter("First chapter", [
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                " Phasellus luctus ante vel eros porttitor, eu condimentum sem"
                " eleifend. Duis faucibus posuere massa, non cursus mauris finibus"
                " ac. Sed in suscipit nulla. Etiam suscipit varius augue. Cras a"
                " blandit tellus. Aenean fermentum porta arcu, a laoreet risus"
                " semper vel. Nullam eget ante cursus enim laoreet condimentum at"
                " ac risus. Aenean efficitur justo sit amet quam laoreet laoreet."
                " Sed vel ipsum a mi aliquam lacinia nec vitae nibh. Nunc id lacus"
                " elementum, varius orci eu, posuere augue. Duis euismod faucibus"
                " justo, eget tristique dui facilisis sed. Lorem ipsum dolor sit"
                " amet, consectetur adipiscing elit. Suspendisse accumsan urna vel"
                " odio dapibus, quis mattis turpis ultricies. Aenean nec augue ex."
                " Phasellus vitae congue sapien. Aliquam vel ullamcorper orci, eu"
                " vehicula magna.",
          ]),
          Chapter("Second chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Third chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Fourth chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Fifth chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Sixth chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Seventh chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
          Chapter("Eighth chapter", [
            "First paragraph",
            "SecondParagraph",
            "Third paragraph",
            "Fourth paragraph",
            "Fifth paragraph",
            "Sixth paragraph",
            "Seventh paragraph",
            "Eighth paragraph",
          ]),
        ],
      ),
      Book(
        "Book 02",
        "Ae_Mc",
        "assets/images/cover_02.jpg",
        [1],
      ),
      Book(
        "Book 03",
        "Ae_Mc",
        "assets/images/cover_03.jpg",
        [2],
      ),
      Book(
        "Book 04",
        "Ae_Mc",
        "assets/images/cover_01.jpg",
        [0, 1, 2],
      ),
      Book(
        "Book 05",
        "Ae_Mc",
        "assets/images/cover_02.jpg",
        [0, 1, 2],
      ),
      Book(
        "Book 06",
        "Ae_Mc",
        "assets/images/cover_03.jpg",
        [0, 1, 2],
      ),
      Book(
        "Book 07",
        "Ae_Mc",
        "assets/images/cover_01.jpg",
        [0, 1, 2],
      ),
      Book(
        "Book 08",
        "Ae_Mc",
        "assets/images/cover_02.jpg",
        [0, 1, 2],
      ),
      Book(
        "Book 09",
        "Ae_Mc",
        "assets/images/cover_03.jpg",
        [0, 1],
      ),
      Book(
        "Ever longer book title contains much words and, maybe, lorem ipsum dor amet",
        "Ae_Mc",
        "assets/images/cover_01.jpg",
        [0, 2],
      ),
      Book(
        "Very long book title without cover",
        "Ae_Mc",
        null,
        [0, 2],
      ),
      Book(
        "Ever longer book title contains much words and, maybe, lorem ipsum dor amet",
        "Ae_Mc",
        null,
        [1, 2],
      ),
    ];
  }
}
