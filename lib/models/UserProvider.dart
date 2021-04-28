import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_blog_app/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  Future<void> login(
      {required String username, required String password}) async {
    await EasyLoading.show();
    try {
      var dio = Dio();
      var url = Env.base + Env.authURL;
      var response = await dio
          .post(url, data: {"username": username, "password": password});

      var accessToken = response.data['access'];

      var preference = await SharedPreferences.getInstance();
      await preference.setString("username", username);
      await preference.setString("password", password);
      await preference.setString("access", accessToken);

      await EasyLoading.dismiss();
    } catch (err) {
      await EasyLoading.showError(err.toString());
      await Future.delayed(Duration(seconds: 2));
      await EasyLoading.dismiss();
      rethrow;
    }
  }

  static Future<String> getAuthToken() async {
    var preference = await SharedPreferences.getInstance();
    var token = preference.getString("access");
    if (token != null) {
      return "Bearer " + token;
    } else {
      throw Exception("No Access Token Found");
    }
  }

  /// Auto login if password and username set
  Future<void> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? username = preferences.getString("username");
    String? password = preferences.getString("password");

    if (username != null && password != null) {
      await login(username: username, password: password);
    }
  }
}
