import 'package:flutter/material.dart';
import 'package:flutter_reader/BookReaderApp.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:provider/provider.dart';

const CatalogRoute = '/';
const ReaderRoute = '/reader';
const WelcomeRoute = '/welcome';
const SignInRoute = '/welcome/SignIn';
const RegistrationRoute = '/welcome/Registration';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationState>(
      create: (context) => ApplicationState(),
      builder: (context, _) => BookReaderApp(),
      lazy: false,
    );
  }
}
