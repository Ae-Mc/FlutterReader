import 'package:flutter_reader/screens/welcome/screens/LoginScreen.dart';
import 'package:flutter_reader/screens/welcome/screens/RegistrationScreen.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reader/screens/catalog/CatalogScreen.dart';
import 'package:flutter_reader/screens/reader/ReaderScreen.dart';
import 'package:flutter_reader/screens/welcome/WelcomeScreen.dart';
import 'package:flutter_reader/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class BookReaderApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: "Book Reader",
      onGenerateRoute: routes,
      initialRoute: WelcomeRoute,
      theme: ThemeData(
        fontFamily: "Gilroy",
        primaryColor: primaryColor,
        accentColor: accentColor,
        buttonColor: buttonColor,
        shadowColor: shadowColor,
        backgroundColor: backgroundColor,
        scaffoldBackgroundColor: backgroundColor,
        textTheme: myTextTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case CatalogRoute:
        screen = CatalogScreen();
        break;
      case ReaderRoute:
        screen = ReaderScreen(args['book']);
        break;
      case WelcomeRoute:
        screen = WelcomeScreen();
        break;
      case SignInRoute:
        screen = SignInScreen();
        break;
      case RegistrationRoute:
        screen = RegistrationScreen();
        break;
    }
    return MaterialPageRoute(builder: (_) => screen);
  }
}