import 'dart:convert';

import 'package:e_learning/screens/course_details.dart';
import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  final int id;
  final String name;
  final String imgUrl;

  const CourseItem(
      {Key? key, required this.id, required this.name, required this.imgUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    const baseUrl = 'http://18.198.107.110';

    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, CourseDetails.routeName, arguments: id);
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // gradient: const LinearGradient(
            //   colors: [
            //     Color(0xffFF2CDF),
            //     Color(0xff00E5FF),
            //   ],
            // ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage('$baseUrl$imgUrl'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    utf8.decode(name.runes.toList()),
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
