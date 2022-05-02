import 'package:e_learning/provider/lectures.dart';
import 'package:e_learning/widgets/lecture_item.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    Key? key,
  }) : super(key: key);
  static const routeName = '/course-details';

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isLoading = false;
  int? id;

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
    await Provider.of<Lectures>(context, listen: false)
        .fetchAndSetProducts(context, id.toString());
  }

  @override
  Widget build(BuildContext context) {
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
            'Lessons',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : FutureBuilder(
                future: _refreshProducts(context),
                builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () => _refreshProducts(context),
                            child: Consumer<Lectures>(
                              builder: (ctx, productsData, _) => Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(4),
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemExtent: 100,
                                      itemCount: productsData.items.length,
                                      itemBuilder: (_, i) => Column(
                                        children: [
                                          LectureItem(
                                            name: productsData.items[i].name,
                                            id: productsData.items[i].id,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
              ),
      ),
    );
  }
}
