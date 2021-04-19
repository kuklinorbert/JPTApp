import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class DownloadDataSource {
  Future<Response> getDownloadResponse(
      String url, String saveDir, String fileName);
}

class DownloadDataSourceImpl implements DownloadDataSource {
  final Dio dio;

  DownloadDataSourceImpl({@required this.dio});
  @override
  Future<Response> getDownloadResponse(
      String url, String saveDir, String fileName) async {
    try {
      final savePath = saveDir + "/" + fileName + ".pdf";
      final response = await dio.download(url, savePath);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception();
      }
    } on Exception {
      throw Exception();
    }
  }
}
