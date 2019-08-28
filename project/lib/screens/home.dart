import 'dart:core';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:Check/screens/singleItem.dart';
import 'package:Check/objects/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final String state;
  HomeScreen({Key key, this.state}) : super(key: key);
  _HomeScreenState createState() => _HomeScreenState(state);
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = DatabaseHelper.instance;
  SharedPreferences prefs;
  String state;
  int _allItemCount = 0;
  int _activeItemCount = 0;
  String _state;
  int _deleteState = 0;
  int confirmDelete = 0;
  int deletable = -1;
  bool dismissble = false;
  List<int> allDataIndexes = [];
  List<int> activeDataIndexes = [];
  List<int> backupDataAll = [];
  List<int> backupDataActive = [];
  List<Map<String, dynamic>> dataAll = [];
  List<Map<String, dynamic>> dataActive = [];
  String _deleteMsg = "";
  _HomeScreenState(this.state);
  bool isPausedAnimation = false;
  @override
  void initState() {
    //_emptyAll();
    _setDismissble();
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
      backgroundColor:
          (_deleteState == 1) ? Color(0xFF4A4A4A) : Color(0xFFFAFAFA),
      bottomNavigationBar: BtmNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingBtn(),
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFFFAFAFA),
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
                  padding:
                      EdgeInsets.only(left: width * .025, right: width * .025),
                  width: width,
                  height: height * .7275,
                  child: (_state == "active")
                      ? ListView.builder(
                          itemCount: _activeItemCount,
                          itemBuilder: (BuildContext context, int index) {
                            print("\n/****/ supp" + dataAll.length.toString());
                            return (dismissble)
                                ? _itemCreate2(index,
                                    dataActive[activeDataIndexes[index]], false)
                                : _itemCreateDefault(
                                    index,
                                    dataActive[activeDataIndexes[index]],
                                    false);
                          })
                      : ListView.builder(
                          itemCount: _allItemCount,
                          itemBuilder: (BuildContext context, int index) {
                            return (dismissble)
                                ? _itemCreate2(
                                    index, dataAll[allDataIndexes[index]], true)
                                : _itemCreateDefault(index,
                                    dataAll[allDataIndexes[index]], false);
                          }),
                )
              ],
            ),
          ),
          _removedInterface(),
        ],
      ),
    );
  }

  _removedInterface() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return (_deleteState == 1)
        ? Container(
            height: height,
            width: width,
            color: Colors.black54.withOpacity(.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                __btnConfrm(0),
              ],
            ))
        : Container();
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

  __btnConfrm(int x) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .8,
      padding: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: <Widget>[
          Container(
              child: Text(
            _deleteMsg,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          )),
          Container(
            margin: EdgeInsets.only(top: height * .02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _cancelBtn();
                  },
                  child: Container(
                    width: width * .28,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontFamily: "RoboBold",
                            color: Colors.white,
                            fontSize: width * .035),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _deleteConfirm();
                  },
                  child: Container(
                    width: width * .28,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontFamily: "RoboBold",
                            color: Colors.white,
                            fontSize: width * .035),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _deleteConfirm() {
    if (_state != "active") {
      setState(() {
        confirmDelete = 1;
        _deleteState = 0;
        print("deletable" + deletable.toString());
        _removeSelected(deletable);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(state: "all")),
        );
      });
    } else {
      setState(() {
        confirmDelete = 1;
        _deleteState = 0;
        print("deletable" + deletable.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(state: "active")),
        );
      });
      _changeState(deletable);
    }
  }

  _cancelBtn() {
    setState(() {
      _deleteState = 0;
      print("backup here :");
      print(backupDataAll);
      //allDataIndexes = [];
      allDataIndexes = _copyList(backupDataAll);
      activeDataIndexes = _copyList(backupDataActive);
      confirmDelete = 0;
      if (_state == "active") {
        _activeItemCount++;
      } else {
        _allItemCount++;
      }
    });
  }

  _dismissbleBg() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      color: Colors.transparent,
      alignment: Alignment.centerLeft,
      child: Container(
        width: width * .3,
        child: FlareActor(
          "assets/flare/Loading.flr",
          animation: 'Loading',
        ),
      ),
    );
  }

  //Non dismissble ItemList
  _itemCreateDefault(int x, Map data, bool all) {
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
        //padding: EdgeInsets.only(top: height * .02, bottom: height * .02),
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

  //Dismissble Item list
  _itemCreate2(int x, Map data, bool all) {
    List<String> images = [
      "assets/pic2.png",
      "assets/pic3.png",
      "assets/pic1.png",
    ];
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dismissible(
      background: _dismissbleBg(),
      direction: DismissDirection.horizontal,
      key: Key(UniqueKey().toString()),
      onDismissed: (direction) {
        //backupDataAll = allDataIndexes;
        if (all) {
          print("deletable");
          setState(() {
            _deleteMsg = "Are you sure you want to delete this item ?";
            _deleteState = 1;
            deletable = dataAll[x]["_id"];
            print("deletable :" + deletable.toString());
            allDataIndexes.removeAt(x);
            _allItemCount = allDataIndexes.length;
          });
        } else {
          setState(() {
            _deleteMsg = "Are you sure you want to set this as payed ?";
            _deleteState = 1;
            deletable = dataActive[x]["_id"];
            print("deletable :" + deletable.toString());
            activeDataIndexes.removeAt(x);
            _activeItemCount = activeDataIndexes.length;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SingleItem(x: x, data: data, image: images[x % 3])),
          );
        },
        child: Container(
          //padding: EdgeInsets.only(top: height * .02, bottom: height * .02),
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
                              style: TextStyle(
                                  fontFamily: "RoboBold", fontSize: 25),
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
      ),
    );
  }

  _initData() async {
    List<Map<String, dynamic>> dataSet = await dbHelper.queryAllRows();
    List<Map<String, dynamic>> dataSet2 = await dbHelper.queryActiveRows();
    print('query all rows:');
    int i = 0;
    int j = 0;
    setState(() {
      _state = state;
      dataSet.forEach((row) => {allDataIndexes.add(i++)});
      dataAll = dataSet;
      backupDataAll = _copyList(allDataIndexes);
      _allItemCount = allDataIndexes.length;

      dataSet2.forEach((row) => {activeDataIndexes.add(j++)});
      dataActive = dataSet2;
      backupDataActive = _copyList(activeDataIndexes);
      _activeItemCount = activeDataIndexes.length;
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

  _removeSelected(int x) async {
    print("xx x = " + x.toString());
    await dbHelper.delete(x);
  }

  _changeState(int x) async {
    await dbHelper.changeState(x);
  }

  _setDismissble() async {
    prefs = prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("dismissble") != null) {
      setState(() {
        dismissble = prefs.getBool("dismissble");
      });
    } else {
      await prefs.setBool("dismissble", false);
      dismissble = prefs.getBool("dismissble");
    }
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

  _copyList(List x) {
    List<int> r = [];
    for (int i = 0; i < x.length; i++) {
      r.add(x[i]);
    }
    return r;
  }
}
