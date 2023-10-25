import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  final f = DateFormat('dd/MM/yyyy');

  return f.format(timestamp.toDate());
}

Timestamp convertStringToTimestamp(String value) {
  return Timestamp.fromDate(DateTime.parse(value));
}

Future<bool> validateCredentials(TextEditingController userNameController,
    TextEditingController senhaController) async {
  if ((userNameController.text == "marcely.santello" ||
          userNameController.text == "adriano.araujo" ||
          userNameController.text == "prof") &&
      senhaController.text == "1234") {
    return true;
  }
  return false;
}
