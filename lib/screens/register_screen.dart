import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:test_haber_proje/screens/news_screen.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _status;
  String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UITextHelper.registerAppBarText),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: UITextHelper.email),
                    validator: (String mail) {
                      if (mail.isEmpty) {
                        return UITextHelper.emailIsEmpty;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration:
                        InputDecoration(labelText: UITextHelper.password),
                    validator: (String password) {
                      if (password.isEmpty) {
                        return UITextHelper.passwordIsEmpty;
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: SignInButtonBuilder(
                      backgroundColor: Colors.amber,
                      icon: Icons.person_add,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _register();
                        }
                      },
                      text: UITextHelper.register,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(_status == null ? '' : _message ?? ''),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User user = userCredential.user;

      if (user != null) {
        setState(() {
          _message = "${UITextHelper.welcome} ${user.email}";
          _status = true;
        });
      } else {
        setState(() {
          _message = UITextHelper.globalError;
          _status = false;
        });
        if (user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewsScreen(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message.toString();
        _status = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
