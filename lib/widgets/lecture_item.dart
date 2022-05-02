import 'package:e_learning/screens/lecture_video.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show utf8;

class LectureItem extends StatelessWidget {
  String name;
  int id;
  LectureItem({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(LectureVideo.routeName, arguments: id);
      },
      child: SizedBox(
        child: ListTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              utf8.decode(name.runes.toList()),
              textDirection: TextDirection.rtl,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xff6ee2f5),
                  Color(0xff6454f0),
                ],
              ),
            ),
          ),
          trailing: SizedBox(
            width: 120,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {},
              color: Theme.of(context).primaryColor,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
}
