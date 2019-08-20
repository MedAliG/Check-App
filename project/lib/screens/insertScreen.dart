import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:intl/intl.dart';
import 'package:Check/objects/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.selectDate,
    this.selectTime,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) selectTime(picked);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: _InputDropdown(
            labelText: labelText,
            valueText: DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(valueText, style: valueStyle),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}

class InsertInterface extends StatefulWidget {
  _InsertInterfaceState createState() => _InsertInterfaceState();
}

class _InsertInterfaceState extends State<InsertInterface> {
  final dbHelper = DatabaseHelper.instance;
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = TimeOfDay.now();
  TextEditingController amount = TextEditingController();
  TextEditingController name = TextEditingController();
  int _animation = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int _error = 0;
  int _loading = 0;
  bool prefsDaily = false;
  bool sound = false;
  bool vibrate = false;
  String _errorMsg = "";
  SharedPreferences prefs;
  @override
  void initState() {
    _initDataDaily();
    _initDataSound();
    _initDatavibrate();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BtmNavBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _animationStuff(),
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: width,
          height: height,
          child: ListView(
            children: <Widget>[
              Container(
                height: height * .22,
                child: Diagonal(
                  axis: Axis.horizontal,
                  clipHeight: height * .055,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black38, blurRadius: 2)
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.1, 0.9],
                        colors: [
                          Colors.green,
                          Color(0xFF12BB65),
                        ],
                      ),
                    ),
                    child: Container(
                      width: width,
                      height: height * .2,
                      padding: EdgeInsets.only(
                          top: height * .05, left: width * .075),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            child: Text(
                              "Add Events",
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
                              "Insert relavent data",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Robo",
                                  fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .05),
                width: width,
                padding:
                    EdgeInsets.only(left: width * .075, right: width * .075),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * .01),
                      width: width * .9,
                      child: Text(
                        "Amount",
                        style: TextStyle(fontFamily: "Robo"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .01),
                      width: width * .85,
                      height: height * .05,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color:
                                  (_error == 1) ? Colors.red : Colors.black87,
                              blurRadius: (_error == 1) ? 3 : 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: height * .05,
                        width: width * .6,
                        padding: EdgeInsets.only(
                            top: height * .012, left: width * .03),
                        child: TextField(
                          controller: amount,
                          decoration: InputDecoration.collapsed(
                              hintText: "Ex: 800.00€"),
                          onSubmitted: (_) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .03),
                width: width,
                padding:
                    EdgeInsets.only(left: width * .075, right: width * .075),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * .01),
                      width: width * .9,
                      child: Text(
                        "Receiver Name",
                        style: TextStyle(fontFamily: "Robo"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .01),
                      width: width * .85,
                      height: height * .05,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color:
                                  (_error == 1) ? Colors.red : Colors.black87,
                              blurRadius: (_error == 1) ? 3 : 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: height * .05,
                        width: width * .6,
                        padding: EdgeInsets.only(
                            top: height * .012, left: width * .03),
                        child: TextField(
                          controller: name,
                          decoration: InputDecoration.collapsed(
                              hintText: "Ex: John Doe"),
                          onSubmitted: (_) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .03),
                width: width,
                padding:
                    EdgeInsets.only(left: width * .075, right: width * .075),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: width * .01),
                      width: width * .9,
                      child: Text(
                        "Date & time of delivery",
                        style: TextStyle(fontFamily: "Robo"),
                      ),
                    ),
                    Container(
                      child: _DateTimePicker(
                        labelText: '',
                        selectedDate: _fromDate,
                        selectedTime: _fromTime,
                        selectDate: (DateTime date) {
                          setState(() {
                            _fromDate = date;
                          });
                        },
                        selectTime: (TimeOfDay time) {
                          setState(() {
                            _fromTime = time;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .03,
              ),
              Container(
                margin:
                    EdgeInsets.only(left: width * .075, right: width * .075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Row(
                      children: <Widget>[
                        Container(
                          height: height * .035,
                          width: height * .035,
                          child: Image(
                            image: AssetImage("assets/calender_red.png"),
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
                        value: prefsDaily,
                        onChanged: (value) {
                          setState(() {
                            prefsDaily = value;
                            //prefs.setBool("daily", prefsDaily);
                          });
                        },
                        activeColor: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: width * .85,
                //height: height*.015,
                padding: EdgeInsets.only(top: height * .02),
                child: Center(
                  child: (_error == 1)
                      ? Text(
                          _errorMsg,
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: "Robo",
                              fontSize: 15),
                        )
                      : Container(
                          child: (_error == 2)
                              ? Text(
                                  "Added successfully",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: "Robo",
                                      fontSize: 15),
                                )
                              : Container()),
                ),
              ),
              Container(
                width: width * .85,
                margin: EdgeInsets.only(top: height * .08),
                padding:
                    EdgeInsets.only(left: width * .075, right: width * .075),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        //_cancelAllNotifications();
                        //_checkPendingNotificationRequests();
                        _resetBtn();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: width * .05),
                        height: height * .06,
                        width: width * .4,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF12BB65), width: 2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 3)
                            ]),
                        child: Center(
                          child: Text(
                            "Reset",
                            style: TextStyle(
                                color: Color(0xFF12BB65),
                                fontFamily: "Robo",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _insert();
                      },
                      child: Container(
                        //margin: EdgeInsets.only(right: width * .05),
                        height: height * .06,
                        width: width * .4,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 3)
                          ],
                          color: Color(0xFF12BB65),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Robo",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _animationStuff() {
    if (_animation == 0) {
      return CameraFloatingBtn();
    } else if (_animation == 1) {
      return LoadingInd();
    } else if (_animation == 2) {
      return LoadingIndSucc();
    }
  }

  _animationSetter() {
    print("animation state 0" + _animation.toString());
    setState(() {
      _animation = 2;
    });
    print("animation state 1" + _animation.toString());

    Timer(Duration(seconds: 2), () {
      setState(() {
        _animation = 0;
        print("animation state 2" + _animation.toString());

        _error = 2;
      });
    });
  }

  bool _validAmount(String str) {
    final List s = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', "."];

    for (int i = 0; i < str.length; i++) {
      if (!(s.contains(str[i]))) {
        print(str[i]);
        return false;
      }
    }

    if ('.'.allMatches(str).length > 1) {
      return false;
    }
    /*List<String> ss = str.split(".");
    if (ss.length > 2) {
      return false;
    }*/
    return true;
  }

  bool _test() {
    //print("here " + '.'.allMatches(amount.text).length.toString());
    if ((name.text == "") || (amount.text == "")) {
      print("empty text");
      setState(() {
        _error = 1;
        _errorMsg = "Please make sure to fill both fields";
      });
      return false;
    }  
    if (name.text.length > 36) {
      setState(() {
        _error = 1;
        _errorMsg = "Name length is unvalid";
        print(_errorMsg);
      });
      return false;
    } 
    if (!(_validAmount(amount.text))) {
      setState(() {
        _error = 1;
        _errorMsg = "Amount wrong format";
        print(_errorMsg);
      });
      return false;
    }
    print("all good ");
    setState(() {
      _error = 0;
    });
    return true;
  }

  Future<void> _checkPendingNotificationRequests() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var pendingNotificationRequest in pendingNotificationRequests) {
      debugPrint(
          'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
    }
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              '${pendingNotificationRequests.length} pending notification requests'),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _insert() async {
    if (_test()) {
      _animationSetter();
      String n = name.text;
      int status = 0;
      print("Client name :" + n);
      double m = double.parse(amount.text);
      print(m);
      DateTime date = DateTime.now();
      DateTime d = _makeValidDate(_fromDate, _fromTime.hour, _fromTime.minute);
      print(prefsDaily);
      if (d.compareTo(date) > 0) {
        print(_fromDate.toIso8601String() +
            "  /*********************/" +
            date.toIso8601String());
        status = 1;
      }

      // row to insert
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: n,
        DatabaseHelper.columnAmount: m,
        DatabaseHelper.columnStatus: status,
        DatabaseHelper.columnDate: _fromDate.toString(),
        DatabaseHelper.columnTime:
            _setValidFormat(int.parse(_fromTime.hour.toString())) +
                ":" +
                _setValidFormat(int.parse(_fromTime.minute.toString()))
      };
      final id = await dbHelper.insert(row);
      print('inserted row id: $id');
      if (prefsDaily) {
        await _showDailyAtTime(d, id);
      } else {
        await _scheduleNotification(d, id);
      }
    }
  }

  _resetBtn() {
    setState(() {
      amount.text = "";
      name.text = "";
      _fromDate = DateTime.now();
      _loading = 0;
      _error = 0;
    });
  }

  DateTime _makeValidDate(DateTime s, int hour, int minutes) {
    DateTime x = DateTime.parse(s.year.toString() +
        "-" +
        _setValidFormat(s.month) +
        "-" +
        _setValidFormat(s.day) +
        " " +
        _setValidFormat(hour) +
        ":" +
        _setValidFormat(minutes) +
        ":00");
    return x;
  }

  String _setValidFormat(int x) {
    if (x < 10) {
      return "0" + x.toString();
    } else {
      return x.toString();
    }
  }

  Future<void> _showDailyAtTime(DateTime _date, int _id) async {
    var time = Time(_date.hour, _date.minute, 00);
    print(time);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        name.text, amount.text, _date.toIso8601String());
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        _id,
        name.text,
        amount.text +
            'DT at ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
        time,
        platformChannelSpecifics);
  }

  Future<void> _scheduleNotification(DateTime _date, int _id) async {
    var scheduledNotificationDateTime;
    if (DateTime.now().subtract(Duration(hours: 3)).compareTo(_date) < 0) {
      scheduledNotificationDateTime = _date.subtract(Duration(hours: 2));
    } else {
      scheduledNotificationDateTime = _date.subtract(Duration(hours: 0));
    }

    var vibrationPattern = Int64List(4);
    print("vibrate :" + vibrate.toString());
    if (vibrate) {
      vibrationPattern[0] = 0;
      vibrationPattern[1] = 1000;
      vibrationPattern[2] = 5000;
      vibrationPattern[3] = 2000;
    } else {
      vibrationPattern = null;
    }

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        name.text, amount.text, _date.toIso8601String(),
        icon: 'secondary_icon',
        sound: 'slow_spring_board',
        largeIcon: 'sample_large_icon',
        largeIconBitmapSource: BitmapSource.Drawable,
        vibrationPattern: vibrationPattern,
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        10,
        name.text,
        amount.text + "DT",
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.of(context).pushNamed('/set');
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.of(context).pushNamed('/set');
            },
          )
        ],
      ),
    );
  }

  Future<void> _cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  _initDataDaily() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("daily") != null) {
      setState(() {
        prefsDaily = prefs.getBool("daily");
        print("preset " + prefsDaily.toString());
      });
    } else {
      await prefs.setBool("daily", false);
      prefsDaily = prefs.getBool("daily");
      print("Not preset");
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
}
