import 'dart:core';

import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:Check/screens/singleItem.dart';
import 'package:Check/objects/database.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  int _allItemCount = 0;
  int _activeItemCount = 0;
  String _state = "active";
  List<Map<String, dynamic>> dataAll = [];
  List<Map<String, dynamic>> dataActive = [];
  @override
  void initState() {
    //_emptyAll();
    
    _initData();
    _itemCount();

    print(_allItemCount);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BtmNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingBtn(),
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        width: width,
        //padding: EdgeInsets.only(top: height*.05),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: height * .015),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 10)
              ]),
              child: Column(
                children: <Widget>[
                  Container(
                    //height: height * .15,
                    width: width,
                    decoration: BoxDecoration(color: Colors.white),
                    padding:
                        EdgeInsets.only(top: height * .04, left: width * .075),
                    child: Text(
                      "Activities",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "RoboBold",
                          fontSize: height * .04),
                    ),
                  ),
                  SizedBox(
                    height: height * .015,
                  ),
                  Container(
                    width: width,
                    //decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _state = "active";
                            });
                          },
                          child: Container(
                            width: width * .5,
                            height: height * .06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: (_state == "active")
                                            ? Color(0xFF12BB65)
                                            : Colors.transparent,
                                        width: height * .005))),
                            child: Center(
                              child: Text(
                                "Active Events",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "RoboBold",
                                    fontSize: height * .022),
                              ),
                            ),
                            //padding: EdgeInsets.only(top: 5),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            //_emptyAll();
                            setState(() {
                              _state = "all";
                            });
                          },
                          child: Container(
                            width: width * .5,
                            height: height * .06,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: (_state == "all")
                                            ? Color(0xFF12BB65)
                                            : Colors.transparent,

                                        //color: Color(0xFF12BB65),
                                        width: height * .005))),
                            child: Center(
                              child: Text(
                                "All events",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Robo",
                                    fontSize: height * .022),
                              ),
                            ),
                            //padding: EdgeInsets.only(top: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: width * .025, right: width * .025),
              width: width,
              height: height * .7275,
              child: (_state == "active")
                  ? ListView.builder(
                      itemCount: _activeItemCount,
                      itemBuilder: (BuildContext context, int index) {
                        //return _itemActive(index, m);
                        return _itemCreate2(index, dataActive[index]);
                        //print(convertDateToString(m['deliverDate']));
                      })
                  : ListView.builder(
                      itemCount: _allItemCount,
                      itemBuilder: (BuildContext context, int index) {
                        return _itemCreate2(index, dataAll[index]);

                        //print(convertDateToString(m['deliverDate']));
                      }),
            )
          ],
        ),
      ),
    );
  }

  _itemAll(int x, Map data) {
    List<Color> list = [
      Color(0xFFFFDFFD),
      Color(0xFFD5C67A),
      Color(0xFFF1A208),
      Color(0xFF4D9DE0),
      Color(0xFF7768AE),
      //Color(0xFF12BB65)
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: height * .02),
        height: height * .1,
        width: width * .9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 0)
            ]),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'Date' + x.toString(),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: height * .1,
                  width: width * .35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: list[x % 5]),
                  child: Center(
                    child: Text(
                      //data["deliverDate"],
                      convertDateToString(data['deliverDate']),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "RoboBold"),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * .1,
              width: width * .5,
              padding: EdgeInsets.only(left: width * .05),
              //decoration: BoxDecoration(color: Colors.red),
              child: Column(
                children: <Widget>[
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.only(top: height * .01),
                    height: height * .06,
                    width: width * .5,
                    child: Text(
                      data["amount"].toString() + "DT",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "RoboBold",
                          color: Colors.black,
                          fontSize: height * .03),
                    ),
                  ),
                  Container(
                    height: height * .04,
                    width: width * .5,
                    child: Text(
                      data["name"],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Robo",
                          color: Colors.black54,
                          fontSize: height * .017),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * .1,
              width: width * .09,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                  size: 30,
                ),
              ),
              //color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

