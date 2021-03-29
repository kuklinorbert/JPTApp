import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';

abstract class ItemRepository {
  Future<Either<Failure, Map<String, Item>>> getItem();
}
