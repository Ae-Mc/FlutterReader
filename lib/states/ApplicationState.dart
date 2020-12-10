import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/models/News.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class ApplicationState with ChangeNotifier {
  ApplicationLoginState _loginState;
  ApplicationLoginState get loginState => _loginState;

  StreamSubscription<QuerySnapshot> _newsSubscription;
  List<News> _news = [];
  List<News> get news => _news;

  String _email;
  String get email => _email;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    String countryCode = await Devicelocale.currentLocale;
    countryCode = (countryCode == "ru_ru") ? "ru" : "en";

    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        _loginState = ApplicationLoginState.loggedOut;
        if(_newsSubscription != null)
          _newsSubscription.cancel();
      } else {
        _newsSubscription =
            FirebaseFirestore.instance.collection('news').snapshots().listen(
          (snapshot) {
            _news = [];
            snapshot.docs.forEach(
              (document) {
                News newsItem = News(
                  document.data()[countryCode]["hintText"],
                  document.data()[countryCode]["headerFirstLine"],
                  document.data()[countryCode]["headerSecondLine"],
                  document.data()["imageUrl"],
                  Color(document.data()["backgroundColor"]),
                );
                _news.add(newsItem);
              },
            );
            notifyListeners();
          },
        );
        _loginState = ApplicationLoginState.loggedIn;
      }
      notifyListeners();
    });
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) return null;
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUpWithUsernameEmailAndPassword(
    String email,
    String password,
  ) async {
    if (email.isEmpty || password.isEmpty) return null;
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  void signOut() async => await FirebaseAuth.instance.signOut();
}
