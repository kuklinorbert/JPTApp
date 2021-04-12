import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:jptapp/core/error/exceptions.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_local_data_source.dart';
import 'package:jptapp/features/jptapp/data/datasources/item_remote_data_source.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource remoteDataSource;
  final ItemLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ItemRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.networkInfo,
      @required this.localDataSource});

  Future<Either<Failure, Map<String, Item>>> getItem() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteItem = await remoteDataSource.getItems();
        localDataSource.cacheItem(remoteItem);
        return Right(remoteItem);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localItems = await localDataSource.getItems();
        return Right(localItems);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
