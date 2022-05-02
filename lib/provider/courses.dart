import 'dart:convert';

import 'package:e_learning/provider/course.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../widgets/app_popup.dart';

class Courses with ChangeNotifier {
  late List<Course> _items = [];

  List<Course> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts(BuildContext context) async {
    const baseUrl = 'http://18.198.107.110/api';
    var url = Uri.parse('$baseUrl/categories');
    print(url);
    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body);
      if (response.statusCode == 200) {
        final List<Course> loadedProducts = [];
        extractedData.forEach((prodData) {
          loadedProducts.add(
            Course(
                id: prodData['id'],
                name: prodData['name'],
                imgUrl: prodData['image']),
          );
        });
        _items = loadedProducts;
      } else {
        AppPopup.showMyDialog(context,
            (json.decode(response.body)['error'] as List<dynamic>?)?.first);
        _items = [];
      }

      // print(extractedData);

      // final List<Course> loadedProducts = [];
      // extractedData.forEach((prodData) {
      //   loadedProducts.add(
      //     Course(
      //         id: prodData['id'],
      //         name: prodData['name'],
      //         imgUrl: prodData['image']),
      //   );
      // });
      // _items = loadedProducts;
      // print(items);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}

class AppConstants {}
