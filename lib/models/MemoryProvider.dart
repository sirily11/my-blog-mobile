import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_blog_app/env/env.dart';
import 'package:my_blog_app/objects/Memory.dart';

class MemoryProvider with ChangeNotifier {
  String? nextURL;
  List<Memory> memories = [];
  late Dio dio;

  MemoryProvider() {
    dio = Dio();
  }

  Future<void> refresh() async {
    await EasyLoading.show();
    try {
      var url = Env.base + Env.memoryURL;
      var response = await dio.get(url);
      var m = (response.data['results'] as List)
          .map((e) => Memory.fromJson(e))
          .toList();
      nextURL = response.data['results'];

      memories = m;
      notifyListeners();
    } catch (err) {
      EasyLoading.showError(err.toString());
      await Future.delayed(Duration(seconds: 2));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> fetchMore() async {
    await EasyLoading.show();
    try {
      if (nextURL == null) {
        return;
      }
      var response = await dio.get(nextURL!);
      var m = (response.data['results'] as List)
          .map((e) => Memory.fromJson(e))
          .toList();
      nextURL = response.data['results'];
      memories.addAll(m);
      notifyListeners();
    } catch (err) {
      EasyLoading.showError(err.toString());
      await Future.delayed(Duration(seconds: 2));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<Memory?> addMemory({required Memory memory}) async {}

  Future<void> addMemoryImageToMemory(
      {required int memoryID, required File image}) async {}

  Future<void> deleteMemory({required Memory memory}) async {}
}
