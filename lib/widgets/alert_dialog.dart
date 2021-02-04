import 'package:rflutter_alert/rflutter_alert.dart';

onBasicAlertPressed(context) {
  Alert(
    type: AlertType.warning,
    context: context,
    title: "ALERT",
    desc: "Can't set notification for history.",
  ).show();
}
