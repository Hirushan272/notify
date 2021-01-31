import 'package:flutter/material.dart';
import 'package:meating_notifier/models/notification_model.dart';
import 'package:meating_notifier/service/data_service.dart';
import 'package:meating_notifier/service/time_service.dart';

class NotifyAdd extends StatefulWidget {
  static const routeName = "/add_notify";
  final DataService data;

  const NotifyAdd({Key key, this.data}) : super(key: key);

  @override
  _NotifyAddState createState() => _NotifyAddState();
}

class _NotifyAddState extends State<NotifyAdd> {
  Notify notify = Notify();

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);
  DateTime selectedDate = DateTime.now();

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
      // notify.startedTime = _time;
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
                      Text(
                        "Date:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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
                      Text(
                        "Time:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.data.saveNotify(notify, formKey);
          Navigator.of(context).pop();
        },
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
