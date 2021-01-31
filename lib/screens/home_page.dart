import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
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
          data.loadData();
          return Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: ListView.builder(
                itemCount: data.notifyList.length == 0 ||
                        data.notifyList.length == null
                    ? 1
                    : data.notifyList.length,
                itemBuilder: (context, index) {
                  return data.notifyList.isNotEmpty
                      ? NotifyCard(data: data, index: index)
                      : Text("No Data");
                }),
          );
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
