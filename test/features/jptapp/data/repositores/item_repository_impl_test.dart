import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_remote_data_source.dart';
import 'package:jptapp/features/jptapp/data/models/html_tag_model.dart';
import 'package:jptapp/features/jptapp/data/models/item_model.dart';
import 'package:jptapp/features/jptapp/data/models/pdf_link_model.dart';
import 'package:jptapp/features/jptapp/data/repositories/item_repository_impl.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:mockito/mockito.dart';

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
    mockNetworkInfo = MockNetworkInfo();
    repository = ItemRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getItem', () {
    final tItemModel = {
      'testid': ItemModel(
        title: 'Test',
        pdfLinks: [
          PdfLinkModel(title: 'test', link: 'testtest'),
        ],
        htmlTags: [
          HtmlTagModel(title: 'test', html: 'testtest'),
        ],
      )
    };

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

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockRemoteDataSource.getItem())
              .thenAnswer((_) async => tItemModel);
          // act
          final result = await repository.getItem();
          // assert
          verify(mockRemoteDataSource.getItem());
          expect(result, equals(Right(tItemModel)));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getItem()).thenThrow(ServerException());
          // act
          final result = await repository.getItem();
          // assert
          verify(mockRemoteDataSource.getItem());
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
