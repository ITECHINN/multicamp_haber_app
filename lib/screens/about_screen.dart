import 'package:flutter/material.dart';
import 'package:test_haber_proje/utilities/helper/text_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(UITextHelper.about),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          16,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _button(Colors.blue, "@itechinn", FontAwesomeIcons.twitter,
                  "https://twitter.com/itechinn"),
              _button(Colors.redAccent, "E-Posta", FontAwesomeIcons.mailBulk,
                  "mailto:hasmet.olcay@gmail.com"),
            ],
          ),
        ),
      ),
    );
  }

  _button(Color color, String text, IconData icon, [String url]) {
    return Flexible(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(8),
        child: RaisedButton(
          onPressed: () {
            if (url.isNotEmpty) {
              _launchURL(url);
            }
          },
          color: color,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: FaIcon(icon),
                onPressed: () {},
              ),
              SizedBox(width: 6),
              Text(text, style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
