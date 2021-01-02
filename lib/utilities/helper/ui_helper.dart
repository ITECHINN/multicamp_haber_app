import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UIHelper {
  static const int SPLASH_DURATION = 2500;
  static const String APP_NAME = "Multicamp Haber Projesi";
  static const double APP_VERSION = 0.1;

  static newsRightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  static newsTitle(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  static newsThumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => FlutterLogo(),
        imageUrl: imageUrl,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  static TextStyle fs24() {
    return TextStyle(fontSize: 24);
  }
}
