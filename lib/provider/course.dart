import 'package:flutter/cupertino.dart';

class Course with ChangeNotifier {
  final int id;
  final String name;
  final String imgUrl;

  Course({required this.id, required this.name, required this.imgUrl});
}
