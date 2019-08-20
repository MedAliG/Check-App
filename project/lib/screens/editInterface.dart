import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:Check/widgets/bottomNavBarC.dart';
import 'package:intl/intl.dart';
import 'package:Check/objects/database.dart';
import 'dart:async';

class EditInterface extends StatefulWidget {
  final Map data;
  EditInterface({Key key, @required this.data}) : super(key: key);
  _EditInterfaceState createState() => _EditInterfaceState(data);
}

class _EditInterfaceState extends State<EditInterface> {
  Map data;
  final dbHelper = DatabaseHelper.instance;
  DateTime _fromDate = DateTime.now();
  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  TextEditingController amount = TextEditingController();
  TextEditingController name = TextEditingController();
  int _error = 0;
  int _loader = 0;
  int _animation = 0;
  _EditInterfaceState(this.data);
  String _errorMsg = "";
  @override
  void initState() {
    _initData();
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
        height: height,
        width: width,
        child: ListView(
          children: <Widget>[
            Container(
              height: height * .22,
              width: width,
              //color: Colors.green,
              child: Arc(
                height: 32.5,
                clipShadows: [ClipShadow(color: Colors.black)],
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.green,
                      height: height * .22,
                      width: width,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width,
                            padding: EdgeInsets.only(
                              top: height * .05,
                              left: width * .1,
                            ),
                            child: Text(
                              "Edit activity",
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
                            height: height * .1,
                            width: width,
                            padding: EdgeInsets.only(
                              left: width * .1,
                            ),
                            child: Text(
                              "Update existing events",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "RoboBold",
                                  fontSize: 22),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      bottom: 0.0,
                      child: Container(height: 30.0, color: Colors.green),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * .05),
              width: width,
              padding: EdgeInsets.only(left: width * .075, right: width * .075),
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
                            color: (_error == 1) ? Colors.red : Colors.black87,
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
                        decoration:
                            InputDecoration.collapsed(hintText: "Ex: 800.00€"),
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
              padding: EdgeInsets.only(left: width * .075, right: width * .075),
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
                            color: (_error == 1) ? Colors.red : Colors.black87,
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
                        decoration:
                            InputDecoration.collapsed(hintText: "Ex: John Doe"),
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
              padding: EdgeInsets.only(left: width * .075, right: width * .075),
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
                                "Updated successfully",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: "Robo",
                                    fontSize: 15),
                              )
                            : Container()),
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            Container(
              width: width,
              height: height * .1,
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _deleteItem();
                    },
                    child: Container(
                      //margin: EdgeInsets.only(right: width * .05),
                      height: height * .06,
                      width: width * .4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 3)
                        ],
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Robo",
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _updateData();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width * .05),
                      height: height * .06,
                      width: width * .4,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 3)
                        ],
                        color: Colors.green,
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
      ),
    );
  }

  _initData() {
    DateTime timer = DateTime.parse(data["deliverDate"]);
    var l = data["time"].toString().split(":");
    //print(l);
    setState(() {
      amount.text = data["amount"].toString();
      name.text = data["name"];
      _fromDate = timer;
      _fromTime = TimeOfDay(hour: int.parse(l[0]), minute: int.parse(l[1]));
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

  _updateData() async {
    
    if (_test()) {
      _animationSetter();
      int status = 0;
      DateTime date = DateTime.now();
      if (_fromDate.compareTo(date) > 0) {
        status = 1;
      }
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: name.text,
        DatabaseHelper.columnAmount: amount.text,
        DatabaseHelper.columnStatus: status,
        DatabaseHelper.columnDate: _fromDate.toString(),
        DatabaseHelper.columnTime: _setValidFormat(_fromTime.hour) +
            ":" +
            _setValidFormat(_fromTime.minute)
      };
      print(row);
      print(data["_id"]);

      return await dbHelper.updateData(row, data["_id"]);
    }
  }

  String _setValidFormat(int x) {
    if (x < 10) {
      return "0" + x.toString();
    } else {
      return x.toString();
    }
  }

  _animationStuff() {
    if (_animation == 0) {
      return FloatingBtn();
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
      });
    });
    //dispose();
    /*
    */
  }

  _deleteItem() async {
    _animationSetter();
    await dbHelper.delete(data["_id"]);
    Navigator.of(context)
        .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false);
  }
}

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
