import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/generated/l10n.dart';
import 'package:flutter_reader/screens/welcome/widgets/InputTextField.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:flutter_reader/style.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  String _email = "", _password = "", _error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                S.current.Login,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 25),
              InputTextField(
                leftIcon: Icons.alternate_email,
                hintText: S.current.Email,
                onChanged: (String text) => _email = text,
              ),
              SizedBox(height: 25),
              InputTextField(
                leftIcon: Icons.lock_outline_rounded,
                hintText: S.current.Password,
                rightIcons: [
                  CupertinoIcons.eye_slash,
                  CupertinoIcons.eye,
                ],
                obscureText: true,
                onChanged: (String text) => _password = text,
                onSubmitted: (String text) => _logInButtonOnTap(context),
              ),
              _error.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                          left: 20, top: 10, right: 20, bottom: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.red[900],
                          ),
                          Expanded(
                            child: Text(
                              _error,
                              style: signInErrorTextStyle,
                              softWrap: true,
                            ),
                          ),
                        ],
                      )),
              SizedBox(height: 25),
              _logInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logInButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _logInButtonOnTap(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).buttonColor,
              Color.lerp(
                Theme.of(context).buttonColor,
                Colors.black,
                0.1,
              ),
            ],
            stops: [0, 1],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            S.current.SignIn,
            style: signInLogInButtonTextStyle,
          ),
        ),
      ),
    );
  }

  void _logInButtonOnTap(BuildContext context) async {
    _error = "";
    ApplicationState applicationState =
        Provider.of<ApplicationState>(context, listen: false);
    try {
      await applicationState.signInWithEmailAndPassword(_email, _password);
    } on FirebaseAuthException catch (exception) {
      setState(() {
        print(exception.code);
        if (exception.code == "invalid-email") {
          _error = S.current.ErrorInvalidEmail;
        } else if (exception.code == "user-not-found") {
          _error = S.current.ErrorUnknownUser;
        } else if (exception.code == "wrong-password") {
          _error = S.current.ErrorWrongPassword;
        }
      });
    }

    if (applicationState.loginState == ApplicationLoginState.loggedIn) {
      print(
          "Name: " + FirebaseAuth.instance.currentUser.displayName.toString());
      Navigator.pop(context);
    }
  }
}
