import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';

class Logout extends UseCase<void, NoParams> {
  final AuthRepository repository;

  Logout(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await repository.logout();
  }
}
