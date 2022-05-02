import 'package:e_learning/provider/courses.dart';
import 'package:e_learning/provider/lectures.dart';
import 'package:e_learning/provider/videos.dart';
import 'package:e_learning/screens/auth_screen.dart';
import 'package:e_learning/screens/course_details.dart';
import 'package:e_learning/screens/home_page.dart';
import 'package:e_learning/screens/lecture_video.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider.value(value: Courses()),
        ChangeNotifierProvider.value(value: Lectures()),
        ChangeNotifierProvider.value(value: Videos())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: auth.isAuth
              ? const HomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : AuthScreen(),
                ),
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            CourseDetails.routeName: (context) => const CourseDetails(),
            LectureVideo.routeName: (context) => const LectureVideo(),
          },
        ),
      ),
    );
  }
}
