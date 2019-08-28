import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Check/objects/database.dart';

class SettingsInterface extends StatefulWidget {
  _SettingsInterfaceState createState() => _SettingsInterfaceState();
}

class _SettingsInterfaceState extends State<SettingsInterface> {
  SharedPreferences prefs;
  final dbHelper = DatabaseHelper.instance;
  bool sound = false;
  bool daily = false;
  bool vibrate = false;
  bool dismissble = false;
  int _state = 0;
  int index = 0;
  String dropdownValue = '1 Hour';
  List<String> items = ['1 Hour', '2 Hour', '3 Hours', '5 Hours', '10 Hours'];
  @override
  void initState() {
    _initDismissble();
    _initDataDaily();
    _initDataSound();
    _initDatavibrate();
    _initDelay();
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
      /*backgroundColor:
          (_state == 0) ? Colors.white : Colors.black54.withOpacity(0.5),*/
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: height * .2,
                  width: width,
                  child: Arc(
                    arcType: ArcType.CONVEY,
                    height: height * .025,
                    clipShadows: [ClipShadow(color: Colors.black)],
                    child: Container(
                        height: height * .08,
                        color: Colors.green,
                        padding: EdgeInsets.only(
                            top: height * .05, left: width * .075),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: width,
                              child: Text(
                                "Settings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "RoboBold",
                                    fontSize: 28),
                              ),
                            ),
                            SizedBox(
                              height: height * .025,
                            ),
                            Container(
                              width: width,
                              child: Text(
                                "Edit reminder settings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Robo",
                                    fontSize: 22),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * .05),
                  width: width,
                  padding:
                      EdgeInsets.only(left: width * .025, right: width * .025),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width * .95,
                        padding: EdgeInsets.only(
                            top: height * .025,
                            bottom: height * .025,
                            left: width * .025),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 3),
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Notifications",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "RoboBold"),
                              ),
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: height * .01, left: width * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: height * .035,
                                        width: height * .035,
                                        child: Image(
                                          image: AssetImage(
                                              "assets/calender_green.png"),
                                        ),
                                      ),
                                      Container(
                                        width: width * .02,
                                      ),
                                      Text(
                                        "Daily reminder",
                                        style: TextStyle(fontFamily: "Robo"),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: Switch(
                                      value: daily,
                                      onChanged: (value) {
                                        setState(() {
                                          daily = value;
                                          prefs.setBool("daily", daily);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: height * .01, left: width * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: height * .035,
                                        width: height * .035,
                                        child: Image(
                                          image:
                                              AssetImage("assets/vibrate.png"),
                                        ),
                                      ),
                                      Container(
                                        width: width * .02,
                                      ),
                                      Text(
                                        "Vibrate",
                                        style: TextStyle(fontFamily: "Robo"),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: Switch(
                                      value: vibrate,
                                      onChanged: (value) {
                                        setState(() {
                                          vibrate = value;
                                          prefs.setBool("vibrate", vibrate);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: height * .01, left: width * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: height * .035,
                                        width: height * .035,
                                        child: Image(
                                          image: AssetImage("assets/sound.png"),
                                        ),
                                      ),
                                      Container(
                                        width: width * .02,
                                      ),
                                      Text(
                                        "Sound",
                                        style: TextStyle(fontFamily: "Robo"),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: Switch(
                                      value: sound,
                                      onChanged: (value) {
                                        setState(() {
                                          sound = value;
                                          prefs.setBool("sound", sound);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * .02),
                  width: width,
                  padding:
                      EdgeInsets.only(left: width * .025, right: width * .025),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width * .95,
                        padding: EdgeInsets.only(
                            top: height * .025,
                            bottom: height * .025,
                            left: width * .025,
                            right: width * .025),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black38, blurRadius: 3),
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Reminder Settings",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "RoboBold"),
                              ),
                            ),
                            SizedBox(
                              height: height * .01,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: height * .01, left: width * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: height * .035,
                                        width: height * .035,
                                        child: Image(
                                          image: AssetImage("assets/clock.png"),
                                        ),
                                      ),
                                      Container(
                                        width: width * .02,
                                      ),
                                      Text(
                                        "Non daily reminder timer",
                                        style: TextStyle(fontFamily: "Robo"),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                      border:
                                          Border.all(color: Colors.transparent),
                                    ),
                                    child: DropdownButton<String>(
                                      underline: DropdownButtonHideUnderline(
                                        child: Container(),
                                      ),
                                      value: items[index],
                                      onChanged: (String newValue) {
                                        _setDelay(items.indexOf(newValue));
                                        print(items.indexOf(newValue));
                                        setState(() {
                                          index = items.indexOf(newValue);
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: items
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: height * .01, left: width * .025),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: height * .035,
                                        width: height * .035,
                                        child: Image(
                                          image: AssetImage("assets/diss.png"),
                                        ),
                                      ),
                                      Container(
                                        width: width * .02,
                                      ),
                                      Text(
                                        "Dismissble activities",
                                        style: TextStyle(fontFamily: "Robo"),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    child: Switch(
                                      value: dismissble,
                                      onChanged: (value) {
                                        setState(() {
                                          dismissble = value;
                                          prefs.setBool(
                                              "dismissble", dismissble);
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: height * .02, bottom: height * .05),
                    width: width,
                    padding: EdgeInsets.only(
                        left: width * .025, right: width * .025),
                    child: Column(children: <Widget>[
                      Container(
                          width: width * .95,
                          padding: EdgeInsets.only(
                              top: height * .025,
                              bottom: height * .025,
                              left: width * .025),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black38, blurRadius: 3),
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "App Settings",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: "RoboBold"),
                                ),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/about");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: width * .025),
                                    height: height * .075,
                                    width: width * .95,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: height * .035,
                                          width: height * .035,
                                          child: Image(
                                            image:
                                                AssetImage("assets/Infos.png"),
                                          ),
                                        ),
                                        Container(
                                          width: width * .02,
                                        ),
                                        Text(
                                          "App. Informations",
                                          style: TextStyle(fontFamily: "Robo"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    //_appReset();
                                    setState(() {
                                      _state = 1;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: width * .025,
                                        right: width * .025),
                                    height: height * .075,
                                    width: width * .95,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          height: height * .0335,
                                          width: height * .0335,
                                          child: Image(
                                            image:
                                                AssetImage("assets/reset.png"),
                                          ),
                                        ),
                                        Container(
                                          width: width * .02,
                                        ),
                                        Text(
                                          "Data reset",
                                          style: TextStyle(fontFamily: "Robo"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                    ])),
              ],
            ),
            _confirmation(),
          ],
        ),
      ),
    );
  }

  _confirmation() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (_state == 0) {
      return Container();
    } else {
      return Container(
        height: height,
        width: width,
        color: Colors.black54.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                //height: height * .18,
                width: width * .75,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Are you sure you want to delete all data.",
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _state = 0;
                            });
                          },
                          child: Container(
                            height: height * .05,
                            width: width * .3,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent[200],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 2)
                                ]),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _appReset();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/splash", (Route<dynamic> route) => false);
                          },
                          child: Container(
                            height: height * .05,
                            width: width * .3,
                            decoration: BoxDecoration(
                                color: Colors.redAccent[200],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45, blurRadius: 2)
                                ]),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  _initDataDaily() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("daily") != null) {
      setState(() {
        daily = prefs.getBool("daily");
      });
    } else {
      await prefs.setBool("daily", false);
      daily = prefs.getBool("daily");
    }
  }

  _setDelay(int x) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt("delay", x);
    int r = await prefs.getInt("delay");
    print(r);
  }

  _initDelay() async {
    print("setting delay");
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("delay") != null) {
      print("/**/\n preset");
      setState(() {
        index = prefs.getInt("delay");
      });
    } else {
      print("/**/\n unset");
      await prefs.setInt("delay", 0);
      index = prefs.getInt("delay");
    }
  }

  _initDatavibrate() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("vibrate") != null) {
      setState(() {
        vibrate = prefs.getBool("vibrate");
      });
    } else {
      await prefs.setBool("vibrate", false);
      vibrate = prefs.getBool("vibrate");
    }
  }

  _initDataSound() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("sound") != null) {
      setState(() {
        sound = prefs.getBool("sound");
      });
    } else {
      await prefs.setBool("sound", false);
      sound = prefs.getBool("sound");
    }
  }

  _initDismissble() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("dismissble") != null) {
      setState(() {
        dismissble = prefs.getBool("dismissble");
      });
    } else {
      await prefs.setBool("dismissble", false);
      dismissble = prefs.getBool("dismissble");
    }
  }

  _appReset() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => dbHelper.delete(row['_id']));
    await prefs.clear();
  }
}
