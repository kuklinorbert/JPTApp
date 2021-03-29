import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/exceptions.dart';

import 'package:http/http.dart' as http;
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';

abstract class ItemRemoteDataSource {
  Future<Map<String, ItemModel>> getItem();
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final http.Client client;

  ItemRemoteDataSourceImpl({@required this.client});

  @override
  Future<Map<String, ItemModel>> getItem() => _getItemFromUrl(
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
