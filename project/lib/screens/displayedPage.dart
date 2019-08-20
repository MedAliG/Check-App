import 'dart:io';
import 'package:clippy_flutter/clippy_flutter.dart';

import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';

class SecondScreen extends StatefulWidget {
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black87.withOpacity(.35),
      bottomNavigationBar: BtmNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingBtn(),
      resizeToAvoidBottomPadding: false,
      body: Container(
          height: height,
          width: width,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: height * .15, left: width * .05),
                padding: EdgeInsets.only(
                    top: height * .05, left: width * .05, right: width * .05),
                height: height * .55,
                width: width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * .1),
                      width: width * .9,
                      child: Text(
                        "Activity reminder",
                        style: TextStyle(fontFamily: "RoboBold", fontSize: 28),
                      ),
                    ),
                    SizedBox(height: height * .1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Receiver Name",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                        Text(
                          "John Doe",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Amount",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                        Text(
                          "245.00DT",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Due Date",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                        Text(
                          "Mon. 24 aug 2018",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "hour",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                        Text(
                          "15:03",
                          style: TextStyle(
                              fontFamily: "Grenze",
                              fontSize: 22,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: height * .085,
                width: width * .3,
                margin: EdgeInsets.only(top: height * .65, left: width * .15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 2)
                    ],
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(5),
                        topLeft: Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Mark as payed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "RoboBold",
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: height * .085,
                width: width * .3,
                margin: EdgeInsets.only(top: height * .65, left: width * .55),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 2)
                    ],
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Snooze ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "RoboBold",
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .175, left: width * .85),
                child: Icon(
                  Icons.close,
                  color: Colors.black87,
                  size: 25,
                ),
              ),
            ],
          )),
    );
  }
}
