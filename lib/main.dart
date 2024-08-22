import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/application.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const Application());
}
