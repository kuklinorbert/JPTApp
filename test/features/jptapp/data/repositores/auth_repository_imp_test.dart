import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jptapp/core/error/failure.dart';
import 'package:jptapp/core/network/network_info.dart';
import 'package:jptapp/features/jptapp/data/models/login_model.dart';
import 'package:jptapp/features/jptapp/data/repositories/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

import 'item_repository_impl_test.dart';

void main() {
  AuthRepositoryImpl authRepositoryImpl;
  MockNetworkInfo mockNetworkInfo;
  FirebaseAuth firebaseAuth;

  setUp(() {
    firebaseAuth = FirebaseAuth.instance;
    mockNetworkInfo = mockNetworkInfo;
    authRepositoryImpl = AuthRepositoryImpl(networkInfo: mockNetworkInfo);
  });

  group('Login User', () {
    final LoginModel tLogin = LoginModel(email: "bad", password: "login");
    final LoginModel tLoginCorrect =
        LoginModel(email: "test@test.com", password: "testpw");
    Future<Either<Failure, UserCredential>> user;

    test('Should return true if auth correct', () async {
      //arrange
      when(authRepositoryImpl.login(tLoginCorrect))
          .thenAnswer((_) async => user);
      //act
      final result = await authRepositoryImpl.login(tLoginCorrect);
      //assert
      expect(result, Right(firebaseAuth.currentUser));
    });

    test('Should return false if auth is not correct', () async {
      //arrange
      when(authRepositoryImpl.login(tLoginCorrect))
          .thenAnswer((_) async => null);
      //act
      final result = await authRepositoryImpl.login(tLogin);
      //assert
      expect(result, Right(false));
    });
  });
}
