import 'package:e_learning/provider/auth.dart';
import 'package:e_learning/widgets/course_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/courses.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Courses>(context, listen: false)
        .fetchAndSetProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => Provider.of<Auth>(context, listen: false).logout(),
                child: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            )
          ],
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Courses>(
                        builder: (ctx, productsData, _) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'الأمراض',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                    ),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: productsData.items.length,
                                    itemBuilder: (_, i) => CourseItem(
                                      id: productsData.items[i].id,
                                      name: productsData.items[i].name,
                                      imgUrl: productsData.items[i].imgUrl,
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
