import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/notificationSystem.dart';
import 'screens/splash.dart';
import 'screens/displayedPage.dart';
import 'screens/localStorageFuncts.dart';
import 'screens/home.dart';
import 'screens/insertScreen.dart';
import 'screens/sqtest.dart';
import 'screens/settingsInterface.dart';
import 'package:Check/objects/database.dart';
import 'screens/guideline.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(InternShip());
  });
}

class InternShip extends StatefulWidget {
  _InternShipState createState() => _InternShipState();
}

class _InternShipState extends State<InternShip> {
  final dbHelper = DatabaseHelper.instance;
  List<int> l;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    super.initState();
    _initDataStatus();
  }

  String _toTwoDigitString(int value) {
    return value.toString().padLeft(2, '0');
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.of(context).pushNamed('/set');
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

  _updateActives() {
    for (int i = 0; i < l.length; i++) {}
  }

  _initDataStatus() async {
    List<int> r = await dbHelper.autoUpdateActivity();
    setState(() {
      l = r;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      routes: <String, WidgetBuilder>{
        '/notification': (BuildContext context) => NotificationSystem(),
        '/set': (BuildContext context) => SecondScreen(),
        '/str': (BuildContext context) => LocalStorage(),
        '/home': (BuildContext context) => HomeScreen(),
        '/add': (BuildContext context) => InsertInterface(),
        '/sqt': (BuildContext context) => Sr(),
        '/settings': (BuildContext context) => SettingsInterface(),
        '/guidelines': (BuildContext context) => GuideLines(),
        '/splash':(BuildContext context) => SplashScreen(),
      },
      home: SplashScreen(),
    );
  }
}
