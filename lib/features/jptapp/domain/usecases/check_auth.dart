import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/usecases/usecase.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';

class CheckAuth extends UseCase<void, NoParams> {
  final AuthRepository repository;

  CheckAuth(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    return await repository.checkAuth();
  }
}
