import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

formatTimestamp(Timestamp timestamp) {
  final f = DateFormat('dd-MM-yyyy');

  return f.format(timestamp.toDate());
}
