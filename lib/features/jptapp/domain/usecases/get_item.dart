import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/entities/item.dart';
import 'package:jptapp/features/jptapp/domain/repositories/item_repository.dart';

class GetItem extends UseCase<Map<String, Item>, NoParams> {
  final ItemRepository repository;

  GetItem(this.repository);

  @override
  Future<Either<Failure, Map<String, Item>>> call(NoParams) async {
    return await repository.getItem();
  }
}
