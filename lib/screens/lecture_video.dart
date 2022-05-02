import 'package:e_learning/widgets/video_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/videos.dart';

class LectureVideo extends StatefulWidget {
  const LectureVideo({Key? key}) : super(key: key);
  static const routeName = '/lecture-video';

  @override
  State<LectureVideo> createState() => _LectureVideoState();
}

class _LectureVideoState extends State<LectureVideo> {
  bool isLoading = false;
  int? id;
  int? index;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Future.delayed(
      Duration.zero,
      () {
        id = ModalRoute.of(context)!.settings.arguments as int;
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Videos>(context, listen: false)
        .fetchAndSetProducts(context, id.toString());
  }

  @override
  Widget build(BuildContext context) {
    print('screen builede');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Lecture Content',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : FutureBuilder(
                future: _refreshProducts(context),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Consumer<Videos>(
                          builder: (ctx, productsData, _) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: productsData.items.length,
                                  itemBuilder: (_, i) => VideoItem(
                                    imgUrl: productsData.items[i].imgUrl ?? '',
                                    index: productsData.items[i].index,
                                    text: productsData.items[i].text,
                                    videoUrl:
                                        productsData.items[i].videoUrl ?? '',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: const Center(
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                            fontSize: 25, color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xff6ee2f5),
                                          Color(0xff6454f0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
      ),
    );
  }
}
