import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/exceptions.dart';

import 'package:http/http.dart' as http;
import 'package:jptapp/features/jptapp/data/models/item_model.dart';

abstract class ItemRemoteDataSource {
  Future<Map<String, ItemModel>> getItems();
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final http.Client client;

  ItemRemoteDataSourceImpl({@required this.client});

  @override
  Future<Map<String, ItemModel>> getItems() => _getItemFromUrl(
      'https://studyproject-5bc52-default-rtdb.europe-west1.firebasedatabase.app/data/.json');

  Future<Map<String, ItemModel>> _getItemFromUrl(String url) async {
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return itemFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
