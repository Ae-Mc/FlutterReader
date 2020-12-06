import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/models/News.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:provider/provider.dart';

class NewsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 460),
      child: OverflowBox(
        maxHeight: 460,
        maxWidth: MediaQuery.of(context).size.width,
        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => CarouselSlider(
            options: CarouselOptions(
              height: 460,
              autoPlay: true,
            ),
            items: appState.news
                .map((News news) => _buildNews(context, news))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNews(BuildContext context, News news) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        fit: StackFit.loose,
        overflow: Overflow.clip,
        children: [
          Container(
            margin: EdgeInsets.only(left: 28, right: 30, top: 115),
            constraints: BoxConstraints.expand(height: 345),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: news.backgroundColor.withOpacity(0.1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 13, right: 22, top: 65),
            constraints: BoxConstraints.expand(height: 375),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: news.backgroundColor.withOpacity(0.2),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 420),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: news.backgroundColor,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: -5,
            child: Container(
              constraints: BoxConstraints.expand(height: 420),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      constraints: BoxConstraints.expand(height: 260),
                      child: CachedNetworkImage(
                        imageUrl: news.imageUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 27.58,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.hintText,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: news.headerFirstLine,
                                  style: Theme.of(context).textTheme.headline4,
                                  children: [
                                    TextSpan(
                                      text: '\n' + news.headerSecondLine,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
