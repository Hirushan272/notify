// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onBasicAlertPressed(context) {
  Alert(
    type: AlertType.warning,
    context: context,
    title: "WARNING",
    desc: "Please enter valid data",
  ).show();
}
