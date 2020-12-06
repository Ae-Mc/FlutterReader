// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Категории`
  String get Categories {
    return Intl.message(
      'Категории',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Книги`
  String get Books {
    return Intl.message(
      'Книги',
      name: 'Books',
      desc: '',
      args: [],
    );
  }

  /// `Поиск книг`
  String get SearchBooks {
    return Intl.message(
      'Поиск книг',
      name: 'SearchBooks',
      desc: '',
      args: [],
    );
  }

  /// `Вход`
  String get Login {
    return Intl.message(
      'Вход',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Войти`
  String get SignIn {
    return Intl.message(
      'Войти',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get Registration {
    return Intl.message(
      'Регистрация',
      name: 'Registration',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get SignUp {
    return Intl.message(
      'Зарегистрироваться',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Имя пользователя`
  String get Username {
    return Intl.message(
      'Имя пользователя',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get Email {
    return Intl.message(
      'E-mail',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get Password {
    return Intl.message(
      'Пароль',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Создать аккаунт`
  String get CreateAnAccount {
    return Intl.message(
      'Создать аккаунт',
      name: 'CreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Электронная почта уже используется.`
  String get ErrorEmailAlreadyInUse {
    return Intl.message(
      'Электронная почта уже используется.',
      name: 'ErrorEmailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Неверно введён адрес электронной почты.`
  String get ErrorInvalidEmail {
    return Intl.message(
      'Неверно введён адрес электронной почты.',
      name: 'ErrorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Не найден пользователь с таким адресом электронной почты.`
  String get ErrorUnknownUser {
    return Intl.message(
      'Не найден пользователь с таким адресом электронной почты.',
      name: 'ErrorUnknownUser',
      desc: '',
      args: [],
    );
  }

  /// `Неверный пароль.`
  String get ErrorWrongPassword {
    return Intl.message(
      'Неверный пароль.',
      name: 'ErrorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Добро пожаловать на новую платформу\nэлектронного обучения. Давайте учиться.`
  String get WelcomeMessage {
    return Intl.message(
      'Добро пожаловать на новую платформу\nэлектронного обучения. Давайте учиться.',
      name: 'WelcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Наука`
  String get Science {
    return Intl.message(
      'Наука',
      name: 'Science',
      desc: '',
      args: [],
    );
  }

  /// `Математика`
  String get Mathematics {
    return Intl.message(
      'Математика',
      name: 'Mathematics',
      desc: '',
      args: [],
    );
  }

  /// `Экономика`
  String get Economy {
    return Intl.message(
      'Экономика',
      name: 'Economy',
      desc: '',
      args: [],
    );
  }

  /// `Шрифт`
  String get Typography {
    return Intl.message(
      'Шрифт',
      name: 'Typography',
      desc: '',
      args: [],
    );
  }

  /// `Цвет фона`
  String get BackgroundColor {
    return Intl.message(
      'Цвет фона',
      name: 'BackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `Размер`
  String get Size {
    return Intl.message(
      'Размер',
      name: 'Size',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}