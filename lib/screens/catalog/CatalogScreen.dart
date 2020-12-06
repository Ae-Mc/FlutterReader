import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_reader/main.dart';
import 'package:flutter_reader/models/Book.dart';
import 'package:flutter_reader/models/Category.dart';
import 'package:flutter_reader/screens/catalog/widgets/BookCard.dart';
import 'package:flutter_reader/generated/l10n.dart';
import 'package:flutter_reader/screens/catalog/widgets/NewsCarousel.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogScreen();
  }
}

class _CatalogScreen extends State<CatalogScreen> {
  int _choosedCategory;

  @override
  void initState() {
    super.initState();
    _choosedCategory = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(context),
                SizedBox(height: 30),
                _searchBox(context),
                SizedBox(height: 25),
                _newsCard(context),
                SizedBox(height: 25),
                _categories(context),
                SizedBox(height: 25),
                _books(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 5,
            ),
            IconButton(
              icon: Image.asset("assets/icons/FourDots.png"),
              onPressed: () => Navigator.pushNamed(context, WelcomeRoute),
              iconSize: 20,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              S.of(context).Books,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        GestureDetector(
          onTap: () =>
              Provider.of<ApplicationState>(context, listen: false).signOut(),
          child: Icon(
            Icons.logout,
            size: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _searchBox(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 13,
          ),
          Icon(
            Icons.search,
            size: 18,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 9,
          ),
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                hintText: S.current.SearchBooks,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.025),
                offset: Offset(0, 20),
                blurRadius: 20,
                spreadRadius: 0)
          ]),
    );
  }

  Widget _newsCard(BuildContext context) {
    return NewsCarousel();
  }

  Widget _categories(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).Categories,
              style: Theme.of(context).textTheme.headline5,
            ),
            IconButton(
              icon: Image.asset(
                "assets/icons/Settings.png",
                width: 24,
                height: 18,
              ),
              onPressed: null,
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 53,
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 25, right: 10),
              itemCount: Category.allCategories().length,
              itemBuilder: (context, index) {
                Category category = Category.allCategories()[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _choosedCategory = category.id;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: category.id == _choosedCategory
                          ? Border.all(color: category.color, width: 2)
                          : Border.all(
                              color: category.color.withOpacity(0.5),
                              width: 2,
                              style: BorderStyle.none),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 31),
                    margin: EdgeInsets.only(right: 15),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: category.name,
                          style: TextStyle(
                              color: category.color,
                              fontWeight: FontWeight.w700),
                        ),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _books(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).Books,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 260),
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: 260,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 25, right: 10),
              children: Book.fetchAll()
                  .where((element) =>
                      element.categoryIDs.contains(_choosedCategory))
                  .map(
                    (Book book) => BookCard(book),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
