import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_haber_proje/screens/auth_screen.dart';
import 'package:test_haber_proje/screens/news_screen.dart';
import 'package:test_haber_proje/utilities/helper/ui_helper.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

  void _navigateToHomePage() {
    Future.delayed(
      Duration(milliseconds: UIHelper.SPLASH_DURATION),
      () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => FirebaseAuth.instance.currentUser == null
                ? AuthScreen()
                : NewsScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
