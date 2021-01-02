import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:test_haber_proje/screens/news_screen.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';

class EmailPasswordForm extends StatefulWidget {
  @override
  _EmailPasswordFormState createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //? Bilgi
              Container(
                child: Text(
                  UITextHelper.loginWithEmail,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.center,
              ),
              //? E-Mail
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-Posta"),
                validator: (String mail) {
                  if (mail.isEmpty) return UITextHelper.emailIsEmpty;
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              //? Şifre
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Şifre"),
                validator: (String password) {
                  if (password.isEmpty) return UITextHelper.passwordIsEmpty;
                  return null;
                },
                obscureText: true,
              ),
              Container(
                padding: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.center,
                child: SignInButton(Buttons.Email,
                    text: UITextHelper.loginWithEmail, onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signIn();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final User user = userCredential.user;

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('${UITextHelper.welcome} ${user.email}'),
        ),
      );
      if (user != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => NewsScreen(),
            ),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
