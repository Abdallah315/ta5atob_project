import 'package:flutter/material.dart';

class Video with ChangeNotifier {
  final int id;
  final int index;
  final String text;
  final String? videoUrl;
  final String? imgUrl;
  final int lecture;
  Video(
      {required this.id,
      required this.imgUrl,
      required this.index,
      required this.lecture,
      required this.text,
      required this.videoUrl});
}
