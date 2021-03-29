import 'package:dartz/dartz.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, bool>> login(LoginModel login);
}
