import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import '../../models/notification_model.dart';
import '../add_notify/notify_add.dart';
import 'notify_card.dart';
import '../../service/data_service.dart';

final dataService = ChangeNotifierProvider((ref) => DataService());

class HomePage extends StatelessWidget {
  final Function notify;
  final Function cancelNotify;

  const HomePage({Key key, this.notify, this.cancelNotify}) : super(key: key);
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
                              data: data,
                              cancelNotify: cancelNotify,
                            )
                          : Center(child: Text("No Data"));
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NotifyAdd(
                showNotification: notify,
                data: context.read(dataService),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }
}
