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
