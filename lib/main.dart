import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:meating_notifier/screens/add_notify/notify_add.dart';
import 'package:meating_notifier/service/data_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/constants.dart';
import 'models/notification_model.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

final dataService = ChangeNotifierProvider((ref) => DataService());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: HomePage(),
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
}
