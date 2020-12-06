class Chapter {
  final String title;
  List<String> paragraphs;

  Chapter(this.title, this.paragraphs);

  int getSize() {
    return title.length +
        paragraphs.map((String paragraph) => paragraph.length).toList().fold(
            0, (num previousValue, int curValue) => previousValue + curValue);
  }
}
