import 'package:jptapp/features/jptapp/data/datasources/login_user_data_source.dart';
import 'package:jptapp/features/jptapp/domain/entities/login_model.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:jptapp/features/jptapp/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginUser loginUser;

  LoginRepositoryImpl(this.loginUser);

  @override
  Future<Either<Failure, bool>> login(LoginModel login) async {
    try {
      final user = await loginUser.login(login);
      return Right(user != null);
    } catch (exception) {
      return Left(ServerFailure());
    }
  }
}
