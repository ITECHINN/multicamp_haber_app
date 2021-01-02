import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test_haber_proje/screens/about_screen.dart';
import 'package:test_haber_proje/screens/auth_screen.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';
import 'package:test_haber_proje/utilities/helper/ui_helper.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UITextHelper.settings),
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Container(
      child: Column(
        children: [
          _pageList(context),
          Spacer(),
          _bottomRow(context),
        ],
      ),
    );
  }

  _pageList(context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                      ),
                    );
                  },
                  title: Center(
                      child: Text(
                    UITextHelper.about,
                    style: UIHelper.fs24(),
                  )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _bottomRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Center(
                    child: Text(
                        '${UIHelper.APP_NAME} v${UIHelper.APP_VERSION.toString()}')),
              ),
              ListTile(
                tileColor: Colors.red,
                onTap: () async {
                  FirebaseAuth.instance.signOut();
                  if (await GoogleSignIn().isSignedIn()) {
                    await GoogleSignIn().signOut();
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                    ),
                    (route) => false,
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        UITextHelper.logout,
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
