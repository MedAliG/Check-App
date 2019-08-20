import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences prefs;
  bool firstVisit = true;
  void initState() {
    _initData();
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => (firstVisit)
            ? Navigator.of(context).pushNamedAndRemoveUntil(
                "/guidelines", (Route<dynamic> route) => false)
            : Navigator.of(context).pushNamedAndRemoveUntil(
                "/home", (Route<dynamic> route) => false));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.green,
            height: height,
            width: width,
            child: Center(
              child: FlareActor(
                "assets/flare/Trim.flr",
                animation: "Untitled",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: height * .8),
            child: Center(
              child: Text(
                "Proxym-IT",
                style: TextStyle(
                    color: Colors.white, fontFamily: "RoboBold", fontSize: 22),
              ),
            ),
          )
        ],
      ),
    );
  }

  _initData() async {
    prefs = await SharedPreferences.getInstance();

    firstVisit = await prefs.getBool("firstVisit");
    if (firstVisit == null) {
      firstVisit = true;
    }
  }
}
