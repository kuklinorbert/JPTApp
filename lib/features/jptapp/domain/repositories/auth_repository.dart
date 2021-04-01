import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> login(LoginModel login);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> checkAuth();
}
