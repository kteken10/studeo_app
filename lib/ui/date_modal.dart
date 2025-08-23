import 'package:flutter/material.dart';

Future<DateTime?> showDateModal(BuildContext context) async {
  final now = DateTime.now();
  return await showDatePicker(
    context: context,
    firstDate: now,
    lastDate: DateTime(now.year + 2),
    initialDate: now,
  );
}