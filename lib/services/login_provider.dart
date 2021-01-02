import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginProvider extends StatefulWidget {
  final String infoText;
  final Buttons buttonType;
  final Function loginMethod;

  const LoginProvider({
    Key key,
    @required this.infoText,
    @required this.buttonType,
    @required this.loginMethod,
  }) : super(key: key);
  @override
  _LoginProviderState createState() => _LoginProviderState();
}

class _LoginProviderState extends State<LoginProvider> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.infoText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              alignment: Alignment.center,
              child: SignInButton(
                widget.buttonType,
                text: widget.infoText,
                onPressed: () async => widget.loginMethod(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
