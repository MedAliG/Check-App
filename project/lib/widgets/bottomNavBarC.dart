import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'dart:async';

class BtmNavBar extends StatefulWidget {
  _BtmNavBar createState() => new _BtmNavBar();
}

class _BtmNavBar extends State<BtmNavBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * .07,
      child: BottomAppBar(
        notchMargin: 6.0,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 2.5,
        child: Hero(
          tag: 'nv',
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/home');
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        height: height * .032,
                        child: Image(
                          image: AssetImage("assets/home.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                  child: Container(
                    child: Center(
                      child: Container(
                        height: height * .032,
                        child: Image(
                          image: AssetImage("assets/list.png"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/add');
      },
      child: Hero(
        tag: 'add',
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF00CA71),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
          margin: EdgeInsets.only(top: 1),
          padding: EdgeInsets.all(18),
          child: Container(
            height: height * .026,
            child: Image(
              image: AssetImage("assets/plus.png"),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraFloatingBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/add');
      },
      child: Hero(
        tag: 'add',
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF00CA71),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
          margin: EdgeInsets.only(top: 1),
          padding: EdgeInsets.all(18),
          child: Container(
            height: height * .026,
            child: Image(
              image: AssetImage(
                "assets/camera.png",
              ),
              height: height * .15,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingInd extends StatelessWidget {
  int _status = 1;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          //Navigator.pop(context);
          Navigator.of(context).pushNamed("/home");
        },
        child: Hero(
          tag: 'add',
          child: Container(
            height: height * .07,
            width: height * .07,
            decoration: BoxDecoration(
                color: Color(0xFF00CA71),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.all(14),
            child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ));
  }
}

class LoadingIndSucc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          //Navigator.pop(context);
          Navigator.of(context).pushNamed("/home");
        },
        child: Hero(
          tag: 'add',
          child: Container(
            height: height * .0725,
            width: height * .0725,
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            //margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.all(0),
            child: FlareActor(
              "assets/flare/tik.flr",
              animation: "Untitled",
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}

class CancelBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        //Navigator.pop(context);
        Navigator.of(context).pushNamed("/home");
      },
      child: Hero(
        tag: 'add',
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
          margin: EdgeInsets.only(top: 1),
          padding: EdgeInsets.all(14),
          child: Container(
            height: height * .03,
            child: Image(
              image: AssetImage(
                "assets/x.png",
              ),
              height: height * .15,
            ),
          ),
        ),
      ),
    );
  }
}
