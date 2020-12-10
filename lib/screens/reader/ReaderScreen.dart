import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_reader/models/Book.dart';
import 'package:flutter_reader/models/Chapter.dart';
import 'package:flutter_reader/screens/reader/widgets/SettingsMenu.dart';
import 'package:flutter_reader/states/ReaderState.dart';
import 'package:flutter_reader/style.dart';
import 'package:provider/provider.dart';

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

  scrollListener(BuildContext context) {
    context.read<ReaderState>().offset = _scrollController.offset;
    setState(() {
      _progress =
          _scrollController.offset / _scrollController.position.maxScrollExtent;
    });
  }

  @override
  void initState() {
    _progress = 0;
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(context.read<ReaderState>().offset,
          duration: Duration(milliseconds: 100), curve: Curves.ease);
      _scrollController.addListener(() => scrollListener(context));
    });
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
      child: Consumer<ReaderState>(
        builder: (context, state, _) => Scaffold(
          backgroundColor: state.theme.backgroundColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _content(context, state),
                _headerBar(context, state),
                _progressBar(context, state),
                _settingsMenu(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, ReaderState state) => Padding(
        padding: EdgeInsets.only(top: 45, bottom: 30, right: 15, left: 15),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Html(
            data: _getHtmlFromBook(),
            style: {
              "h1": Style(
                  fontSize: FontSize(state.headerSize),
                  fontWeight: chapterTitleText.fontWeight,
                  fontFamily: state.fontFamily,
                  color: state.theme.textColor,
                  textAlign: TextAlign.center,
                  alignment: Alignment.center),
              "p": Style(
                  fontSize: FontSize(state.fontSize.toDouble()),
                  fontWeight: chapterText['style'].fontWeight,
                  fontFamily: state.fontFamily,
                  textAlign: chapterText['align'],
                  color: state.theme.textColor),
            },
          ),
        ),
      );

  Widget _headerBar(BuildContext context, ReaderState state) {
    return Container(
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
              color: Color.lerp(
                state.theme.textColor,
                state.theme.backgroundColor,
                0.5,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
              icon: Icon(
                Icons.menu,
                color: Color.lerp(
                  state.theme.textColor,
                  state.theme.backgroundColor,
                  0.5,
                ),
                size: 30,
              ),
              onPressed: menuButtonTap),
          IconButton(
              icon: Icon(
                Icons.more_horiz_rounded,
                size: 30,
                color: Color.lerp(
                  state.theme.textColor,
                  state.theme.backgroundColor,
                  0.5,
                ),
              ),
              onPressed: null)
        ],
      ),
    );
  }

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

  Widget _progressBar(BuildContext context, ReaderState state) {
    return Positioned(
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
                  style: TextStyle(
                    color: Color.lerp(
                      state.theme.textColor,
                      state.theme.backgroundColor,
                      0.5,
                    ),
                  ),
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
                  color: Color.lerp(
                    state.theme.textColor,
                    state.theme.backgroundColor,
                    0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsMenu(BuildContext context) {
    return PositionedTransition(
      child: SettingsMenu(_animationController),
      rect: RelativeRectTween(
        begin: RelativeRect.fromSize(
            Rect.fromLTRB(0, -382, MediaQuery.of(context).size.width, -32),
            MediaQuery.of(context).size),
        end: RelativeRect.fromSize(
            Rect.fromLTRB(0, -2, MediaQuery.of(context).size.width, 350),
            MediaQuery.of(context).size),
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease),
      ),
    );
  }
}
