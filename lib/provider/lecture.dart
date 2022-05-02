import 'package:flutter/material.dart';

class Lecture with ChangeNotifier {
  final int id;
  final String name;
  final int level;
  final int category;

  Lecture(
      {required this.id,
      required this.name,
      required this.level,
      required this.category});
}
