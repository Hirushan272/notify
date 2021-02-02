import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import '../../service/data_service.dart';
import '../../service/time_service.dart';

class NotifyCard extends StatelessWidget {
  final List<Notify> notifyList;
  final int index;
  final DataService data;

  NotifyCard({Key key, this.notifyList, this.index, this.data})
      : super(key: key);
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
        padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                notifyList[index].title != null
                    ? Text(
                        "${notifyList[index].title}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                SizedBox(height: 10),
                notifyList[index].description != null
                    ? Container(
                        width: size.width * 0.75,
                        child: Text("${notifyList[index].description}"))
                    : Text(
                        "This Is the description",
                        style: TextStyle(fontSize: 15),
                      ),
                SizedBox(height: 10),
                Container(
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: data.notifyList[index].startedDay != null
                            ? Text(
                                "Date: ${formateDate(data.notifyList[index].startedDay)}")
                            : Text("Date: 2021-05-23"),
                      ),
                      Container(
                        child: data.notifyList[index].startedTime != null
                            ? Text(
                                "Time: ${formateToTime(data.notifyList[index].startedTime)}")
                            : Text("Time: 09:00"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () =>
                  data.deleteNotifyItem(data.notifyList[index].nid),
            ),
          ],
        ),
      ),
    );
  }
}
