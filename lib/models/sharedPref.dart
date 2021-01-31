import 'dart:convert';
import 'constants.dart';

class SharedPref {
  read(String key) {
    return jsonDecode(Constants.prefs.getString(key));
  }

  save(String key, value) {
    Constants.prefs.setString(key, jsonEncode(value));
  }

  remove(String key) {
    Constants.prefs.remove(key);
  }
}
