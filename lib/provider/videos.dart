import 'dart:convert';

import 'package:e_learning/provider/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_popup.dart';

class Videos with ChangeNotifier {
  late List<Video> _items = [];

  List<Video> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts(BuildContext context, dynamic id) async {
    var url = Uri.parse('http://18.198.107.110/api/lecture/${id.toString()}');
    // try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);

      final List<Video> loadedProducts = [];
      extractedData.forEach((prodData) {
        loadedProducts.add(Video(
            id: prodData['id'],
            imgUrl: prodData['image_url'],
            index: prodData['index'],
            lecture: prodData['lecture'],
            text: prodData['text'],
            videoUrl: prodData['video_url']));
      });
      _items = loadedProducts;
    } else {
      AppPopup.showMyDialog(context,
          (json.decode(response.body)['error'] as List<dynamic>?)?.first);
      _items = [];
    }

    // final extractedData = json.decode(response.body);

    // final List<Video> loadedProducts = [];
    // extractedData.forEach((prodData) {
    //   loadedProducts.add(Video(
    //       id: prodData['id'],
    //       imgUrl: prodData['image_url'],
    //       index: prodData['index'],
    //       lecture: prodData['lecture'],
    //       text: prodData['text'],
    //       videoUrl: prodData['video_url']));
    // });
    // _items = loadedProducts;
    // print(items);
    notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
  }
}
