import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:test_haber_proje/screens/login_screen.dart';
import 'package:test_haber_proje/screens/news_screen.dart';
import 'package:test_haber_proje/screens/register_screen.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _authBody(context),
    );
  }

  _appBar() {
    return AppBar(
      title: Text(UITextHelper.mainAppBarText),
    );
  }

  _authBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _registerButton(context),
        _loginButton(context),
      ],
    );
  }

  _loginButton(context) {
    return Container(
      child: SignInButtonBuilder(
        backgroundColor: Colors.orange,
        icon: Icons.verified_user,
        text: UITextHelper.login,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FirebaseAuth.instance.currentUser == null
              ? LoginPage()
              : NewsScreen(),
        )),
      ),
      alignment: Alignment.center,
    );
  }

  _registerButton(context) {
    return Container(
      child: SignInButtonBuilder(
        icon: Icons.person_add,
        backgroundColor: Colors.blue,
        text: UITextHelper.register,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => RegisterPage(),
              ),
              (route) => false);
        },
      ),
      alignment: Alignment.center,
    );
  }
}
