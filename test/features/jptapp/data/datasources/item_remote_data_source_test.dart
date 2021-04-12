import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_remote_data_source.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ItemRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ItemRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('item'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getItem', () {
    final tItemModel = itemFromJson(fixture('item'));

    test(
      'should perform a GET request on a URL with item being the endpoint and with applicaton/json header ',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getItems();
        // assert
        verify(mockHttpClient.get(
            'https://studyproject-5bc52-default-rtdb.europe-west1.firebasedatabase.app/data/.json',
            headers: {'Content-Type': 'application/json'}));
      },
    );

    test(
      'should return Item when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getItems();
        // assert
        expect(result, equals(tItemModel));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = dataSource.getItems;
        // assert
        expect(() => call(), throwsA(isA<ServerException>()));
      },
    );
  });
}
