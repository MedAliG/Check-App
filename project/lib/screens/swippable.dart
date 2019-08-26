import 'package:flutter/material.dart';

class Swipo extends StatefulWidget {
  _SwipoState createState() => _SwipoState();
}

class _SwipoState extends State<Swipo> {
  int _itemCount = 3;
  int _state = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int index) {
                return _items(index);
              },
            ),
          ),
          (_state == 1)
              ? Container(
                  height: height,
                  width: width,
                  color: Colors.black87.withOpacity(.8),
                  child: Center(
                    child: Container(
                      height: height * .15,
                      width: width * .7,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Text("confirum"),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text("cancel"),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  _items(int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dismissible(
      key: Key(index.toString()),
      onDismissed: (direction) {
        setState(() {
          _state = 0;
          _itemCount--;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: height * .05),
        height: height * .2,
        width: width * .7,
        color: Colors.red,
      ),
    );
  }
}
