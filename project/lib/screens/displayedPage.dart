import 'dart:async';

import 'package:Check/objects/database.dart';
import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';

class SecondScreen extends StatefulWidget {
  final int id;
  SecondScreen({Key key, @required this.id}) : super(key: key);
  _SecondScreenState createState() => _SecondScreenState(id);
}

class _SecondScreenState extends State<SecondScreen> {
  final int id;
  final dbHelper = DatabaseHelper.instance;
  Map<String, dynamic> data;
  int animation = 0;
  _SecondScreenState(this.id);
  @override
  void initState() {
    _initData();
    super.initState();
    //print("dis is za id " + data["_id"]);
  }

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
                  color: (animation == 0)
                      ? Colors.white
                      : Colors.black87.withOpacity(.35),
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
                        data["name"],
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
                        data["amount"].toString() + "DT",
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
                        convertDateToString(data["deliverDate"]),
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
                        data["time"],
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
            GestureDetector(
              onTap: () {
                _changeState();
              },
              child: Container(
                height: height * .085,
                width: width * .3,
                margin: EdgeInsets.only(top: height * .65, left: width * .15),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 2)
                    ],
                    color: (animation == 0)
                        ? Colors.lightBlue
                        : Colors.black87.withOpacity(.35),
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
                        color: (animation == 0)
                            ? Colors.white
                            : Colors.transparent),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _snooze();
              },
              child: Container(
                height: height * .085,
                width: width * .3,
                margin: EdgeInsets.only(top: height * .65, left: width * .55),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black54, blurRadius: 2)
                    ],
                    color: (animation == 0)
                        ? Colors.green
                        : Colors.black87.withOpacity(.35),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
                child: Center(
                  child: Text(
                    "Snooze",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "RoboBold",
                        fontSize: 18,
                        color: (animation == 0)
                            ? Colors.white
                            : Colors.transparent),
                  ),
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
            _setData(),
          ],
        ),
      ),
    );
  }

  _setData() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (animation == 1) {
      return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(20),
        child: Center(
          child: FlareActor(
            "assets/flare/check.flr",
            animation: "Untitled",
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _initData() async {
    print("id" + id.toString());
    List<Map<String, dynamic>> ll = await dbHelper.getRow(id);
    if (ll.isEmpty) {
      print("no data found");
    } else {
      setState(() {
        data = ll[0];
      });
      print("data set");
    }
  }

  _snooze() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  _changeState() {
    setState(() {
      animation = 1;
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushNamed("/home");
      });
    });
    dbHelper.changeState(id);
  }

  String convertDateToString(String dde) {
    DateTime parsedDate = DateTime.parse(dde);
    //print("parsedDate :" + parsedDate.toIso8601String());
    DateTime tm = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
    //return tm.toIso8601String();

    DateTime today = DateTime.now();
    String month;

    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sept";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
    }

    DateTime thisday = DateTime.now();
    DateTime yesterday = thisday.subtract(Duration(days: 1));
    Duration difference = today.difference(tm);
    //print("difference : " + difference.toString());
    //DateTime difference = DateTime.now();
    String dateS;
    if ((thisday.day == tm.day) &&
        (thisday.year == tm.year) &&
        (thisday.month == tm.month)) {
      dateS = "Today";
      //print("somehow its today :v");
      return '$dateS, ${tm.day} $month ${tm.year}';
    } else if ((yesterday.day == tm.day) &&
        (yesterday.year == tm.year) &&
        (yesterday.month == tm.month)) {
      dateS = "Yesterday";
      dateS = "$dateS, ${tm.day} $month ${tm.year}";
      return dateS;
    } else {
      switch (tm.weekday) {
        case 1:
          dateS = "Mon";
          break;
        case 2:
          dateS = "Tue";
          break;
        case 3:
          dateS = "Wed";
          break;
        case 4:
          dateS = "Thu";
          break;
        case 5:
          dateS = "Fri";
          break;
        case 6:
          dateS = "Sat";
          break;
        case 7:
          dateS = "Sun";
          break;
      }
      //print("month : " + month);
      return '$dateS, ${parsedDate.day} $month ${tm.year}';
    }
  }
}
