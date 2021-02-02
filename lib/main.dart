import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'screens/add_notify/notify_add.dart';
import 'service/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/constants.dart';
import 'screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

final dataService = ChangeNotifierProvider((ref) => DataService());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterNotification;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('images');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    flutterNotification = FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "Channel Id", "Channel Name", "This is my channel",
        playSound: false, enableVibration: false, importance: Importance.max);
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    await flutterNotification.show(
        0, "Task", "You have to do a task", generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: HomePage(notify: showNotification),
        theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          buttonColor: Colors.brown[800],
        ),
        routes: {
          NotifyAdd.routeName: (context) => NotifyAdd(),
        },
      ),
    );
  }

  Future notificationSelected(String payload) async {}
}
