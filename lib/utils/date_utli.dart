import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String getFormatedDate(Timestamp timestamp) {
  if (timestamp.seconds == 0) return '';
  final DateTime date = timestamp.toDate();
  late String formatedDate;
  final timeStampDiff = timestamp.seconds - Timestamp.now().seconds;

  if (timeStampDiff.abs() < 86400) {
    formatedDate = DateFormat.Hm().format(date);
  } else {
    formatedDate = DateFormat('yyyy-MM-dd').format(date);
  }

  return formatedDate;
}
