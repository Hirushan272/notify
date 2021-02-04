import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_riverpod/all.dart';
import 'screens/add_notify/notify_add.dart';
import 'service/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/constants.dart';
import 'screens/home/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPlatformState();
  await _configureLocalTimeZone();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

//!INITIALIZE TIMEZONE FOR SCHEDULED NOTIFICATIONS

String timezone;
Future<void> initPlatformState() async {
  try {
    timezone = await FlutterNativeTimezone.getLocalTimezone();
  } on PlatformException {
    timezone = 'Failed to get the timezone.';
  }
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = timezone;
  tz.setLocalLocation(tz.getLocation(timeZoneName));
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

//! SHOW NOTIFICATION FUNCTION HERE

  Future showNotification(
      int id, DateTime showTime, String task, String description) async {
    String title;
    String note;
    task == null ? title = "Task" : title = task;
    description == null ? note = "You have a Meeting Now" : note = description;

    var androidDetails = AndroidNotificationDetails(
      "Channel Id",
      "Channel Name",
      "This is my channel",
      playSound: false,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    await flutterNotification.zonedSchedule(id, title, note,
        tz.TZDateTime.from(showTime, tz.local), generalNotificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Future pendingNotification(
  //     int id, String title, String body, String payload) async {
  //   final List<PendingNotificationRequest> pendingNotificationRequests =
  //       await flutterNotification.pendingNotificationRequests();

  //   pendingNotificationRequests
  //       .add(PendingNotificationRequest(id, title, body, payload));
  // }

  //  Future<void> _zonedScheduleNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails('your channel id',
  //               'your channel name', 'your channel description')),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // Future showPendingNotification(
  //     DateTime showTime, String task, String description) async {
  //   String title;
  //   String note;
  //   task == null ? title = "Task" : title = task;
  //   description == null ? note = "You have a Meeting Now" : note = description;

  //   var androidDetails = AndroidNotificationDetails(
  //     "Channel Id",
  //     "Channel Name",
  //     "This is my channel",
  //     playSound: false,
  //     enableVibration: true,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   var generalNotificationDetails =
  //       NotificationDetails(android: androidDetails);
  //   await flutterNotification.zonedSchedule(
  //       0,
  //       title,
  //       note,
  //       tz.TZDateTime.from(showTime, tz.local),
  //       generalNotificationDetails,
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

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
