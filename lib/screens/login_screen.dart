import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';
import 'package:test_haber_proje/utilities/widgets/login_form.dart';
import '../services/login_provider.dart';
import 'news_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UITextHelper.loginAppBar),
      ),
      body: _LoginBody(),
    );
  }
}

class _LoginBody extends StatefulWidget {
  @override
  __LoginBodyState createState() => __LoginBodyState();
}

class __LoginBodyState extends State<_LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          EmailPasswordForm(),
          LoginProvider(
            infoText: UITextHelper.loginWithGoogle,
            buttonType: Buttons.Google,
            loginMethod: () async => _signInWithGoogle(),
          ),
        ],
      ),
    );
  }

  _signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User user = userCredential.user;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${UITextHelper.welcome} ${user.displayName}'),
        ),
      );
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => NewsScreen(),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.code),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
