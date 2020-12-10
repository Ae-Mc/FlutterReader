import 'package:flutter/material.dart';
import 'package:flutter_reader/generated/l10n.dart';
import 'package:flutter_reader/main.dart';
import 'package:flutter_reader/states/ApplicationState.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  bool _popped;

  void applicationStateListener(BuildContext context) {
    if (Provider.of<ApplicationState>(
              context,
              listen: false,
            ).loginState ==
            ApplicationLoginState.loggedIn &&
        !_popped) {
      print(Navigator.canPop(context));
      Navigator.pop(context);
      _popped = true;
    }
  }

  @override
  void initState() {
    _popped = false;
    Future.delayed(Duration.zero, () {
      if (Provider.of<ApplicationState>(
            context,
            listen: false,
          ).loginState ==
          ApplicationLoginState.loggedIn)
        Navigator.pop(context);
      else
        Provider.of<ApplicationState>(
          context,
          listen: false,
        ).addListener(() => applicationStateListener(context));
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<ApplicationState>()
          .removeListener(() => applicationStateListener(context));
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EDE2),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/SignInBackground.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 64,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                        children: [
                          TextSpan(
                              text: "Fox",
                              style: TextStyle(
                                  color: Theme.of(context).buttonColor)),
                          TextSpan(text: "learn")
                        ],
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor)),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 5),
                  Text(
                    S.current.WelcomeMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(SignInRoute),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 115),
                      decoration: BoxDecoration(
                        color: Theme.of(context).buttonColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 15),
                              color: Theme.of(context)
                                  .buttonColor
                                  .withOpacity(0.24),
                              blurRadius: 15)
                        ],
                      ),
                      child: Text(
                        S.current.SignIn,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                  SizedBox(height: 26),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(RegistrationRoute),
                    child: Text(
                      S.current.CreateAnAccount,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
