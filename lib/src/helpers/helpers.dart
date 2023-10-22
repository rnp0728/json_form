// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDate(String inputDate) {
  DateTime dateTime = DateFormat('dd-MM-yyyy').parse(inputDate);
  String outputDate = DateFormat('yyyy-MM-dd').format(dateTime);

  return outputDate;
}

extension IntExtension on int? {
  int validate({int value = 0}) {
    return this ?? value;
  }

  Widget get height => SizedBox(
        height: this?.toDouble(),
      );

  Widget get width => SizedBox(
        width: this?.toDouble(),
      );
}

class StoreData {
  final Alignment buttonAlignment;
  final Color buttonColor;
  final Color buttonTextColor;
  const StoreData({
    required this.buttonAlignment,
    required this.buttonColor,
    required this.buttonTextColor,
  });
}
