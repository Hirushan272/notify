import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:meating_notifier/models/notification_model.dart';
import 'package:meating_notifier/screens/add_notify/notify_add.dart';
import 'package:meating_notifier/screens/home/notify_card.dart';
import 'package:meating_notifier/service/data_service.dart';

final dataService = ChangeNotifierProvider((ref) => DataService());

class HomePage extends StatelessWidget {
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

          return FutureBuilder<List<Notify>>(
              future: data.loadData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: snapshot.data.length == 0 ||
                                  snapshot.data.length == null
                              ? 1
                              : snapshot.data.length,
                          itemBuilder: (context, index) {
                            return snapshot.data.isNotEmpty
                                ? NotifyCard(
                                    notifyList: snapshot.data,
                                    index: index,
                                    data: data)
                                : Text("No Data");
                          }));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // : ListView.builder(
                //     itemCount: data.notifyList.length == 0 ||
                //             data.notifyList.length == null
                //         ? 1
                //         : data.notifyList.length,
                //     itemBuilder: (context, index) {
                //       return data.notifyList.isNotEmpty
                //           ? NotifyCard(
                //               notifyList: data.notifyList,
                //               index: index,
                //               data: data)
                //           : Text("No Data");
                //     }),
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
