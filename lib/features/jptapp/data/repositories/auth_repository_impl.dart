import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:jptapp/features/jptapp/domain/entities/user.dart';
import 'package:jptapp/features/jptapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({firebase_auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  @override
  Future<Either<Failure, firebase_auth.UserCredential>> login(
      LoginModel login) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: login.email,
        password: login.password,
      );
      return Right(result);
    } on Exception {
      return Left(LogInFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await Future.wait([_firebaseAuth.signOut()]);
      return Right(result);
    } on Exception {
      return Left(LogOutFailure());
    }
  }

  @override
  Future<Either<Failure, firebase_auth.User>> checkAuth() async {
    try {
      final result = firebase_auth.FirebaseAuth.instance.currentUser;
      if (result != null) {
        return Right(result);
      } else {
        throw Exception();
      }
    } on Exception {
      return Left(CheckAuthFailure());
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email);
  }
}
