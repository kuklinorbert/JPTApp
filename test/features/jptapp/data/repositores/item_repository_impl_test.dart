import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_remote_data_source.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/repositories/item_repository_impl.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockRemoteDataSource extends Mock implements ItemRemoteDataSource {}

class MockLocalDataSource extends Mock implements ItemLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  ItemRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ItemRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getItem', () {
    final tItemModel = itemFromJson(fixture('item'));

    final Map<String, Item> tItem = tItemModel;

    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        repository.getItem();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getItems())
              .thenAnswer((_) async => tItemModel);
          // act
          final result = await repository.getItem();
          // assert
          verify(mockRemoteDataSource.getItems());
          expect(result, equals(Right(tItem)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getItems())
              .thenAnswer((_) async => tItemModel);
          // act
          await repository.getItem();
          // assert
          verify(mockRemoteDataSource.getItems());
          verify(mockLocalDataSource.cacheItem(tItem));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getItems()).thenThrow(ServerException());
          // act
          final result = await repository.getItem();
          // assert
          verify(mockRemoteDataSource.getItems());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getItems())
              .thenAnswer((_) async => tItemModel);
          // act
          final result = await repository.getItem();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getItems());
          expect(result, equals(Right(tItem)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockLocalDataSource.getItems()).thenThrow(CacheException());
          // act
          final result = await repository.getItem();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getItems());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