/*
  _itemActive(int x, Map data) {
    List<Color> list = [
      //Color(0xFFFFFFFF),
      Color(0xFFD5C67A),
      Color(0xFFF1A208),
      Color(0xFF4D9DE0),
      Color(0xFF7768AE),
      Color(0xFF12BB65)
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: height * .02),
        height: height * .1,
        width: width * .9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 0)
            ]),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'Date' + x.toString(),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  height: height * .1,
                  width: width * .35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: list[x % 5]),
                  child: Center(
                    child: Text(
                      convertDateToString(data['deliverDate']),
                      style: TextStyle(
                          color: Colors.white, fontFamily: "RoboBold"),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: height * .1,
              width: width * .5,
              padding: EdgeInsets.only(left: width * .05),
              //decoration: BoxDecoration(color: Colors.red),
              child: Column(
                children: <Widget>[
                  Container(
                    //color: Colors.red,
                    padding: EdgeInsets.only(top: height * .01),
                    height: height * .06,
                    width: width * .5,
                    child: Text(
                      data["amount"].toString() + "DT",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "RoboBold",
                          color: Colors.black,
                          fontSize: height * .03),
                    ),
                  ),
                  Container(
                    height: height * .04,
                    width: width * .5,
                    child: Text(
                      data["name"],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: "Robo",
                          color: Colors.black54,
                          fontSize: height * .017),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: height * .1,
              width: width * .09,
              child: Center(
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                  size: 30,
                ),
              ),
              //color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
*/
  /*_itemCreate(int x, Map data) {
    List<String> images = [
      "assets/palm-tree.png",
      "assets/sunbed.png",
      "assets/sunrise.png",
      "assets/trailer.png"
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(
          top: height * .015,
          bottom: height * .015,
          right: width * .01,
          left: width * .01),
      height: height * .2,
      width: width * .88,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)]),
      child: Row(
        children: <Widget>[
          Container(
            height: height * .2,
            width: width * .55,
            //padding: EdgeInsets.only(top: height * .03, left: width * .1),
            //color: Colors.red,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: height * .04, left: width * .1),
                  height: height * .09,
                  width: width * .55,
                  child: Text(
                    data["amount"].toString() + " DT",
                    style: TextStyle(fontFamily: "RoboBold", fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: width * .1),
                  height: height * .035,
                  width: width * .55,
                  child: Text(
                    data["name"],
                    style: TextStyle(
                        fontFamily: 'Grenze',
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: width * .1),
                  height: height * .03,
                  width: width * .55,
                  child: Text(
                    convertDateToString(data['deliverDate']),
                    style: TextStyle(
                        fontFamily: 'Grenze',
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height * .16,
            width: width * .30,
            //color: Colors.red,
            padding: EdgeInsets.only(top: height * 04, right: width * .04),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(images[x % 4]))),
          )
        ],
      ),
    );
  }
*/
  _itemCreate2(int x, Map data) {
    List<String> images = [
      "assets/pic2.png",
      "assets/pic3.png",
      "assets/pic1.png",
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SingleItem(x: x, data: data, image: images[x % 3])),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
            top: height * .015,
            bottom: height * .015,
            right: width * .01,
            left: width * .01),
        height: height * .2,
        width: width * .88,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)]),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: width * .38,
                  height: height * .2,
                ),
                Hero(
                  tag: "item" + x.toString(),
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: height * .2,
                      width: width * .5,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(images[x % 3]))),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: height * .2,
              width: width * .88,
              child: Row(
                children: <Widget>[
                  Container(
                    height: height * .2,
                    width: width * .55,
                    //padding: EdgeInsets.only(top: height * .03, left: width * .1),
                    //color: Colors.red,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: height * .04, left: width * .1),
                          height: height * .09,
                          width: width * .55,
                          child: Text(
                            data["amount"].toString() + " DT",
                            style:
                                TextStyle(fontFamily: "RoboBold", fontSize: 25),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: width * .1),
                          height: height * .035,
                          width: width * .55,
                          child: Text(
                            data["name"],
                            style: TextStyle(
                                fontFamily: 'Grenze',
                                fontSize: 18,
                                color: Colors.black54),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: width * .1),
                          height: height * .03,
                          width: width * .55,
                          child: Text(
                            convertDateToString(data['deliverDate']),
                            style: TextStyle(
                                fontFamily: 'Grenze',
                                fontSize: 18,
                                color: Colors.black54),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initData() async {
    List<Map<String, dynamic>> dataSet = await dbHelper.queryAllRows();
    List<Map<String, dynamic>> dataSet2 = await dbHelper.queryActiveRows();
    print('query all rows:');
    dataSet.forEach((row) => print(row));
    setState(() {
      dataAll = dataSet;
      dataActive = dataSet2;
    });
    print("data set");
    await dbHelper.autoUpdateActivity();
  }

  _itemCount() async {
    final a = await dbHelper.activeRowCount();
    final d = await dbHelper.queryRowCount();
    int dd = d.toInt();
    int aa = a.toInt();
    setState(() {
      _allItemCount = dd;
      _activeItemCount = aa;
    });
    print(_allItemCount);
  }

  void _emptyAll() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => dbHelper.delete(row['_id']));
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