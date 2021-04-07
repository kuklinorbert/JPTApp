import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ItemLocalDataSource {
  Future<Map<String, ItemModel>> getLastItems();
  Future<void> cacheItem(Map<String, ItemModel> itemToCache);
}

const CACHED_ITEM = 'CACHED_ITEM';

class ItemLocalDataSourceImpl implements ItemLocalDataSource {
  final SharedPreferences sharedPreferences;

  ItemLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheItem(Map<String, ItemModel> itemToCache) {
    return sharedPreferences.setString(CACHED_ITEM, itemToJson(itemToCache));
  }

  @override
  Future<Map<String, ItemModel>> getLastItems() {
    final jsonString = sharedPreferences.getString(CACHED_ITEM);
    if (jsonString != null) {
      return Future.value(itemFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }
}
