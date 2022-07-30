import 'package:flutter/material.dart';
import '../../models/notification_model.dart';
import '../../service/data_service.dart';
import '../../service/time_service.dart';

class NotifyCard extends StatelessWidget {
  final List<Notify> notifyList;
  final int index;
  final DataService data;
  final Function cancelNotify;
  NotifyCard(
      {Key key, this.notifyList, this.index, this.data, this.cancelNotify})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      color: Colors.yellow[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
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
                    ? Container(
                        width: size.width * 0.7,
                        child: Text(
                          "${notifyList[index].title}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Text(
                        "Title",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                SizedBox(height: 10),
                notifyList[index].description != null
                    ? Container(
                        width: size.width * 0.7,
                        child: Text("${notifyList[index].description}"))
                    : Text(
                        "This Is the description",
                        style: TextStyle(fontSize: 15),
                      ),
                SizedBox(height: 10),
                Container(
                  width: size.width * 0.7,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: data.notifyList[index].startedDay != null
                                ? Text(
                                    "${formateDate(data.notifyList[index].startedDay)}")
                                : Text("2021-05-23"),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_rounded,
                            size: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: data.notifyList[index].startedTime != null
                                ? Text(
                                    "${formateToTime(data.notifyList[index].startedTime)}")
                                : Text("09:00"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    cancelNotify(data.notifyList[index].id);
                    data.deleteNotifyItem(data.notifyList[index].nid);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
