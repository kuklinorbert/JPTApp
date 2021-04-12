import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  ItemLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ItemLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getItem', () {
    final tNumberTriviaModel = itemFromJson(fixture('item'));

    test(
      'should return Item from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(fixture('item'));
        // act
        final result = await dataSource.getItems();
        // assert
        verify(mockSharedPreferences.getString(CACHED_ITEM));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getItems;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheItem', () {
    final tItemModel = itemFromJson(fixture('item'));

    test(
      'should call SharedPreferences to cache the data',
      () async {
        // act
        dataSource.cacheItem(tItemModel);
        // assert
        final expectedJsonString = itemToJson(tItemModel);
        verify(mockSharedPreferences.setString(
          CACHED_ITEM,
          expectedJsonString,
        ));
      },
    );
  });
}
