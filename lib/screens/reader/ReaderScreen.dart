import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_reader/models/Book.dart';
import 'package:flutter_reader/models/Chapter.dart';
import 'package:flutter_reader/screens/reader/widgets/SettingsMenu.dart';
import 'package:flutter_reader/style.dart';

class ReaderScreen extends StatefulWidget {
  final Book book;
  ReaderScreen(this.book);

  State<StatefulWidget> createState() => _ReaderScreen();
}

class _ReaderScreen extends State<ReaderScreen> with TickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _animationController;
  double _progress;

  _ReaderScreen();

  scrollListener() {
    setState(() {
      _progress =
          _scrollController.offset / _scrollController.position.maxScrollExtent;
    });
  }

  void callback(String fontFamily, String theme, int size) {
    setState(() {
      TextStyle curStyle = chapterText['style'];
      chapterText['style'] =
          curStyle.copyWith(fontFamily: fontFamily, fontSize: size.toDouble());
      chapterTitleText = chapterTitleText.copyWith(fontSize: size * 2.5);
    });
  }

  @override
  void initState() {
    _progress = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void menuButtonTap() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: readerBackgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _content(),
              Container(
                color: Colors.transparent,
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "assets/icons/long_back_arrow.png",
                        height: 30,
                        width: 30,
                        color: Theme.of(context).shadowColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Theme.of(context).shadowColor,
                          size: 30,
                        ),
                        onPressed: menuButtonTap),
                    IconButton(
                        icon: Icon(
                          Icons.more_horiz_rounded,
                          size: 30,
                          color: Theme.of(context).shadowColor,
                        ),
                        onPressed: null)
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                left: 15,
                right: 15,
                child: Container(
                  height: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text.rich(
                          TextSpan(
                            text: (_progress * 100).toStringAsFixed(0) + '%',
                            style: TextStyle(color: Color(0xFFBBB9C5)),
                          ),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.bottomLeft,
                        widthFactor: _progress,
                        child: Container(
                          constraints: BoxConstraints.expand(height: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.5),
                              color: scrollProgressBarColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PositionedTransition(
                child: SettingsMenu(_animationController, callback),
                rect: RelativeRectTween(
                  begin: RelativeRect.fromSize(
                      Rect.fromLTRB(
                          0, -382, MediaQuery.of(context).size.width, -32),
                      MediaQuery.of(context).size),
                  end: RelativeRect.fromSize(
                      Rect.fromLTRB(
                          0, -2, MediaQuery.of(context).size.width, 350),
                      MediaQuery.of(context).size),
                ).animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.ease),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content() => Padding(
        padding: EdgeInsets.only(top: 45, bottom: 30, right: 15, left: 15),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Html(
            data: _getHtmlFromBook(),
            style: {
              "h1": Style(
                  fontSize: FontSize(chapterText['style'].fontSize * 2.5),
                  fontWeight: chapterTitleText.fontWeight,
                  fontFamily: chapterText['style'].fontFamily,
                  color: chapterText['style'].color,
                  textAlign: TextAlign.center,
                  alignment: Alignment.center),
              "p": Style(
                  fontSize: FontSize(chapterText['style'].fontSize),
                  fontWeight: chapterText['style'].fontWeight,
                  fontFamily: chapterText['style'].fontFamily,
                  textAlign: chapterText['align'],
                  color: chapterText['style'].color),
            },
          ),
        ),
      );

  String _getHtmlFromBook() {
    String result = "";
    widget.book.chapters.forEach((Chapter chapter) {
      result += "<h1>${chapter.title}</h1>";
      chapter.paragraphs.forEach((String paragraph) {
        result += "<p>$paragraph</p>";
      });
    });
    return result;
  }
}
