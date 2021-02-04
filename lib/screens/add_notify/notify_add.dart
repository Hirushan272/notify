import 'package:flutter/material.dart';
import 'package:meating_notifier/widgets/alert_dialog.dart';
import '../../models/notification_model.dart';
import '../../service/data_service.dart';
import '../../service/time_service.dart';
import 'dart:math';

class NotifyAdd extends StatefulWidget {
  static const routeName = "/add_notify";
  final DataService data;
  final Function showNotification;

  NotifyAdd({Key key, this.data, this.showNotification}) : super(key: key);

  @override
  _NotifyAddState createState() => _NotifyAddState();
}

class _NotifyAddState extends State<NotifyAdd> {
  Notify notify = Notify();

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  DateTime selectedDate = DateTime.now();

  var random = Random();

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notify"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Title'),
                    onSaved: (newValue) {
                      notify.title = newValue;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Description'),
                    onSaved: (newValue) {
                      notify.description = newValue;
                      notify.startedDay = selectedDate;
                      notify.startedTime = toDateTime(_time, selectedDate);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today),
                      FlatButton(
                          onPressed: () => _selectDate(context),
                          child: Text(
                            "${formateDate(selectedDate)}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_rounded),
                      FlatButton(
                          onPressed: () => _selectTime(),
                          child: Text(
                            "${formatTimeOfDay(_time)}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
              // FlatButton(
              //     onPressed: () => widget.showNotification(
              //         notificationDateTime(_time, selectedDate),
              //         notify.title,
              //         notify.description),
              //     child: Text("Notification")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          notify.id = random.nextInt(100000000);
          formKey.currentState.save();

          if (notify.startedTime.isAfter(DateTime.now())) {
            widget.data.saveNotify(notify, formKey);
            widget.showNotification(
                notify.id,
                notificationDateTime(_time, selectedDate),
                notify.title,
                notify.description);
            print(notify.id.toString());
            Navigator.of(context).pop();
          } else {
            onBasicAlertPressed(context);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
