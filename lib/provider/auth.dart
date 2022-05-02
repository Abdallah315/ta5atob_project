import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/app_popup.dart';

class Auth with ChangeNotifier {
  var headers = {'Content-Type': 'application/json'};

  String? _token;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    return _token;
  }

  Future<void> signup(
      {required BuildContext context,
      required String email,
      required String password,
      required String userName,
      required String name}) async {
    final url = Uri.parse('http://18.198.107.110/api/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'email': email,
            'username': userName,
            'password': password,
            'name': name,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 201) {
        _token = responseData['token'];

        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
          },
        );
        prefs.setString('userData', userData);
      } else {
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }
      // _token = responseData['token'];
      // print(responseData);
      // notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(
      //   {
      //     'token': _token,
      //   },
      // );
      // prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(
      BuildContext context, String userName, String password) async {
    final url = Uri.parse('http://18.198.107.110/api/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'username': userName,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        _token = responseData['token'];
        print('$_token deh token gdeeda');

        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode(
          {
            'token': _token,
          },
        );
        print(userData);
        prefs.setString('userData', userData);
      } else {
        AppPopup.showMyDialog(
            context, (responseData['error'] as List<dynamic>?)?.first);
      }

      // print(responseData);
      // _token = responseData['token'];

      // notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode(
      //   {
      //     'token': _token,
      //   },
      // );
      // print(userData);
      // prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> tryAutoLogin() async {
    print('auto login');
    final prefs = await SharedPreferences.getInstance();
    print(prefs.containsKey('userData'));
    if (!prefs.containsKey('userData') && token != null) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    _token = extractedUserData['token'];
    print('$_token deh mn taaaaaaaaaaaaaaaaaaaa7t');
    notifyListeners();
    print('auto login ta7t');

    return true;
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
