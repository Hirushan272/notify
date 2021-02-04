import 'dart:convert';

class Notify {
  String nid;
  String title;
  String description;
  DateTime createdDate;
  DateTime startedDay;
  DateTime startedTime;

  Notify({
    this.nid,
    this.title,
    this.description,
    this.createdDate,
    this.startedDay,
    this.startedTime,
  });

  static Map<String, dynamic> toMap(Notify notify) => {
        'nid': notify.nid,
        'title': notify.title,
        'description': notify.description,
        'createdDate': notify.createdDate?.toIso8601String(),
        'startedDay': notify.startedDay?.toIso8601String(),
        'startedTime': notify.startedTime?.toIso8601String(),
      };

  factory Notify.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Notify(
      nid: map['nid'],
      title: map['title'],
      description: map['description'],
      createdDate: map['createdDate'] == null
          ? DateTime.now()
          : DateTime.parse(map['createdDate']),
      startedDay: map['startedDay'] == null
          ? DateTime.now()
          : DateTime.parse(map['startedDay']),
      startedTime: DateTime.parse(map['startedTime']),
    );
  }

  static String encode(List<Notify> notify) => json.encode(
        notify
            .map<Map<String, dynamic>>((notify) => Notify.toMap(notify))
            .toList(),
      );

  static List<Notify> decode(String notify) =>
      (json.decode(notify) as List<dynamic>)
          .map<Notify>((item) => Notify.fromMap(item))
          .toList();
}
