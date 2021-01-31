import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:meating_notifier/models/notification_model.dart';
import 'package:meating_notifier/screens/add_notify/notify_add.dart';
import 'package:meating_notifier/screens/home/notify_card.dart';
import 'package:meating_notifier/service/data_service.dart';

final dataService = ChangeNotifierProvider((ref) => DataService());

class HomePage extends StatelessWidget {
  int isInit = 1;
  final List<Notify> notifyList;

  HomePage({Key key, this.notifyList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final data = watch(dataService);
          data.loadData();
          return Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: isInit == 1
                ? ListView.builder(
                    itemCount:
                        notifyList.length == 0 || notifyList.length == null
                            ? 1
                            : notifyList.length,
                    itemBuilder: (context, index) {
                      return notifyList.isNotEmpty
                          ? NotifyCard(
                              notifyList: notifyList, index: index, data: data)
                          : Text("No Data");
                    })
                : ListView.builder(
                    itemCount: data.notifyList.length == 0 ||
                            data.notifyList.length == null
                        ? 1
                        : data.notifyList.length,
                    itemBuilder: (context, index) {
                      return data.notifyList.isNotEmpty
                          ? NotifyCard(
                              notifyList: data.notifyList,
                              index: index,
                              data: data)
                          : Text("No Data");
                    }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isInit++;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotifyAdd(
                    data: context.read(dataService),
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
