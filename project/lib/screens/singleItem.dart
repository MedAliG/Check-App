import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:Check/objects/database.dart';
import 'package:Check/screens/editInterface.dart';

class SingleItem extends StatefulWidget {
  final int x;
  final Map data;
  final String image;
  SingleItem(
      {Key key, @required this.x, @required this.data, @required this.image})
      : super(key: key);
  _SingleItemState createState() => _SingleItemState(x, data, image);
}

class _SingleItemState extends State<SingleItem> {
  final dbHelper = DatabaseHelper.instance;
  int x;
  Map data;
  String image;
  _SingleItemState(this.x, this.data, this.image);
  int status = 0;
  @override
  void initState() {
    setState(() {
      status = data["status"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black26.withOpacity(0.85),
      bottomNavigationBar: BtmNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingBtn(),
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
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
                        padding: EdgeInsets.only(
                            top: height * .04, left: width * .075),
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
                            Container(
                              width: width * .5,
                              height: height * .06,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFF12BB65),
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
                            Container(
                              width: width * .5,
                              height: height * .06,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.transparent,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black26.withOpacity(0.85)),
          ),
          Container(
            width: width,
            height: height,
            child: Center(
              child: Container(
                height: height * .65,
                width: width * .9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'item' + x.toString(),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              margin: EdgeInsets.only(left: width * .05),
                              height: height * .35,
                              width: width * .85,
                              decoration: BoxDecoration(
                                  //color: Colors.red,
                                  image: DecorationImage(
                                      image: AssetImage(image))),
                            ),
                          ),
                        ),
                        Container(
                          width: width * .9,
                          height: height * .1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(
                                  top: height * .005, left: width * .025),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: height * .07,
                      width: width * .9,
                      padding: EdgeInsets.only(left: width * .075),
                      //color: Colors.black,
                      child: Text(
                        data["name"],
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: "RoboBold",
                            fontSize: 22),
                      ),
                    ),
                    Container(
                      height: height * .05,
                      width: width * .9,
                      padding: EdgeInsets.only(
                          left: width * .075, right: width * .075),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: height * .1,
                            width: width * .3,
                            child: Text(
                              "Date ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Grenze",
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            height: height * .1,
                            width: width * .45,
                            child: Text(
                              convertDateToString(data['deliverDate']),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Grenze",
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .05,
                      width: width * .9,
                      padding: EdgeInsets.only(
                          left: width * .075, right: width * .075),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: height * .1,
                            width: width * .3,
                            child: Text(
                              "Amount ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Grenze",
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            height: height * .1,
                            width: width * .45,
                            child: Text(
                              data["amount"].toString() + " DT",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Grenze",
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .05,
                      width: width * .9,
                      padding: EdgeInsets.only(
                          left: width * .075, right: width * .075),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: height * .1,
                            width: width * .3,
                            child: Text(
                              "Status ",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: "Grenze",
                                  fontSize: 20),
                            ),
                          ),
                          _activityState()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: height * .1,
            width: width,
            //color: Colors.black,
            margin: EdgeInsets.only(top: height * .74),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditInterface(data: data)),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: width * .05),
                    height: height * .075,
                    width: width * .375,
                    decoration: BoxDecoration(
                        color: Color(0xFF5ABCB9),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 3,
                              offset: Offset(0, 2.0))
                        ],
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text(
                        "Edit",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Robo"),
                      ),
                    ),
                  ),
                ),
                _changeStatusBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  _changeStatusBtn() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (status == 1) {
      return GestureDetector(
        onTap: () {
          _changeState(data["_id"]);
          setState(() {
            status = 0;
          });
        },
        child: Container(
          height: height * .075,
          width: width * .375,
          decoration: BoxDecoration(
              color: Color(0xFF8FCB9B),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 3,
                    offset: Offset(0, 2.0))
              ],
              borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              "Change State",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: "Robo"),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: height * .075,
        width: width * .375,
        decoration: BoxDecoration(
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, blurRadius: 3, offset: Offset(0, 2.0))
            ],
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: Text(
            "Change State",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: "Robo"),
          ),
        ),
      );
    }
  }

  _activityState() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (status == 1) {
      return Container(
        height: height * .1,
        width: width * .45,
        child: Text(
          "Unpayed",
          textAlign: TextAlign.right,
          style:
              TextStyle(color: Colors.red, fontFamily: "Grenze", fontSize: 20),
        ),
      );
    } else {
      return Container(
        height: height * .1,
        width: width * .45,
        child: Text(
          "Payed",
          textAlign: TextAlign.right,
          style: TextStyle(
              color: Colors.green, fontFamily: "Grenze", fontSize: 20),
        ),
      );
    }
  }

  _changeState(int id) async {
    print("id = " + id.toString());

    return await dbHelper.changeState(id);
  }
}

String convertDateToString(String dde) {
  DateTime parsedDate = DateTime.parse(dde);
  print("parsedDate :" + parsedDate.toIso8601String());
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
  print("difference : " + difference.toString());
  //DateTime difference = DateTime.now();
  String dateS;
  if ((thisday.day == tm.day) &&
      (thisday.year == tm.year) &&
      (thisday.month == tm.month)) {
    dateS = "Today";
    print("somehow its today :v");
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
    print("month : " + month);
    return '$dateS, ${parsedDate.day} $month ${tm.year}';
  }
}
