import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/notification_model.dart';
import '../add_notify/notify_add.dart';
import 'notify_card.dart';
import '../../service/data_service.dart';

final dataService = ChangeNotifierProvider((ref) => DataService());

class HomePage extends ConsumerWidget {
  final Function notify;
  final Function cancelNotify;

  const HomePage({Key key, this.notify, this.cancelNotify}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: AppBar(
              centerTitle: true,
              title: Text(
                "Notifier",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0))),
              elevation: 3,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final data = ref.watch(dataService);

          return FutureBuilder<List<Notify>>(
            future: data.loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
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
                          : Container(
                              height: size.height * 0.8,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/no-data.png",
                                    scale: 2,
                                  ),
                                  Text(
                                    "No Notify",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
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
                data: ref.read(dataService),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
