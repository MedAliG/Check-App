import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:flare_flutter/flare_actor.dart';

class AboutUs extends StatefulWidget {
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool _animation = true;
  @override
  void initState() {
    _resetAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BtmNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AboutUsBtn(),
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              height: height * .3,
              width: width,
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: height * .00),
              child: Image(
                image: AssetImage("assets/right_circle.png"),
              ),
            ),
            Container(
              height: height * .2,
              width: width,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: height * .6),
              child: Image(
                image: AssetImage("assets/left_circle.png"),
              ),
            ),
            Container(
              height: height * .1,
              width: width,
              //color: Colors.red,
              margin: EdgeInsets.only(top: height * .55, right: width * .4),
              child: Image(
                image: AssetImage("assets/small_circle.png"),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: height * .45,
                  width: width,
                  child: Center(
                    child: FlareActor(
                      "assets/flare/wolfy.flr",
                      animation: "Go",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  child: Center(
                    child: Text(
                      "Check ✔",
                      style: TextStyle(fontFamily: "LivvicBold", fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .025,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Free & usefull application to keep tab on their tabs & payments deadlines .The app. is user friendly & provides every user a friendly & smooth experience.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: "Livvic", fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  child: Text(
                    "Proxym Group",
                    style: TextStyle(
                        fontFamily: "RoboBold",
                        fontSize: 20,
                        color: Color(0xFF12BB65)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _resetAnimation() {
    print(_animation);
    Timer(Duration(seconds: 3), () => changeState());
    print(_animation);
  }

  changeState() {
    setState(() {
      _animation = false;
    });
  }
}
