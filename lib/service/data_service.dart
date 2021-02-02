import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../models/sharedPref.dart';
import 'package:uuid/uuid.dart';

class DataService extends ChangeNotifier {
  List<Notify> notifyList = [];

  void saveNotify(Notify notify, GlobalKey<FormState> formKey) {
    formKey.currentState.save();
    SharedPref pref = SharedPref();
    Uuid uuid = Uuid();
    notify.createdDate = DateTime.now();

    notify.nid = uuid.v1();
    notifyList.add(notify);

    notifyListeners();
    List<Notify> newList = notifyList;
    final String encodedData = Notify.encode(newList);
    pref.save('NotifyList', encodedData);
  }

  Future<List<Notify>> loadData() async {
    SharedPref pref = SharedPref();
    try {
      notifyList = Notify.decode(await pref.read('NotifyList'));
    } catch (e) {
      print("ERROR IN NOTIFY LIST = ${e.toString()}");
    }
    return notifyList;
  }

  void deleteNotifyItem(String id) {
    SharedPref pref = SharedPref();
    Notify deleteNotify;
    notifyList.forEach((notify) {
      if (notify.nid == id) {
        deleteNotify = notify;
      }
    });
    notifyList.remove(deleteNotify);
    notifyListeners();
    final String encodedData = Notify.encode(notifyList);
    pref.save('NotifyList', encodedData);
  }
}
