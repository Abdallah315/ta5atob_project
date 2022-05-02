import 'dart:convert';

import 'package:e_learning/provider/lecture.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_popup.dart';

class Lectures with ChangeNotifier {
  late List<Lecture> _items = [];

  List<Lecture> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts(BuildContext context, dynamic id) async {
    var url = Uri.parse('http://18.198.107.110/api/category/${id.toString()}');
    print(url);
    // try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);

      final List<Lecture> loadedProducts = [];
      extractedData.forEach((prodData) {
        loadedProducts.add(Lecture(
            id: prodData['id'],
            name: prodData['name'],
            level: prodData['level'],
            category: prodData['category']));
      });
      _items = loadedProducts;
    } else {
      AppPopup.showMyDialog(context,
          (json.decode(response.body)['error'] as List<dynamic>?)?.first);
      _items = [];
    }

    // final extractedData = json.decode(response.body);

    // final List<Lecture> loadedProducts = [];
    // extractedData.forEach((prodData) {
    //   loadedProducts.add(Lecture(
    //       id: prodData['id'],
    //       name: prodData['name'],
    //       level: prodData['level'],
    //       category: prodData['category']));
    // });
    // _items = loadedProducts;
    // print(items);
    notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
  }
}
