import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reader/generated/l10n.dart';
import 'package:flutter_reader/screens/welcome/widgets/InputTextField.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:flutter_reader/style.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
  String _name = "", _email = "", _password = "", _error = "";

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
                S.current.Registration,
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 25),
              InputTextField(
                leftIcon: Icons.account_circle_outlined,
                hintText: S.current.Username,
                onChanged: (String text) => _name = text,
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
                onSubmitted: (String text) => _signUpButtonOnTap(context),
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
      onTap: () => _signUpButtonOnTap(context),
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
            S.current.SignUp,
            style: signInLogInButtonTextStyle,
          ),
        ),
      ),
    );
  }

  void _signUpButtonOnTap(BuildContext context) async {
    UserCredential userCredential;
    print("Name: $_name\nEmail: $_email\nPassword: $_password");
    _error = "";
    ApplicationState applicationState =
        Provider.of<ApplicationState>(context, listen: false);
    try {
      userCredential =
          await applicationState.signUpWithUsernameEmailAndPassword(
        _email,
        _password,
      );
    } on FirebaseAuthException catch (exception) {
      setState(() {
        print(exception.code);
        switch (exception.code) {
          case "invalid-email":
            _error = S.current.ErrorInvalidEmail;
            break;
          case "email-already-in-use":
            _error = S.current.ErrorEmailAlreadyInUse;
            break;
          case "wrong-password":
            _error = S.current.ErrorWrongPassword;
            break;
        }
      });
    }

    if (userCredential != null) {
      await applicationState.signInWithEmailAndPassword(_email, _password);
      FirebaseAuth.instance.currentUser.updateProfile(displayName: _name);
    }
    if (applicationState.loginState == ApplicationLoginState.loggedIn) {
      Navigator.pop(context);
    }
  }
}
