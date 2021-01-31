import 'package:flutter/material.dart';
import 'package:meating_notifier/service/data_service.dart';
import 'package:meating_notifier/service/time_service.dart';

class NotifyCard extends StatelessWidget {
  final DataService data;
  final int index;

  NotifyCard({Key key, this.data, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1.0),
      ),
      elevation: 4.0,
      shadowColor: Colors.black,
      child: Container(
        width: size.width * 0.95,
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            data.notifyList[index].nid != null
                ? Text(
                    "${data.notifyList[index].title}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    "Title",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
            SizedBox(height: 10),
            data.notifyList[index].nid != null
                ? Text("${data.notifyList[index].description}")
                : Text(
                    "This Is the description of dummy notify card",
                    style: TextStyle(fontSize: 15),
                  ),
            SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            // data.notifyList[index].nid != null
            //     ? Text(
            //         "Date: ${formateDate(data.notifyList[index].startedDay)}")
            //     : Text("Date: 2021-05-23"),
            // data.notifyList[index].nid != null
            //     ? Text(
            //         "Time: ${formatTimeOfDay(data.notifyList[index].startedTime)}")
            //     : Text("Time: 09:00"),
            // ],
            // ),
          ],
        ),
      ),
    );
  }
}
