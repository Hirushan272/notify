import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formateDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTimeOfDay(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat('HH:mm');
  return format.format(dt);
}

DateTime toDateTime(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  return dt;
}

String formateToTime(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

DateTime notificationDateTime(TimeOfDay time, DateTime date) {
  int year = date.year;
  int month = date.month;
  int day = date.day;
  int hour = time.hour;
  int minute = time.minute - 1;
  int second = 0;
  // date.year == DateTime.now().year ? year = 0 : year = date.year;
  // date.month == DateTime.now().month ? month = 0 : month = date.month;
  // date.day == DateTime.now().day ? day = 0 : day = date.day;
  // time.hour == DateTime.now().hour ? hour = 0 : hour = time.hour;
  // time.minute == DateTime.now().minute ? minute = 0 : minute = time.minute;

  final dt = DateTime(year, month, day, hour, minute, second, 10, 200);
  return dt;
}
